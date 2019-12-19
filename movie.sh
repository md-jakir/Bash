#!/bin/bash
PS3="Select a movie: "
select movie in {Shrek,Gremlins}" "{1,2}          \
    {"Back To The Future","Toy Story"}" "{1,2,3}  \
    "Star Wars "{1..9}
do
  echo "You chose: \"$movie\""
done
