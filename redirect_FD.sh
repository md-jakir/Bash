# This scipt will read a file rediect to output file with file discriptor
# No need to write redirect statement in script.

#!/bin/bash
display_hosts_file ()
{
OUTFILE=/root/hostsout.txt
INFILE=/etc/hosts
>$OUTFILE
exec 3<&1   # Redirect stdout to a file descriptor 3
exec 1> $OUTFILE
while read LINE
do
        echo "$LINE"
        :
done < $INFILE
exec 1<&3
exec 3>&-
}
display_hosts_file
