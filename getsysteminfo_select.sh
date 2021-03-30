# This script will provide a manu for getting informating about system or process

#!/bin/bash
clear
echo -e "\n\tSYSTEM INFORMATION MANU\n"

PS3="Select an option and press enter: "

select i in OS Host Filesystems Date Users Mem CPU EstblishConnection Quit
do
        case $i in

        OS)     echo
                uname
                ;;
        Host)   echo
                hostnamectl
                ;;
        Filesystems)
                echo
                df -hT |more
                ;;
        Date)   echo
                timedatectl
                ;;
        Users)  echo
                who
                ;;
        Mem)    echo
                free -h
                ;;
        CPU)    echo
                lscpu
                ;;
        EstblishConnection)
                echo
                lsof -i@192.168.56.115
                ;;
        Quit)   break
                ;;
     esac
     REPLY=
     echo -e "\nPress Enter to continue.......\c"
     read
     clear
     echo -e "\n\tSYSTEM INFORMATION MANU\n"
     done
     clear
