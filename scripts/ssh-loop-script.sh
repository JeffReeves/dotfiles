#!/bin/bash
# Author: Jeff Reeves
# Purpose: Runs a script on a list of remote servers via ssh 
#   and logs output to a log file.

MAIN_SCRIPT=$(basename "${BASH_SOURCE[0]}")
SCRIPTS_DIRECTORY=$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null 2>&1 && pwd)

# debugging 
echo "${DEBUG} MAIN_SCRIPT: ${MAIN_SCRIPT}"
echo "${DEBUG} SCRIPTS_DIRECTORY: ${SCRIPTS_DIRECTORY}"
echo ''

SCRIPT="${SCRIPTS_DIRECTORY}/${MAIN_SCRIPT}"
echo "${DEBUG} SCRIPT: ${SCRIPT}"
# LOGFILE='script.log'
# SERVERLIST=(hostname1 hostname2)

# # create log file if it does not exist
# if [ ! -f ${LOGFILE} ]; then
#     echo "[INFO] Creating log file..."
#     touch ${LOGFILE}
#     if [ $? -eq 0 ]; then 
#         echo "[SUCCESS] Log file created at ./${LOGFILE}"
#     else
#         echo "[FAILURE] Unable to create log file at ./${LOGFILE}" 
#         exit 1
#     fi 
# fi

# # loop through each server
# for i in ${SERVERLIST[@]}; do 
#     SERVER="${i}"
#     echo "#==[ ${SERVER} ]=========================================="
#     # pass the script to the server via ssh
#     ssh ${SERVER} "bash -s" < ./${SCRIPT} # BASH
#     # ssh ${SERVER} python -u - < ./${SCRIPT} # Python
#     echo -e "\n"
# # display the output on STDOUT and tee to log file
# done | tee -a ${LOGFILE}
