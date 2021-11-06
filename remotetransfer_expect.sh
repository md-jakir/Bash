#!/bin/bash
echo "Port is desired: "
if [ "$1" = "ssh port" ]; then
        {
        /usr/bin/expect << EOF
        set timeout 300
        spawn scp -r -P $1 xyz@www.example.com:/home/xyz/CRM_DB_backup/database_name_`date +\%F\-\%H`.tbz2 /mnt/slave/CRM_DB_Backup
        expect "password:"
        send "**********"
        expect "*#*"
EOF
}
        find /mnt/slave/CRM_DB_Backup/ -type f -name "*.tbz2" -mtime +40 -exec rm -rf {} \;
fi

