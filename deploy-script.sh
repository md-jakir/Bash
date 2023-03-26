#!/bin/bash
echo "Please choose below option to deploy the application"
echo
echo "1 - MyBL API"
echo "2 - CMS"
echo "3 - IDP"
echo
MyBlApi() {
	PATH=/home/bs1048/bl_cms
	echo "Please choose following options"
	echo
	echo "1 - MyBL API directory based deployment"
	echo "2 - MyBL API file based deployment"
	echo
	read -p "Please select which you want " deploy
	if [ "$deploy" -eq "1" ]; then
		read -p "Please enter directory: " dir
		cd $PATH
		if [ -e "$dir" ]; then
			IP=("172.16.254.196" "172.16.254.204" "172.16.254.205" "172.16.254.206" "172.16.254.2" "172.16.254.224" "172.16.254.108" "172.16.254.137" "172.16.254.147")
			DEST_PATH=/root/bl-proj/bl_cms
			maxip=8; c=0
			while [ $c -le $maxip ]; do
				echo "Deploying for Server: ${IP[$c]}"
				/usr/bin/scp -r $PATH/$dir/* root@${IP[$c]}:$DEST_PATH/$dir
				#/usr/bin/rsync -   avzt $PATH/$dir root@${IP[$c]}:/root/bl-proj/bl_cms/$dir
			c=$[$c+1]
			done
		else 
			echo "This is not exist"
		fi
	fi
	if [ "$deploy" -eq "2" ]; then
		read -p "Please enter file name: " f1
		cd $PATH
		if [ -e "$f1" ]; then
			IP=("192.168.56.102" "192.168.56.107")
			DEST_PATH=/root/bl-proj/bl_cms
			#for i in "${IP[@]}"; do
			maxip=1; c=0
			while [ $c -le $maxip ]; do
				/usr/bin/scp -r $PATH/$f1 root@${IP[$c]}:$DEST_PATH/$f1
				#/usr/bin/rsync -avzt $PATH/$f1 root@${IP[$c]}:/root/bl-proj/bl_cms/$f1
			c=$[$c+1]
			done
		else 
			echo "This is not exist"
		fi
	fi
}

BLCMS() {
	PATH='/app/assetlite/src/projects/projects_gitlab/bl_cms'
	echo "Please choose following options"
	echo
	echo "1 - BL CMS directory based deployment"
	echo "2 - BL CMS file based deployment"
	echo
	read -p "Please select which you want " deploy
	if [ "$deploy" -eq "1" ]; then
		read -p "Please enter directory: " dir
		cd $PATH
		if [ -e "$dir" ]; then
			IP=("172.16.8.164")
			DEST_PATH='/app/blcms/www/bl_cms'
			maxip=0; c=0
			while [ $c -le $maxip ]; do
				echo "Deploying for Server: ${IP[$c]}"
				#SERVER_IP='${IP[$c]}'
				#DIR='$dir'
				/usr/bin/scp -r $PATH/$dir/* root@${IP[$c]}:$DEST_PATH/$dir
				#/usr/bin/rsync -avz $PATH/$DIR/ root@$SERVER_IP:$DEST_PATH/'$DIR'
			c=$[$c+1]
			done
		else 
			echo "This is not exist"
		fi
	fi
	if [ "$deploy" -eq "2" ]; then
		read -p "Please enter file name: " f1
		cd $PATH
		if [ -e "$f1" ]; then
			IP=("172.16.8.164")
            DEST_PATH='/app/blcms/www/bl_cms'
			#for i in "${IP[@]}"; do
			maxip=0; c=0
			while [ $c -le $maxip ]; do
				/usr/bin/scp -r $PATH/$f1 root@${IP[$c]}:$DEST_PATH/$f1
				#/usr/bin/rsync -avzt $PATH/$f1 root@${IP[$c]}:/root/bl-proj/bl_cms/$f1
			c=$[$c+1]
			done
		else 
			echo "This is not exist"
		fi
	fi
}

read -p "Please choose from the above options: " APP
if [ "$APP" -eq "1" ]; then
read -p "Please ensure the application name: " API
	if [ "$APP" == "api" ]; then
		MyBlApi
	else
		echo "Your entry is not correct"
	fi
elif [ "$APP" -eq "2" ]; then
read -p "Please ensure the applicatoin name: " CMS
	if [ "$CMS" == "cms" ]; then
		BLCMS
	else
		echo "Your entry is not correct"
	fi
else
	echo "Your selection is wrong"
fi
