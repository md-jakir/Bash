#!/bin/bash
	read -p "Enter the name your root directory : " classes
		mkdir -p /abc/test/$classes
		if [ -d "/abc/test/$classes" ]; then
			read -p "Enter the name of 1st subdirectory of CLASSES : " cis4932
			mkdir -p /abc/test/$classes/$cis4932
			read -p "Enter the name of 2nd subdirectory of CLASSES  : " cop3122
			mkdir -p /abc/test/$classes/$cop3122
			read -p "Enter the name of 3rd subdirectory of CLASSES  : " cis4321
			mkdir -p /abc/test/$classes/$cis4321
			read -p "Enter the name of 1st subdirectory of COP3122 : " hard
			mkdir -p  /abc/test/$classes/$cop3122/$hard
			read -p "Enter the name of 1st subdirectory of COP3122 : " painful
			mkdir -p /abc/test/$classes/$cop3122/$painful
		fi





