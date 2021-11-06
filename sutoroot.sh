# It is script for switching from non-root user to root user locally. 

#!/bin/bash
set -x
if [ `id -nu` != root ]; then
    sudo -i # Re-run this script as user diy
#else
    # Everything you want to do goes here
fi
