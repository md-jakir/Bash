# This expect script will enable or disable cronjob on remote machine using pattern matching

#!/usr/bin/expect -f
        set timeout 300
        #spawn /usr/bin/scp -r -P 22 /root/expect-script/timeread.sh root@192.168.56.108:/root
        spawn ssh root@192.168.56.108
        expect "password:"
        send "********\r"
        expect "#"
        send "crontab -l | sed '/This is test execution/s/^/#/' | crontab - \r"
        expect "#"
        send "exit\r"
        expect eof
