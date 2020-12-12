#!/bin/bash
# Author: Jeff Reeves
# Purpose: Runs a script on a list of remote servers via ssh 
#   and logs output to a log file.

function help_output(){
    echo "${HELP} Acceptable parameters are:"
    echo "-i=* | --inventory=*  # inventory file of hosts"
    echo "-h=* | --hosts=*      # hosts to run script on"
    echo "-s=* | --script=*     # script to run on remote hosts"
    echo "-l=* | --log=*        # log file to save output to"
    exit 250
}

SCRIPT_FILENAME=$(script_get_filename "${0}")

# verify user supplied parameters
if [ -z "$@" ]; then
    echo "${ERROR} No parameters were passed to ${SCRIPT_FILENAME}"
    help_output
fi

# parse user parameters
for PARAMETER in "$@"; do 
    case ${PARAMETER} in 

        -i=*|--inventory=*)
            INVENTORY_FILE="${PARAMETER#*=}"
            if [ -z "${INVENTORY_FILE}" ]; then
                read -rp "${PROMPT} Inventory file of hosts:" INVENTORY_FILE
            fi
            shift
            ;;

        -h=*|--hosts=*)
            HOSTS="${PARAMETER#*=}"
            if [ -z "${HOSTS}" ]; then
                read -rp "${PROMPT} Hosts (space separated):" HOSTS
            fi
            shift
            ;;

        -s=*|--script=*)
            REMOTE_SCRIPT="${PARAMETER#*=}"
            if [ -z "${REMOTE_SCRIPT}" ]; then
                read -rp "${PROMPT} Script to run on remote hosts:" REMOTE_SCRIPT
            fi
            shift
            ;;

        -l=*|--log=*)
            LOG_FILE="${PARAMETER#*=}"
            if [ -z "${LOG_FILE}" ]; then
                read -rp "${PROMPT} File to log output to:" LOG_FILE
            fi
            shift
            ;;
        
        *)
            echo "${ERROR} Parameters passed to ${SCRIPT_FILENAME} are not valid"
            help_output
            ;;
    esac
done

# confirm settings passed as parameters
# PADDING=$(padding_get_length "INVENTORY_FILE" "HOSTS" "REMOTE_SCRIPT" "LOG_FILE")
# printf "%-20s %s\n" "${PROMPT}" "Confirm the following:"
# printf "%-${PADDING}s %s\n" "[INVENTORY_FILE]" "${INVENTORY_FILE}"
# printf "%-${PADDING}s %s\n" "[HOSTS]"          "${HOSTS}"
# printf "%-${PADDING}s %s\n" "[REMOTE_SCRIPT]"  "${REMOTE_SCRIPT}"
# printf "%-${PADDING}s %s\n" "[LOG_FILE]"       "${LOG_FILE}"
pprintf "INVENTORY_FILE" "HOSTS" "REMOTE_SCRIPT" "LOG_FILE"
prompt_yes_to_continue

if [ -s "${INVENTORY_FILE}" ]; then 
    echo "${DEBUG} Invetory file: ${INVENTORY_FILE}"
fi

# get the directory and filename of this snippet
SNIPPET_DIRECTORY=$(script_get_directory "${0}")
SNIPPET_FILENAME=$(script_get_filename "${0}")

# define hosts file
HOSTS_FILE="${SNIPPET_DIRECTORY}/hosts"




# get remote script, if passed by the user
if [[ ! -z "${1}" ]]; then
    USER_INPUT="$@"
fi


# find dotfiles' script directory 
DOTFILES_DIRECTORY=$(find -O3 "${HOME}" -user ${USER} -type d -name 'dotfiles')
SCRIPT_DIRECTORY="${DOTFILES_DIRECTORY}/scripts"

SNIPPET_FILENAME=$(script_get_filename "${0}")
REMOTE_SCRIPT="${1}"

# debugging 
echo "${DEBUG} SCRIPT_FILENAME: ${SCRIPT_FILENAME}"
echo "${DEBUG} SCRIPT_DIRECTORY: ${SCRIPT_DIRECTORY}"
echo "${DEBUG} REMOTE_SCRIPT: ${REMOTE_SCRIPT}"
echo ''

SCRIPT="${SCRIPT_DIRECTORY}/${SCRIPT_FILENAME}"
echo "${DEBUG} SCRIPT: ${SCRIPT}"


# loop through each server
for i in ${SERVERLIST[@]}; do 
    SERVER="${i}"
    echo "#==[ ${SERVER} ]=========================================="
    # pass the script to the server via ssh
    ssh ${SERVER} "bash -s" < ./${SCRIPT} # BASH
    # ssh ${SERVER} python -u - < ./${SCRIPT} # Python
    echo -e "\n"
# display the output on STDOUT and tee to log file
done | tee -a ${LOGFILE}
