#!/bin/bash

if [ ! -d "$1" ]
then
	echo "Incorrect directory name"
	exit 1
fi

cur_data=$(date '+%Y-%m-%d')
found_dir=".found.$cur_data"
dest_dir=$found_dir$PWD/"$1"

if [ -d ~/"$dest_dir" ]
then
	rm -r ~/"$dest_dir"
fi

mkdir -p ~/"$dest_dir"

declare -A hash_table

function search_dup() {

	cd "$1"

	for el in *
	do
		if [ -f "$el" ]
		then
			cur_hash=$(md5sum "$el" | awk '{print $1}')
			if [ -z "${hash_table[$cur_hash]}" ]
			then
				hash_table[$cur_hash]=$PWD/"$el"
			elif [ -z "$(cmp -s "$PWD/$el" "${hash_table[$cur_hash]}")" ]
			then
				echo "identical files found: " "$PWD/$el" "  and  " "${hash_table[$cur_hash]}"
				ln "${hash_table[$cur_hash]}" ~/"$found_dir$PWD/$el" || {
					echo "Invalid source for hard link: ${hash_table[$cur_hash]}"
					exit 1
				}
				ln "$PWD/$el" ~/"$found_dir${hash_table[$cur_hash]}" || {
                                        echo "Invalid destination for hard link: ~/$found_dir$PWD/$el"
                                        exit 1
                                }
			fi
		elif [ -d "$el" ]
		then
			mkdir ~/"$found_dir$PWD/$el"
			search_dup "$el"
		fi
	done
	cd ..
}

search_dup "$1"
