#!/usr/bin/env bash

counter=10

function getFloppyName() {
	diskName=""
	while [ "$diskName" == "" ]; do
		if [ "$(ls /Volumes/ | grep -v 'BOOTCAMP' | grep -v 'mbp_ssd')" ]; then
			diskName=$(ls /Volumes/ | grep -v 'BOOTCAMP' | grep -v 'mbp_ssd')
		fi
		sleep 1;
	done
	echo "$diskName"
}

while true; do
	volumeName="$(getFloppyName)"
	sleep 4
	ls "/Volumes/$volumeName"
	echo "Creating folder $counter"
	mkdir "$counter"
  sleep 8
	rsync -av --exclude="*.411" "/Volumes/$volumeName/" "$counter/"
  	counter=$((counter+1))
  	sudo umount "/Volumes/$volumeName"
	echo "Please remove volume $volumeName to continue..."
	say -v Samantha "Copy done, remove disk."
done
