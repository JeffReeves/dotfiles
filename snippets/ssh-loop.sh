#!/bin/bash
# Author: Jeff Reeves
# Purpose: Runs a script on a list of remote servers via ssh 
#   and logs output to a log file.

SCRIPT_FILENAME=$(script_get_filename "${0}")
SCRIPT_DIRECTORY=$(script_get_directory "${0}")
REMOTE_SCRIPT="${SCRIPT_DIRECTORY}/remote/${SCRIPT_FILENAME}"

# debugging 
echo "${DEBUG} SCRIPT_FILENAME: ${SCRIPT_FILENAME}"
echo "${DEBUG} SCRIPT_DIRECTORY: ${SCRIPT_DIRECTORY}"
echo ''

SCRIPT="${SCRIPT_DIRECTORY}/${SCRIPT_FILENAME}"
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
