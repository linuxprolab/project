#!/bin/bash
# Rsync Server Credentials:
 rsync_user="vagrant"
 rsync_pass="vagrant"
 rsync_host="backup"
# Other options:
 backup_path="/home/vagrant/backup/CTFd"
 data_path="/home/vagrant/CTFd/"
 date=$(date +"%d-%b-%Y-at-%H-%M")
# Empty Backup Directory:
rm -rf $backup_path/*.gz > /dev/null 2>&1
rm -rf $backup_path/.data > /dev/null 2>&1
# Create a tarball:
cd  $backup_path && tar -C $data_path -cvzf CTFd-data-$date.tar.gz .data
if [ "$?" -eq 0 ];
then
        sshpass -p $rsync_pass rsync -aP -e "ssh -o StrictHostKeyChecking=no" CTFd-data-$date.tar.gz $rsync_user@$rsync_host:.
        if [ "$?" -eq 0 ];
        then
                echo "  Backup and Rsync was Successful."
        else
                echo "  Rsync was failed hence Backup was Failed."
        fi
else
        echo " $db_name TAR creation Unsuccessful hence Backup was Failed."
fi
