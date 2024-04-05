#!/bin/bash

if [ -d ~/restore ]
then
	rm -r ~/restore
fi

mkdir ~/restore

ls ~ |
xargs -i echo "~/{}" |
egrep "^~/Backup-" | {
while read name
do
        back_data=$(echo $name | cut -d "-" -f 2-)
        if [[ $(( ($(date +%s) - $(date -d $back_data +%s)) / (60*60*24) )) < 7 ]]
        then
                f="1"
                break
        fi
done

if [[ $f == 0 ]]
then
        echo "Backup not found"
        exit 1
fi
backup_dir=~/Backup-$back_data

find $backup_dir -type f |
grep -v "$back_data$" |
xargs -i cp "{}" ~/restore
}
