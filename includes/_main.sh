#!/bin/bash
# purpose: main loader for including all common includes files
# author: Jeff Reeves
# how to use: source this file in a BASH script

# define the common directory and its list of files
MAIN_SCRIPT=$(basename "${BASH_SOURCE[0]}")
INCLUDES_DIRECTORY=$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null 2>&1 && pwd)
INCLUDE_FILES=$(ls -A "${INCLUDES_DIRECTORY}" | grep -v "${MAIN_SCRIPT}")

# loop through each file and source them
for INCLUDE_FILE in ${INCLUDE_FILES}; do
    source "${INCLUDES_DIRECTORY}/${INCLUDE_FILE}"
done