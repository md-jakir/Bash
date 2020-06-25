#!/bin/bash
#multiple databases backup
#Backing up multiple databases for multiple websites in shared hosted server.
#And sharing to download for clients and send database to client's email.
dirpath=/path/to/backup/path/
dblist=/dbname/path/
email=/email/list/
log=/log/tmp2/error.log
        max=39; c=0
 while [ $c -le $max ]; do
        cd $dblist
        db=(*)
        if [ -f ${db[$c]} ]; then
           owner1=$(ls -l ${db[$c]} | awk '{print $3}')
                max1=26; i=0
            while [ $i -le $max1 ]; do
                  cd $dirpath
                  dir_list=(*/)
                   if [ -d ${dir_list[$i]} ]; then
                      owner=$(ls -ld ${dir_list[$i]} | awk '{print $3}')
                        if [ $owner1 = $owner ]; then
                           ((cd ${dir_list[$i]} && mysqldump -u username -p123 --opt ${db[$c]} > ${db[$c]}.sql && tar cjf ${db[$c]}_`date +"%d-%m-%Y"`.tbz2 ${db[$c]}.sql && rm -rf ${db[$c]}.sql 2>$log) &)
                                max2=25; m=0
                        while [ $m -le $max2 ]; do
                            cd $email; send=(*)
                                if [ -f ${send[$m]} ]; then
                                   owner2=$(ls -l ${send[$m]} | awk '{print $3}')
                                        if [ $owner = $owner2 ]; then
                                   cd $dirpath"${dir_list[$i]}"
                                        if [ -e ${db[$c]}_`date +"%d-%m-%Y"`.tbz2 ]; then
                                                echo  "Dear Sir,You are requested to save your databases and web content from "http://www.example.com/backup/${dir_list[$i]}" and these documents won't be longer in server more than two months once you received. if you unable to access the location then please provide us your network IP. If have any query you can contact with us through abc@example.com." | mailx -s "Database & content Backup" ${send[$m]}
                                    fi
                              fi
                        fi
                         m=$[$m+1]
                    done
                fi
           fi
           i=$[$i+1]
        done
   fi
   c=$[$c+1]
done

