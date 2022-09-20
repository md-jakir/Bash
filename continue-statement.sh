#!/bin/bash

i=0
while [[ $i -lt 5 ]]; do
      ((i++))
      if [[ "$i" == '2' ]]; then
             continue
       fi
 echo "Number: $i"
done

Output: 

Number: 1

Number: 3

Number: 4

Number: 5

