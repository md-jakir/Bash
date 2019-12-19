#!/usr/bin/expect -f

set timeout $argv
expect "hi" {
	send [string trimright "$expect_out(buffer)" "\n"]
}	



