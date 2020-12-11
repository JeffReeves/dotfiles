#!/bin/bash
# author: Jeff Reeves
# purpose: Common functions for use within various BASH scripts.
# how to use: source this file in a BASH script, then call the functions
#
# function list:
# 

# NOTE: commented out to prevent additional overhead
# set defaults if formatting.sh was not sourced
#FORMATTING_VARIABLES='DEBUG INFO COMMAND PROMPT HELP SUCCESS WARNING ERROR'
#for FORMAT_VARIABLE in ${FORMATTING_VARIABLES}; do 
#    if [ -z "${!FORMAT_VARIABLE}" ]; then
#        declare "${FORMAT_VARIABLE}"="[${VAR}]"
#    fi
#done
#
#if [ -z "$(declare -F color)" ]; then
#    function color(){ 
#        if [ $# -eq 0]; then return 100; fi
#        if [ ! -z "${1}" ]; then shift; fi
#	echo -e "${0}"
#    }
#fi

#== FUNCTIONS =================================================================

function script_get_filename(){

    # set default
    local SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")

    # if an argument is passed, use it for the basename
    if [ ! -z ${1} ]; then
        SCRIPT_NAME=$(basename "${1}")
    fi

    echo "${SCRIPT_NAME}"
}


function script_get_directory(){
    local SCRIPTS_DIRECTORY=$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null 2>&1 && pwd)
    echo "${SCRIPTS_DIRECTORY}"
}


function prompt_any_key_to_continue(){
# prompts the user to press any key to continue
# args:
# - items: strings
# return:
# - 0: success

    read -n1 -s -r -p "${PROMPT} Press any key to continue"
    READ_EXIT_CODE=$?
    if [ "${READ_EXIT_CODE}" -ne 0 ]; then 
        printf "\n%-16s %s\n" "${ERROR}" "User did not wish to continue, or another error occurred"
        return ${READ_EXIT_CODE}
    fi

    printf "\n%-16s %s\n" "${SUCCESS}" "User is continuing"
    return 0
}

function prompt_confirm_values(){
# prompts the user to confirm items before continuing
# args:
# - items: strings
# return:
# - 0: success

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # parameters
    local ITEMS=''

    # get all items from passed parameters
    if [[ ! -z "${1}" ]]; then
        ITEMS="$@"
    fi

    printf "%-16s %s\n" "${PROMPT}" "Confirm the following:"
    for ITEM in ${ITEMS}; do 
        printf "%-16s %s\n" "$(color info '[ITEM]')" "${ITEM}"
    done

    prompt_any_key_to_continue
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
    printf "%-16s %s\n" "${TASK}" "Verifying current user is ${DESIRED_USER} ..."
    printf "%-16s %s\n" "$(color info '[CURRENT USER]')" "${CURRENT_USER}"
    if [ "${CURRENT_USER}" != "${DESIRED_USER}" ]; then
        printf "%-16s %s\n" "${ERROR}" "NOT logged in as the desired user."
        return 1
    else
        printf "%-16s %s\n" "${SUCCESS}" "Logged in as the desired user."
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
    printf "%-16s %s\n" "${TASK}" "Verifying current hostname contains or matches ${DESIRED_HOSTNAME} ..."
    printf "%-16s %s\n" "$(color info '[CURRENT HOSTNAME]')" "${CURRENT_HOSTNAME}"
    if [[ ! "${CURRENT_HOSTNAME}" =~ "${DESIRED_HOSTNAME}" ]]; then
        printf "%-16s %s\n" "${ERROR}" "NOT logged into the desired host."
        return 1
    else
        printf "%-16s %s\n" "${SUCCESS}" "Logged into the desired host."
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
    printf "%-16s %s\n" "${TASK}" "Verifying ${FILE} exists ..."
    if [ ! -f "${FILE}" ]; then
        printf "%-16s %s\n" "${ERROR}" "${FILE} does NOT exist"
        return 1
    else
        printf "%-16s %s\n" "${SUCCESS}" "${FILE} exist"
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
    if [ "${1}" == 'second_run' ]; then 
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
    printf "%-16s %s\n" "${TASK}" "Verifying ${FILE} has ${KEY} set to ${DESIRED VALUE} ..."
    printf "%-16s %s\n" "${COMMAND}" "${GREP}"

    # verify there is at least one current value found
    if [ -z "${CURRENT_VALUES}" ]; then 
        printf "%-16s %s\n" "${ERROR}" "No current value found"
        return 200
    fi

    # iterate over all current values found
    while IFS='' read -r CURRENT_VALUE || [[ -n "${CURRENT_VALUE}" ]]; do 

        printf "%-16s %s\n" "$(color info '[CURRENT VALUE]')" "${CURRENT_VALUE}"

        # skip lines starting with a comment
        local REGEX_COMMENT='^[ \t]*(#)' # extensible for other comment characters
        local BEGINS_WITH_COMMENT=$(echo "${CURRENT_VALUE}" | grep -E "${REGEX_COMMENT}")
        if [ "${BEGINS_WITH_COMMENT}" ]; then 
            printf "%-16s %s\n" "${INFO}" "Current value is a comment line. Skipping..."
            continue
        fi

        # command for replacement of current and desired value
        local SED_REPLACE="sed -e 's/${CURRENT_VALUE}/${DESIRED_VALUE}/' -i ${FILE}"

        # if current value does not match desired value
        if [ "${CURRENT_VALUE}" != "${DESIRED_VALUE}" ]; then
            printf "%-16s %s\n" "$(color info '[DESIRED VALUE]')" "${DESIRED_VALUE}"
            printf "%-16s %s\n" "${WARNING}" "Current value does not match desired value"
            printf "%-16s %s\n" "${TASK}" "Setting desired value ..."
            printf "%-16s %s\n" "${COMMAND}" "${SED_REPLACE}"
            eval "${SED_REPLACE}"
            local EXIT_CODE=$?

            # confirm sed replacement worked
            if [ "${EXIT_CODE}" -ne 0 ]; then 
                printf "%-16s %s\n" "${ERROR}" "Exit Code: ${EXIT_CODE}"
                return ${EXIT_CODE}
            fi

            # use recursion to confirm the value was set
            if [ "${SECOND_RUN}" == 'False' ]; then
                check_set_value 'recursive' "$@"
            else 
                printf "%-16s %s\n" "${ERROR}" "Current value was NOT updated"
                return 1
            fi

        # if current value and desired value are equal
        elif [ "${CURRENT_VALUE}" == "${DESIRED_VALUE}" ]; then

            if [ "${SECOND_RUN}" == 'False' ]; then
                printf "%-16s %s\n" "${SUCCESS}" "${KEY} already set to ${DESIRED_VALUE}"
            else
                printf "%-16s %s\n" "${SUCCESS}" "${KEY} set to ${DESIRED_VALUE}"
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
    printf "%-16s %s\n" "${TASK}" "Verifying ${COMMAND} is available ..."

    # command
    local WHICH_EXIT_CODE=$(which "${COMMAND}" > /dev/null 2>&1; echo $?)

    # check if which finds a command
    if [ "${WHICH_EXIT_CODE}" -ne 0 ]; then
        printf "%-16s %s\n" "${ERROR}" "${COMMAND} command NOT available"
        return 1
    else
        printf "%-16s %s\n" "${SUCCESS}" "${COMMAND} available"
        return 0
    fi
}


#== EXPORTS ===================================================================

export -f script_get_filename
export -f script_get_directory
export -f prompt_any_key_to_continue
export -f prompt_confirm_values
export -f confirm_current_user
export -f confirm_current_hostname
export -f check_file_exists
export -f check_set_value
export -f check_command_available