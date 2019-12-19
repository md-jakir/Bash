#!/usr/bin/expect -f

expect {
	"hi" { send "you said $expect_out(buffer)\n" } 
	"hello" { send "Hello yourself\n" } 
	"Bye" { send "That was unexpected\n" }
}	

