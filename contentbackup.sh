#!/bin/bash
srcdir=/var/www/vhosts/
#srcdir=/test/backup/
destdir=/var/www/vhosts/default/htdocs/backup/
#destdir=/test/content/
        m=0; max=59
        while [ $m -le $max ]; do
                   cd $srcdir; src=(*/)
                      if [ -d ${src[$m]} ]; then
                                owner1=$(ls -ld ${src[$m]} | awk '{print $3}')
                                c=0; locmax=40
                while [ $c -le $locmax ]; do
                                cd $destdir; dest=(*/)
                         if [ -d ${dest[$c]} ]; then
                                owner=$(ls -ld ${dest[$c]} | awk '{print $3}')
                            if [ $owner = $owner1 ]; then
                                cd $srcdir"${src[$m]}"
                               if [ -e "httpdocs" ]; then
                                   ((tar cjf httpdocs_`date +"%d-%m-%Y"`.tbz2 httpdocs/ && mv httpdocs_`date +"%d-%m-%Y"`.tbz2 $destdir"${dest[$c]}") &)
                            fi
                        fi
                    fi
                    c=$[$c+1]
               done
           fi
          m=$[$m+1]
      done
