#!/bin/bash

start=`date +%s`

backup_path="/backups/mysql/"

date=$(date +"%d-%b-%Y")

# Set default file permissions
umask 177

# Imports database list file
. database-list.txt

arraylength=${#database_names[@]}

for (( i=1; i<${arraylength}+1; i++ ));
do
  host=${database_hosts[$i-1]}
  user=${database_users[$i-1]}
  db_name=${database_names[$i-1]}
  password=${database_pass[$i-1]}

  mysqldump --user=$user --password=$password --host=$host $db_name | gzip > $backup_path/$db_name-$date.sql.gz 
done

echo "Duration: $(($(date +%s)-$start))s"