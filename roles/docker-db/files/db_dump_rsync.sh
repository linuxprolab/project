#!/bin/bash
# Database1 Credentials:
 username="ctfd"
 password="ctfd"
 host="127.0.0.1"
 db_name="ctfd"
# Rsync Server Credentials:
 rsync_user="vagrant"
 rsync_pass="vagrant"
 rsync_host="backup"
# Other options:
 mysql_backup_path="/home/vagrant/backup/db"
 date=$(date +"%d-%b-%Y-at-%H-%M")
# Empty Backup Directory:
rm -rf $mysql_backup_path/*.gz > /dev/null 2>&1
rm -rf $mysql_backup_path/*.sql > /dev/null 2>&1
# Dump database into SQL file:
mysqldump -u $username -p$password -h $host --column-statistics=0 $db_name > $mysql_backup_path/$db_name-$date.sql
# Create a tarball:
if [ "$?" -eq 0 ];
then
	cd  $mysql_backup_path && tar -cvzf $db_name-$date.sql.tar.gz  $db_name-$date.sql
	if [ "$?" -eq 0 ];
	then
		# Delete SQL File:
		rm -rf $mysql_backup_path/$db_name-$date.sql
		sshpass -p $rsync_pass rsync -aP -e "ssh -o StrictHostKeyChecking=no" $db_name-$date.sql.tar.gz $rsync_user@$rsync_host:.
		if [ "$?" -eq 0 ];
		then
			echo " $db_name DATABASE BACKUP Rsync and was Successful."
		else
			echo " $db_name Rsync was failed hence DB Backup was Failed."
		fi
	else
		echo " $db_name TAR creation Unsuccessful hence Backup was Failed."
	fi
else
	echo " $db_name DATABASE DUMP was Unsuccessful hence Backup was Failed."
fi

