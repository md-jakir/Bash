#!/bin/bash
status=$(pidof httpd >/dev/null && echo "Service is running" || echo "Service is not running")
                if [ "$status" = "Service is running" ]; then
                        exit
                   elif [ "$status" = "Service is not running" ]; then
                        systemctl restart httpd
                    else
                        echo "There is no issue"
                fi
