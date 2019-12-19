#!/bin/bash
#shopt -s dotglob
#shopt -s nullglob
dbpath=/jakir/script/test/
#locpath=/backup/
cd $dbpath
#cd $locpath
file_list=(*)
loc=(*)
max=11
#locmax=8
#while [ "$max" >= "$locmax" ]
#do
for ((count=0; count<=max; count++))
do
if [ -f "${file_list[$count]}" ]; then
#	echo "${file_list[$count]}"
	echo "${file_list[3]}"
#if [ -d "${loc[$cou]}" ]; then
#	echo "${loc[$cou]}"
#cp "${file_list[$count]}" 
	fi
#fi
done
#done
