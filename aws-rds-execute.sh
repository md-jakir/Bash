#!/bin/bash
echo "Which you want to do?"
echo
echo "1 - DB Backup"
echo "2 - Table Backup"
echo "3 - DB Restore"
echo "4 - Table Restore"
echo "5 - Table Rename"
echo
TableBakcup() {
	PATH=/home/ubuntu
	DB_HOST=database-1.ciahw21bdnzz.ap-south-1.rds.amazonaws.com
	DB_USER=*****
	DB_PASS=*********
	echo "Do you want to take Table Backup?"
	echo
	echo "1 - YES"
	echo "2 - NO"
	echo
	read -p "Please Select from the above options: " option
	if [ "$option" -eq "1" ]; then
		read -p "Please provide the DB Name: " DB_NAME
			if [ "$DB_NAME" == "$DB_NAME" ]; then
				read -p "Please provide your database table name: " TB_NAME
					if [ "$TB_NAME" == "$TB_NAME" ]; then
						/usr/bin/mysqldump -h $DB_HOST --set-gtid-purged=OFF -u $DB_USER -p$DB_PASS $DB_NAME $TB_NAME > $PATH/$TB_NAME.sql
					fi
			fi
	fi
}

TableRename() {
	DB_HOST=database-1.ciahw21bdnzz.ap-south-1.rds.amazonaws.com
	DB_USER=*****
	DB_PASS=********
	echo "Do you want to rename the Table?"
	echo
	echo "1 - YES"
	echo "2 - NO"
	echo
	read -p "Please Select from the above options: " option
	if [ "$option" -eq "1" ]; then
		read -p "Please provide the DB Name: " DB_NAME
			if [ "$DB_NAME" == "$DB_NAME" ]; then
				read -p "Please provide your database table name: " TB_NAME
					if [ "$TB_NAME" == "$TB_NAME" ]; then
						read -p "Please provide the new table name: " NEW_TB_NAME
						if [ "$NEW_TB_NAME" == "$NEW_TB_NAME" ]; then
							/usr/bin/mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "RENAME TABLE $TB_NAME TO $NEW_TB_NAME;" $DB_NAME
						fi
					fi
			fi
	fi
}

TableRestore() {
	PATH=/home/ubuntu
	DB_HOST=database-1.ciahw21bdnzz.ap-south-1.rds.amazonaws.com
	DB_USER=*****
	DB_PASS=***********
	echo "Do you want to rename the Table?"
	echo
	echo "1 - YES"
	echo "2 - NO"
	echo
	read -p "Please Select from the above options: " option
	if [ "$option" -eq "1" ]; then
		read -p "Please provide the DB Name: " DB_NAME
			if [ "$DB_NAME" == "$DB_NAME" ]; then
				read -p "Please provide your database table name: " TB_NAME
					if [ "$TB_NAME" == "$TB_NAME" ]; then
							/usr/bin/mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME < $PATH/$TB_NAME.sql
					fi
			fi
	fi
}

read -p "Please choose from the above options: " option
if [ "$option" -eq "2" ]; then
		TableBakcup
	elif [ "$option" -eq "5" ]; then
		TableRename
	elif [ "$option" -eq "4" ]; then
		TableRestore
	else
		"Please enter correct option"
fi
