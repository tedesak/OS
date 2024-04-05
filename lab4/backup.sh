#!/bin/bash

f=0

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
        back_data=$(date '+%Y-%m-%d')
        backup_dir=~/Backup-$back_data
        mkdir $backup_dir
        cp -r ~/source/* $backup_dir/
        echo "create $backup_dir" >> ~/backup-report
        ls -R $backup_dir | xargs -i echo "{}" >> ~/backup-report
        echo >> ~/backup-report
        exit
fi

backup_dir=~/Backup-$back_data
old_size=$(ls -lR $backup_dir | awk '{print $9 " " $5}' | tail +2)

#b-backup; u-update if changed; r-recursive with dir; suffix-suffix for changed files
cp -bur --suffix=".$back_data" ~/source/* $backup_dir/

touch task3_add_files
touch task3_upd_files
f=0

ls -lR ~/source |
awk '{print $9 " " $5}' |
tail +2 | {
while read line
do
        if [[ -z $line ]]
        then
                continue
        fi
        f_name=$(echo $line | cut -d " " -f 1)
        x=$(echo $line | cut -d " " -f 2)
        y=$(echo $old_size | grep -o "$f_name [0-9]*" | cut -d " " -f 2)
        if [[ -z $y ]]
        then
                f=1
                echo $f_name >> task3_add_files
                continue
        fi
        if [[ $x != $y ]]
        then
                f=1
                echo "$f_name $f_name.$back_data" >> task3_upd_files
                continue
        fi
done

if [[ $f == 1 ]]
then
        if [[ ! -f ~/backup-report ]]
        then
                touch ~/backup-report
        fi
        echo "change $backup_dir" >> ~/backup-report
        cat task3_add_files >> ~/backup-report
        cat task3_upd_files >> ~/backup-report
        echo >> ~/backup-report
fi
}

rm task3_add_files
rm task3_upd_files
}
