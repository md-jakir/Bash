#$ cat bashparameterexample.sh

#!/bin/bash

if [ $# -lt 2 ]   #-- $# is used for number of arguments

then

  echo "Usage: $0 arg1 arg2"

  exit

fi

echo -e  "\$1=$1" #-- $1 is used to access first parameter

echo -e "\$2=$2"  #-- $2 is used to access second parameter

#Read more: https://javarevisited.blogspot.com/2011/06/special-bash-parameters-in-script-linux.html#ixzz5wIMFn5O8

