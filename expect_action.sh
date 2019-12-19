#!/usr/bin/expect -f 
expect "hi" {send "you said $expect_out(buffer)"}
