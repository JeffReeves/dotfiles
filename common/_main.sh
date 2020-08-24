#!/bin/bash
# author: Jeff Reeves
# purpose: main loader for including all common files
# how to use: source this file in a BASH script

# define the common directory and its list of files
MAIN_SCRIPT=$(basename "${BASH_SOURCE[0]}")
COMMON_DIRECTORY=$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null 2>&1 && pwd)
COMMON_FILES=$(ls -A "${COMMON_DIRECTORY}" | grep -v "${MAIN_SCRIPT}")

# loop through each file and source them
for COMMON_FILE in ${COMMON_FILES}; do
    source "${COMMON_DIRECTORY}/${COMMON_FILE}"
done
