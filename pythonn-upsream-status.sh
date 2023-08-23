echo "== Debug: environment variables starts ==" 
env
echo "== Debug: environment variables end ==" 

NOW=$(date +'%Y%m%d%H%M')

DEPLOY_NAME=${USER}/${PROJECT_NAME}
curl -u $DEPLOY_USER:$DEPLOY_PASS "${PROJECT_URL}/lastStableBuild/api/json" > /tmp/${PROJECT_NAME}.json

upstream_variable ()
{
VAR=$1
python <<EOF
import json
f=open('/tmp/${PROJECT_NAME}.json')
project=json.load(f)
f.close()
var=""
parms = [ action["parameters"] for action in project['actions'] if "parameters" in action ][0]
for parm in parms:
    if parm["name"] == "$VAR":
        var = parm["value"]
if var == '\${BUILD_NUMBER}':
    var = project["number"]
print var
EOF
}       # ----------  end of function upstream_variable  ----------

upstream_status ()
{
python <<EOF
import json
f=open('/tmp/${PROJECT_NAME}.json')
project=json.load(f)
f.close()
print project['result']
EOF
}       # ----------  end of function upstream_status  ----------

if [ "$TAG_DEPLOY" != "" ]; then
    # Loop until found the TAG in the build
    num=$(curl -u $DEPLOY_USER:$DEPLOY_PASS "${PROJECT_URL}/lastStableBuild/buildNumber")
    while [ 1 ]
    do
        tag=$(upstream_variable TAG)
        if [ "$tag" == "$TAG_DEPLOY" ]; then
            if [ $(upstream_status) == "SUCCESS" ]; then
                echo "Deploy build job: $num"
                break
            fi
        elif [ $num -le 1 ]; then
            echo "Didn't find TAG: ${TAG_DEPLOY}"
            exit 1
        else
            let num--
            curl -u $DEPLOY_USER:$DEPLOY_PASS "${PROJECT_URL}/${num}/api/json" > /tmp/${PROJECT_NAME}.json 2>/dev/null
        fi
    done
else
    TAG_DEPLOY=$(upstream_variable TAG)
fi

UPSTREAM_DEPLOY_HOST=$(upstream_variable DEPLOY_HOST)

BRANCH=$(upstream_variable BRANCH)                       ## changed branch variable

branch=$(cut -d '/' -f 2 <<< ${BRANCH})                  ##added line
TAGNAME=v.${NOW}.${branch}
TAGMESSAGE=$(upstream_variable TAGMESSAGE)

UPDATE_DOCKER_IMAGE=$(upstream_variable UPDATE_DOCKER_IMAGE)

AUTH=$(upstream_variable AUTH)

if [ "$DEPLOY_HOST" == "default" ]; then
    DEPLOY_HOST=${UPSTREAM_DEPLOY_HOST}
fi
if [ "$branch" == "" ]; then
    echo "Can not found branch in upstream job. Abort"
    exit 1
fi

SSH_CMD="ssh deploycode@${DEPLOY_HOST}"

export TAG
#[[ -z ${TAG_DEPLOY// } ]]  &&  TAG_DEPLOY=$(docker images ${DEPLOY_NAME} |sed '1d'|awk '{ if (max < $2) max=$2; } END { print max }' )
[[ -z ${TAG_DEPLOY// } ]] && TAG_DEPLOY=$TAG


${SSH_CMD} "cd ${PROJECT_NAME} && git checkout -b ${NOW} && git fetch origin && git reset --hard && git reset --hard ${BRANCH}"
${SSH_CMD} "cd ${PROJECT_NAME} && git checkout $branch && git branch -u ${BRANCH} && git merge ${BRANCH}"
${SSH_CMD} "cd ${PROJECT_NAME} && git tag -a $TAGNAME -m \"$TAGMESSAGE\" && git push --tags"

#Replace cd PATH from PROJECT_NAME to PROJECTX_OPS_NAME to read all ops settings.

if [ "$AUTH" == "off" ]; then
    ${SSH_CMD} "cd ${PROJECTX_OPS_NAME}; export AUTH=off; TAG=$TAG_DEPLOY make cleanproxy runproxy"
elif [ "$AUTH" == "on" ]; then
    ${SSH_CMD} "cd ${PROJECTX_OPS_NAME}; export AUTH=on; TAG=$TAG_DEPLOY make cleanproxy runproxy"
fi

if [ "${UPDATE_DOCKER_IMAGE,,}" == "true"  ]; then

	${SSH_CMD} "cd ${PROJECTX_OPS_NAME} && TAG=$TAG_DEPLOY make pull"

	TAG_RUNNING=$(${SSH_CMD} "docker ps |grep ${PROJECT_NAME}|rev|awk '{print \$1}'|rev|sed -n \"s/${PROJECT_NAME}-\(.*\)\$/\1/p\"" )

    if [ "${TAG_RUNNING}" != "" ]; then
    ${SSH_CMD} "cd ${PROJECTX_OPS_NAME} && TAG=$TAG_RUNNING make clean && TAG=$TAG_DEPLOY make rundev"
    else
    ${SSH_CMD} "cd ${PROJECTX_OPS_NAME} && TAG=$TAG_DEPLOY make rundev"
    fi

${SSH_CMD} << EOF
images=\$(docker images |grep "^${USER}/${PROJECT_NAME} " |sed -n '5,\$p'| awk '{ print \$1,\$2 }' |sed 's/ /:/'|grep -v ${USER}/${PROJECT_NAME}:${TAG_DEPLOY// } |xargs)  
echo "\$images"
if [ "\$images" != "" ]; then 
docker rmi \$images
fi
exit
EOF

fi
