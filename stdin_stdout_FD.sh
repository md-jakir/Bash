# Input & Output direction with file descriptor in bash program withoud mentioning rediection statement
# Don't need to mentions input file in bottom of loop
# Don't need to mention redirect statement inside loop 

#!/bin/bash
display_hosts_file ()
{
OUTFILE=/root/hostsout.txt
INFILE=/etc/hosts
>$OUTFILE
exec 4<&1
exec 0< $INFILE
exec 3<&1
exec 1> $OUTFILE
while read LINE
do
        echo "$LINE"
        :
done
exec 0<&4
exec 4>&-
exec 1<&3
exec 3>&-
}
display_hosts_file
