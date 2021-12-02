ECHO OFF

del D:\SQLBackups\iVat2.bak && ECHO Y

del D:\SQLBackups\ivat2.zip && ECHO Y

:: set path to save backup files e.g. D:\backup
set BACKUPPATH=D:\SQLBackups

:: set name of the server and instance
set SERVERNAME=HODI2406101778A\SQLEXPRESS

:: set database name
set DATABASENAME=iVat2

:: filename format Name-Date
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)

set DATESTAMP=%mydate%_%mytime%
set BACKUPFILENAME=%BACKUPPATH%\%DATABASENAME%.bak

SqlCmd -S %SERVERNAME% -E -d master -Q "BACKUP DATABASE [%DATABASENAME%] TO DISK = N'%BACKUPFILENAME%' WITH INIT, NOUNLOAD, NAME = N'%DATABASENAME% backup', NOSKIP, STATS = 10, NOFORMAT"
ECHO.

::timeout /t 10

Echo zipping...
"C:\Program Files\7-Zip\7z.exe" a -tzip "D:\SQLBackups\ivat2.zip" "D:\SQLBackups\iVat2.bak"
echo Done!

