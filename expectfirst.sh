#!/usr/bin/expect -f 
#expect "hi"
#send "$expect_out(0,string) $expect_out(buffer)"

expect "hi" {send "you saind hi\n"} "hello" {send "Hello yourself\n"} "bye" {send "That was unexpected\n"} 
