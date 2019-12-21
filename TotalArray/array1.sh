#Array making taking all files and directories in a particular directory.
path=/root/test/
cd $path; dir=(*)
echo ${dir[0]}
echo ${dir[1]}
echo ${dir[2]}
echo ${dir[3]}
echo ${dir[4]}
