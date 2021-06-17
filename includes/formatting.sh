#!/bin/bash
# purpose: Adds formatting options to text, such as color or bolding.
# author: Jeff Reeves
# how to use: Source this file in a BASH script, then:
#   - call the functions (with or without quotes): 
#       color 'error' 'This is an error'
#       color blue da ba dee
#       bold 'this is bold text'
#       bold this is some other bold text
#       message 'info' 'This is an information message'
#       message 'prompt' 'Would you like to continue?'
#       message error this is an error!
# note: can be used in echo, printf, etc.


#== FUNCTIONS =================================================================

function padding_get_length(){
# gets a length to pad words by

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # defaults
    local TOTAL_PADDING=0

    for PARAMETER in "$@"; do
        local WORD_LENGTH=$(echo "${1}" | wc -c)
        local PADDING=$((WORD_LENGTH+2))

        if [ ${PADDING} -gt ${TOTAL_PADDING} ]; then
            TOTAL_PADDING=${PADDING}
        fi
        shift
    done

    echo "${TOTAL_PADDING}"
}

function pprintf(){
# pretty print with padding

    # if no arguments are passed, return 100
    if [ $# -eq 0 ]; then 
        return 100
    fi

    # get padding
    local PADDING=$(padding_get_length "$@")

    for PARAMETER in "$@"; do
        local KEY="${1}"
        local VALUES="${!1}"
        printf "%-${PADDING}s %s\n" "[${KEY}]" "${VALUES}"
        shift
    done
}


function color(){ 
# colors text
# args: 
# - color: string
# - text: string
# return: string

    # verify arguents were passed
    if [ $# -eq 0 ]; then
        return 100
    fi

    # available colors
    local COLOR_NONE='\033[0m'
    local COLOR_BLACK='\033[1;30m'
    local COLOR_GRAY='\033[1;37m'
    local COLOR_BLUE='\033[1;34m'
    local COLOR_CYAN='\033[1;36m'
    local COLOR_GREEN='\033[1;32m'
    local COLOR_YELLOW='\033[1;33m'
    local COLOR_RED='\033[1;31m'

    # argument_1: color
    local SELECTED_COLOR=''

    if [[ ! -z "${1}" ]]; then
        case "${1}" in
            'black')
                SELECTED_COLOR='COLOR_BLACK'
                ;;
            'gray')
                SELECTED_COLOR='COLOR_GRAY'
                ;;
            'blue')
                SELECTED_COLOR='COLOR_BLUE'
                ;;
            'cyan')
                SELECTED_COLOR='COLOR_CYAN'
                ;;
            'green')
                SELECTED_COLOR='COLOR_GREEN'
                ;;
            'yellow')
                SELECTED_COLOR='COLOR_YELLOW'
                ;;
            'red')
                SELECTED_COLOR='COLOR_RED'
                ;;
            *)
                SELECTED_COLOR='COLOR_NONE'
                ;;
        esac
        shift
    fi

    # argument_2..argument_N: text
    local USER_INPUT=''

    if [[ ! -z "${1}" ]]; then
        USER_INPUT="$@"
    fi

    echo -e "${!SELECTED_COLOR}${USER_INPUT}${COLOR_NONE}"
}


function bold(){
# boldens text
# args:
#   - text: string
# return: string

    # verify arguents were passed
    if [ $# -eq 0 ]; then
        return 100
    fi

    # bold formatting
    local UNBOLD='\033[0m'
    local BOLD='\033[1m'
    
    # argument_1: text
    local USER_INPUT=''

    if [[ ! -z "${1}" ]]; then
        USER_INPUT="$@"
    fi

    echo -e "${BOLD}${USER_INPUT}${UNBOLD}"    
}


function message(){
# outputs a formatted message
# args: 
# - prefix: string (optional)
# - text:   string
# return: string

    # verify arguents were passed
    if [ $# -eq 0 ]; then
        return 100
    fi

    # argument_1: PREFIX
    local PREFIX=''

    if [[ ! -z "${1}" ]]; then
        case "${1}" in
            'debug'|'DEBUG')
                PREFIX=$(color 'black' '[DEBUG]')
                shift
                ;;
            'info'|'INFO')
                PREFIX=$(color 'gray' '[INFO]')
                shift
                ;;
            'task'|'TASK')
                PREFIX=$(color 'gray' '[TASK]')
                shift
                ;;
            'command'|'COMMAND')
                PREFIX=$(color 'blue' '[COMMAND]')
                shift
                ;;
            'prompt'|'PROMPT')
                PREFIX=$(color 'blue' '[PROMPT]')
                shift
                ;;
            'help'|'HELP')
                PREFIX=$(color 'cyan' '[HELP]')
                shift
                ;;
            'success'|'SUCCESS')
                PREFIX=$(color 'green' '[SUCCESS]')
                shift
                ;;
            'warning'|'WARNING')
                PREFIX=$(color 'yellow' '[WARNING]')
                shift
                ;;
            'error'|'ERROR')
                PREFIX=$(color 'red' '[ERROR]')
                shift
                ;;
            *)
                # skip if not one of the above keywords
                ;;
        esac
    fi

    # argument_2..argument_N: text
    local MESSAGE=''

    if [[ ! -z "${1}" ]]; then
        MESSAGE="$@"
    fi

    printf "%-11s %s\n" "${PREFIX}" "${MESSAGE}"

}

#== EXPORTS ===================================================================

export -f pprintf
export -f color
export -f bold
export -f message