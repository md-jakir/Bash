# This script actually remove backup IPLog data from bunch of directory 
# Removing last directory in a directory loop 
# maintaining huge directory data in multiple directory 

    #!/bin/bash
    path=/media/content/nfsen-backup/live.backup
    dirc=$(ls $path |wc -l)
    finc=`expr $dirc - 1`
    tdir=$(ls $path)
    array=($tdir)
    c=0
    while [ $c -le $finc ]; do
           year=$(ls $path/${array[$c]})
           yearc=$(ls $path/${array[$c]} | wc -l)
           year_arr=($year)
           m=0; max=`expr $yearc - 1`
       while [ $m -le $max ]; do
              lsdir=$(ls $path/${array[$c]}/${year_arr[$m]})
              lsdir_arr=($lsdir)
              rm -rf "$path/${array[$c]}/${year_arr[$m]}/${lsdir_arr[0]}"
              m=$[$m+1]
       done

           c=$[$c+1]
    done


