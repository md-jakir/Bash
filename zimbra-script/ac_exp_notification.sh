#!/bin/bash
#Script for zimbra password expiry email notification.
# Meant to be performed as daily cronjob run as zimbra user.
# redirect output to a file to get a 'log file' of sorts.

# Time taken of script;
echo "$SECONDS Started on: $(date)"
# Set variables:
# First notification in days, then last warning:
FIRST="20"
LAST="7"
# pass expiry in days, we are assuming passwd exiry is 90 Days
POLICY="90"
# Sent from:
FROM="jakir.hossain@triangle.com.bd"
# Get all users - it should run once only.
USERS=$(ionice -c3 /opt/zimbra/bin/zmprov -l gaa triangle.com.bd)

#Todays date, in seconds:
DATE=$(date +%s)
# Iterate through them in for loop:
for USER in $USERS
 do
# When was the password set?
USERINFO=$(ionice -c3 /opt/zimbra/bin/zmprov ga $USER)
PASS_SET_DATE=$(echo "$USERINFO" | grep zimbraPasswordModifiedTime: | cut -d " " -f 2 | cut -c 1-8)
#NAME=$(echo "$USERINFO" | grep givenName | cut -d " " -f 2)

# Make the date for expiry from now.
#echo PASS_SET_DATE is $PASS_SET_DATE
EXPIRES=$(date -d  "$PASS_SET_DATE $POLICY days" +%s)
#echo PASS_SET_DATE is $PASS_SET_DATE
#echo EXPIRES DAYS  is $EXPIRES
# Now, how many days until that?
DEADLINE=$(( (($DATE - $EXPIRES)) / -86400 ))

# Email to send to users...
SUBJECT="Your Password will expire in $DEADLINE days"
BODY="
Dear Concern,
Your account password will expire in "$DEADLINE" days, Please reset your password soon.
Thanks,
 Email Admin
"
# Send it off depending on days, adding verbose statements for the 'log'
# First warning
if [[ "$DEADLINE" -eq "$FIRST" ]]
then
 echo "Subject: $SUBJECT" "$BODY" | /opt/zimbra/common/sbin/sendmail -f $FROM "$USER"
 echo "Reminder email sent to: $USER - $DEADLINE days left"
# Second
elif [[ "$DEADLINE" -eq "$LAST" ]]
then
 echo "Subject: $SUBJECT" "$BODY" | /opt/zimbra/common/sbin/sendmail -f $FROM "$USER"
 echo "Reminder email sent to: $USER - $DEADLINE days left"
# Final
elif [[ "$DEADLINE" -eq "1" ]]
then
    echo "Subject: $SUBJECT" "$BODY" | /opt/zimbra/common/sbin/sendmail -f $FROM "$USER"
 echo "Last chance for: $USER - $DEADLINE days left"

# Check for Expired accounts, get last logon date add them to EXP_LIST2 every monday
elif [[ "$DEADLINE" -lt "0" ]] && [ '$(date +%a) = "Mon"' ]
 then
    LASTDATE=$(echo "$USERINFO" | grep zimbraLastLogonTimestamp | cut -d " " -f 2 | cut -c 1-8)
    LOGON=$(date -d "$LASTDATE")
 EXP_LIST=$(echo "$USER's password has been expired for ${DEADLINE#-} day(s) now, last logon was $LOGON.")
 EXP_LIST2="$EXP_LIST2 \n $EXP_LIST"

else
# > /dev/null for less verbose logs and a list of users.
    echo "Account: $USER reports; $DEADLINE days on Password policy"
fi

# Finish for loop
done

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

# Send off list using hardcoded email addresses.

EXP_BODY="
Hello Email Admin,
This is the monthly list of expired passwords and their last recorded login date:
$(echo -e "$EXP_LIST2")
Regards,
Email Admin.
"
echo "Subject: List of accounts with expired passwords" "$EXP_BODY" | /opt/zimbra/common/sbin/sendmail -f  jakir.hossain@triangle.com.bd
# Expired accts, for the log:
echo -e "$EXP_LIST2"

echo "finished in $SECONDS seconds"
echo "Thank you"
