#!/bin/bash

set -e

if [ ${1} ]; then
	FOLDER=${1}
else
	echo "Specify folder to sync"
	exit 1
fi

# Check for gdrive
if [ -z "$(which gdrive)" ]; then
	echo "gdrive not found in path, get it here: https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwj2_ZCToMrbAhXD5oMKHROpDDQQFggpMAA&url=https%3A%2F%2Fgithub.com%2Fprasmussen%2Fgdrive&usg=AOvVaw0fJTEQCZN4tbCI4O5Jj61y"
	exit 2
fi

CACHE="${FOLDER}_gdrive-sync"
PASSWD_FILE="${FOLDER}_gdrive-sync.pw"


# Cleanup/create local cache
if [ -d ${CACHE} ]; then
	rm -r -f ${CACHE}/*
else
	mkdir ${CACHE}
fi

# Prepare compressed, encrupted, backup files
time tar -v -c ${FOLDER} \
 | xz -9 - \
 | gpg --batch --yes -c --passphrase-file "${PASSWD_FILE}" \
 | split --b 100M --verbose - "${CACHE}/${FOLDER}.tar.xz.gpg.part"

# Sync to GDrive
gdrive delete ${CACHE}
gdrive sunc upload ${CACHE}
