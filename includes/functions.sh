#!/bin/bash
# purpose: Common functions for use within various BASH scripts.
# author: Jeff Reeves
# how to use: source this file in a BASH script, then call the functions
# depends:
#   - formatting.sh


#== FUNCTIONS =================================================================

function script_get_filename(){

    # default to null value
    local SCRIPT_NAME=''

    # if source is available, use it
    if [ ! -z "${BASH_SOURCE[0]}" ]; then
        SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
    fi

    # if an argument is passed, use it
    if [ ! -z ${1} ]; then
        SCRIPT_NAME=$(basename "${1}")
    fi

    echo "${SCRIPT_NAME}"
}


function script_get_directory(){

    # set default
    local SCRIPTS_DIRECTORY=''

    # if source is available, use it
    if [ ! -z "${BASH_SOURCE[0]}" ]; then
        SCRIPTS_DIRECTORY=$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null 2>&1 && pwd)
    fi

    # if an argument is passed, use it
    if [ ! -z ${1} ]; then
        SCRIPTS_DIRECTORY=$(cd $(dirname "${1}") > /dev/null 2>&1 && pwd)
    fi

    echo "${SCRIPTS_DIRECTORY}"
}


function prompt_any_key_to_continue(){
# prompts the user to press any key to continue
# args:
# - items: strings
# return:
# - 0: success

    read -n1 -s -r -p "$(message PROMPT 'Press any key to continue ')"

    READ_EXIT_CODE=$?
    if [ "${READ_EXIT_CODE}" -ne 0 ]; then 
        message ERROR "User did not wish to continue, or another error occurred"
        return ${READ_EXIT_CODE}
    fi

    message SUCCESS "User is continuing"
    return 0
}


function prompt_yes_to_continue(){
# prompts the user to press Y/y to continue
# args:
# - items: strings
# return:
# - 0: success

    read -n1 -s -r -p "$(message PROMPT 'Press Y/y to continue ')" CONTINUE
    if [[ ! "${CONTINUE}" =~ ^[Yy] ]]; then 
        message ERROR "User did not wish to continue, or another error occurred"
        return 100
    fi

    message SUCCESS "User is continuing"
    return 0
}


function confirm_current_user(){
# confirms current shell user
# args: 
# - desired user: string
# return:
# - 0: success

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # parameter
    local DESIRED_USER="${1}"

    # command
    local CURRENT_USER="$(whoami)"

    # main 
    message TASK "Verifying current user is \"${DESIRED_USER}\" ..."
    message INFO "Current User: ${CURRENT_USER}"
    if [ "${CURRENT_USER}" != "${DESIRED_USER}" ]; then
        message ERROR "NOT logged in as the desired user"
        return 1
    else
        message SUCCESS "Logged in as the desired user"
        return 0
    fi
}


function confirm_current_hostname(){
# confirms current hostname contains or matches a desired hostname
# args: 
# - desired hostname: string
# return:
# - 0: success

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # parameter
    local DESIRED_HOSTNAME="${1}"

    # command
    local CURRENT_HOSTNAME="$(uname -n)"

    # main 
    message TASK "Verifying current hostname contains or matches \"${DESIRED_HOSTNAME}\" ..."
    message INFO "Current Hostname: ${CURRENT_HOSTNAME}"
    if [[ ! "${CURRENT_HOSTNAME}" =~ "${DESIRED_HOSTNAME}" ]]; then
        message ERROR "NOT logged in as the desired host"
        return 1
    else
        message SUCCESS "Logged in as the desired host"
        return 0
    fi
}


function check_file_exists(){
# checks if a file exists
# args: 
# - file: string
# return:
# - 0: success

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # parameter
    local FILE="${1}"

    # main 
    message TASK "Verifying \"${FILE}\" exists ..."
    if [ ! -f "${FILE}" ]; then
        message ERROR "\"${FILE}\" does NOT exist"
        return 1
    else
        message SUCCESS "\"${FILE}\" exists"
        return 0
    fi
}


function check_set_value(){
# checks and sets a desired value for a key within a file
# args: 
# - file: string
# - key: string
# - desired value: string
# return:
# - 0: success
# - 1: failure
# - 100: no arguments
# - variable: sed failed

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # set a second run flag
    local SECOND_RUN='False'

    # if first argument is a second run
    if [ "${1}" == 'recursive' ]; then 
        SECOND_RUN='True'
        shift
    fi

    # parameters
    local FILE="${1}"
    local KEY="${2}"
    local DESIRED_VALUE="${3}"

    # commands
    local GREP="grep -Eo '.*${KEY}.*' '${FILE}'"
    local CURRENT_VALUES=$(eval "${GREP}")

    # main 
    message TASK    "Verifying \"${FILE}\" has \"${KEY}\" set to \"${DESIRED VALUE}\" ..."
    message COMMAND "${GREP}"

    # verify there is at least one current value found
    if [ -z "${CURRENT_VALUES}" ]; then 
        message ERROR "No current value found"
        return 200
    fi

    # iterate over all current values found
    while IFS='' read -r CURRENT_VALUE || [[ -n "${CURRENT_VALUE}" ]]; do 

        message INFO "Current Value: ${CURRENT_VALUE}"

        # skip lines starting with a comment
        local REGEX_COMMENT='^[ \t]*(#)' # extensible for other comment characters
        local BEGINS_WITH_COMMENT=$(echo "${CURRENT_VALUE}" | grep -E "${REGEX_COMMENT}")
        if [ "${BEGINS_WITH_COMMENT}" ]; then 
            message INFO "Current value is a comment line. Skipping ..."
            continue
        fi

        # command for replacement of current and desired value
        local SED_REPLACE="sed -e 's/${CURRENT_VALUE}/${DESIRED_VALUE}/' -i ${FILE}"

        # if current value does not match desired value
        if [ "${CURRENT_VALUE}" != "${DESIRED_VALUE}" ]; then
            message INFO    "Desired Value: ${DESIRED_VALUE}"
            message WARNING "Current value does not match desired value"
            message TASK    "Setting desired value ..."
            message COMMAND "${SED_REPLACE}"
            eval "${SED_REPLACE}"
            local EXIT_CODE=$?

            # confirm sed replacement worked
            if [ "${EXIT_CODE}" -ne 0 ]; then 
                message ERROR "Exit Code: ${EXIT_CODE}"
                return ${EXIT_CODE}
            fi

            # use recursion to confirm the value was set
            if [ "${SECOND_RUN}" == 'False' ]; then
                check_set_value 'recursive' "$@"
            else 
                message ERROR "Current value was NOT updated"
                return 1
            fi

        # if current value and desired value are equal
        elif [ "${CURRENT_VALUE}" == "${DESIRED_VALUE}" ]; then

            if [ "${SECOND_RUN}" == 'False' ]; then
                message SUCCESS "\"${KEY}\" already set to \"${DESIRED_VALUE}\""
            else
                message SUCCESS "\"${KEY}\" set to \"${DESIRED_VALUE}\""
            fi
        fi
    done <<< "${CURRENT_VALUES}"
}


function check_command_available(){
# checks if a command is available (installed/exists)
# args: 
# - command: string
# return:
# - 0: success

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # parameter
    local COMMAND="${1}"

    # main 
    message TASK "Verifying \"${COMMAND}\" command is available ..."

    # command
    local WHICH_EXIT_CODE=$(which "${COMMAND}" > /dev/null 2>&1; echo $?)

    # check if which finds a command
    if [ "${WHICH_EXIT_CODE}" -ne 0 ]; then
        message ERROR "\"${COMMAND}\" command NOT available"
        return 1
    else
        message SUCCESS "\"${COMMAND}\" command is available"
        return 0
    fi
}


function create_softlink(){
# creates a relative softlink if it doesn't already exist
# args: 
# - destination: string
# - link: string
# return:
# - 0: success
# - 1: failure
# - 100: no arguments
# - 101: missing argument destination
# - 102: missing argument link 

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # verify arguments were passed
    # 1 = destination 
    # 2 = link
    local HELP_MESSAGE="create_softlink DESTINATION LINK"
    if [ -z "${1}" ]; then 
        message ERROR "Destination NOT provided"
        message HELP  "${HELP_MESSAGE}"
        return 101
    fi 

    if [ -z "${2}" ]; then
        message ERROR "Link NOT provided"
        message HELP  "${HELP_MESSAGE}"
        return 102
    fi 

    local DESTINATION="${1}"
    local LINK="${2}"

    # verify destination exists
    if [ ! -e "${DESTINATION}" ]; then 
        message ERROR "Destination \"${DESTINATION}\" does not exist"
        message HELP  "Create the destination or verify it exists"
        return 2
    fi 

    # verify if link already exists
    if [ -L "${LINK}" ]; then 
        message WARNING "Link \"${LINK}\" already exists. Skipping ..."
        return 0
    fi
    
    # main 
    RELATIVE_SYMLINK="ln -rs -T \"${DESTINATION}\" \"${LINK}\""
    message COMMAND "${RELATIVE_SYMLINK}"
    eval "${RELATIVE_SYMLINK}"
    EXIT_CODE=${?}
    if [ "${EXIT_CODE}" -eq 0 ]; then
        message SUCCESS "Created softlink: $(ls -al ${LINK})"
        return 0
    fi

    # fallback 
    message ERROR "Unable to create softlink (exit code: ${EXIT_CODE})"
    message TASK  "Attempting fallback method ..."

    REMOVE_SYMLINK="rm -f \"${LINK}\""
    message COMMAND "${REMOVE_SYMLINK}"
    eval "${REMOVE_SYMLINK}"

    CREATE_SYMLINK="ln -s \"${DESTINATION}\" \"${LINK}\""
    message COMMAND "${CREATE_SYMLINK}"
    eval "${CREATE_SYMLINK}"
    EXIT_CODE=${?}
    if [ "${EXIT_CODE}" -eq 0 ]; then
        message SUCCESS "Created softlink: $(ls -al ${LINK})"
        return 0
    fi
}

#== EXPORTS ===================================================================

export -f script_get_filename
export -f script_get_directory
export -f prompt_any_key_to_continue
export -f prompt_yes_to_continue
export -f confirm_current_user
export -f confirm_current_hostname
export -f check_file_exists
export -f check_set_value
export -f check_command_available
export -f create_softlink