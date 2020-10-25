#!/bin/bash

src_dir=/root/month/
#mv=/root/newback/
src1=/backup/otrs/backup/
dest=/mnt/newbackup/OTRS/

 max=4; c=0
    while [ $c -le $max ]; do
                cd $src_dir
                src=(*)
          if [ "${src[$c]}" == "${src[$c]}" ]; then
                # cd $mv; mkdir ${src[$c]}
                cd $src1;
                ((find . -type d -name "*${src[$c]}*" -exec mv {} $dest \; &> /dev/null) &)
                #echo "*${src[$c]}*"
          fi
        c=$[$c+1]
    done
