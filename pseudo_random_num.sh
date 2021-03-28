## Here, $$ is process ID of the script itself

#!/bin/bash

RANDOM=$$
UPER_LIMIT=$1

RANDOM_NUMBER=$(($RANDOM % $UPER_LIMIT + 1))
echo "$RANDOM_NUMBER"
