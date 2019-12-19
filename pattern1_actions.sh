#!/usr/bin/expect -f 

#expect {
expect "exit" {exit 1} "quit" abort
   "hi" {
	send "you said hi\n"
   }
    "hello"  {
	send "Hello yourself\n"
   }
    "bye"    {
	send "That was unexpected\n"
    }

