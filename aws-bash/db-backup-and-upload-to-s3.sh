#!/bin/bash

# MySQL database credentials
DB_USER="******"
DB_PASSWORD="******"
DB_NAME="********"

S3_BUCKET_NAME="*********"
S3_BUCKET_PATH="*********"

# MySQL backup file name and path
DATE=$(date +%Y-%m-%d_%H-%M-%S)
MYSQL_BACKUP_FILE_NAME="$DB_NAME-$DATE.sql"
MYSQL_BACKUP_FILE_PATH="/tmp/$MYSQL_BACKUP_FILE_NAME"

# Compressed backup file name and path
GZIP_BACKUP_FILE_NAME="$MYSQL_BACKUP_FILE_NAME.gz"
GZIP_BACKUP_FILE_PATH="/tmp/$GZIP_BACKUP_FILE_NAME"

# Backup MySQL database
mysqldump --set-gtid-purged=OFF -h medictproduploadrds.cctc6p9gkaei.ap-northeast-1.rds.amazonaws.com --user=$DB_USER --password=$DB_PASSWORD $DB_NAME > $MYSQL_BACKUP_FILE_PATH

# Compress backup file using gzip
gzip $MYSQL_BACKUP_FILE_PATH
echo "GZIP Done"

# Upload compressed backup to AWS S3
/usr/local/bin/aws s3 cp $GZIP_BACKUP_FILE_PATH s3://$S3_BUCKET_NAME/$S3_BUCKET_PATH/$GZIP_BACKUP_FILE_NAME  --region ap-northeast-1 --profile default
echo "S3 Copy Done"
#aws s3 cp $GZIP_BACKUP_FILE_PATH s3://$S3_BUCKET_NAME/$S3_BUCKET_PATH/$GZIP_BACKUP_FILE_NAME 
# Delete backup files from local
#rm $MYSQL_BACKUP_FILE_PATH
rm $GZIP_BACKUP_FILE_PATH
