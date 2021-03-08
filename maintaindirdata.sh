# This script actually remove backup IPLog data from bunch of directory 



#!/bin/bash
path=/media/content/nfsen-backup/live.backup
    cd $path
    dirc=$(ls |wc -l)
    finc=`expr $dirc - 1`
        #echo $finc
    tdir=$(ls $path)
    array=($tdir)
        c=0
        #for i in ${array[@]}; do
         while [ $c -le $finc ]; do
              #if [ "${array[$c]}" == "${array[$c]}" ]; then
                 #echo ${array[0]}
                 childir=$(ls $path/${array[0]})
                 childarr=($childir)
                 #echo ${childarr[0]}
                 enddir=$(ls $path/${array[0]}/${childarr[0]})
                 endarr=($enddir)
                 rm -rf $path/${array[0]}/${childarr[0]}/${endarr[0]}
                 exit
              #fi
            c=$[$c+1]
        done
