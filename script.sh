#!/bin/bash
site_name="dev.newframe.com"
remark="automated Backup"
web_floder="/var/ww/vhosts/dev.newframe.com/httpdocs/newclicknew"
database="dev_newframe"
db_username="dev_newframe"
db_password="dev_newframe"
today_floder=dev@$(date +%Y%B%D)
#Daily Backup START

rsync -avh --delete $BACKUPPOINT/ $MOUNTPOINT/Daily/
logger Daily READBackup Complete -t$PROG_NAME $(date "+%m-%d_%Y")
/usr/local/emhttp/webgui/scripts/notify -e "unRAID server notice" -s "Server Backup" -d "Daily READBackup completed" -i "normal"

#weekly suday backup start

if [$DayofWeek_Numeral_Weekly == 7]
then
rsync -avh --delete --link-dest=$MOUNTPOINT/Daily/$BACKUPPOINT/$MOUNTPOINT/Weekly/
logger Weekly READBackup Completed -t$PROG_NAME $(date "+%m-%d-%Y")
/usr/local/emhttp/webgui/scripts/notify -e "unRAID server notice" -s "Server Backup" -d "Weekly READBackup completed" -i "normal"

#monthly backup start

if [$DayofWeek_Numeral_Monthly == 1]
then
rsync -avh --delete --link-dest=$MOUNTPOINT/Daily/$BACKUPPOINT/$MOUNTPOINT/Monthly
logger Weekly READBackup Completed -t$PROG_NAME $(date "+%m-%d-%Y")
/usr/local/emhttp/webgui/scripts/notify -e "unRAID server notice" -s "Server Backup" -d "Monthly READBackup completed" -i "normal"

else

logger READBackup Drive nnot mounted -t$PROG_NAME$(date "+%m-%d-%Y")
/usr/local/emhttp/webgui/scripts/notify -e "unRAID server notice" -s "Server Backup" -d "Daily READBackup failed" -i "alret"

mkdir -p $Backup_floder
mkdir $backup_floder/$today_floder
cp -r $web_folder $backup_folder/$today_folder/ 
cd $backup_folder/$today_folder/ 
mysqldump --opt --user=${db_username} --password="${db_password}" ${database} > db.sql 
echo "Name: "$site_name"\nDate: "`date`"\nRemark: "$remark >  $backup_folder/$today_folder/README 
cd $backup_folder
tar -cvzf  $today_folder.tar.gz   $today_folder
rm -rf $today_folder
