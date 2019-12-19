#!/usr/bin/expect -f

expect "hi*"
send "$expect_out(0,string) $expect_out(buffer)"

