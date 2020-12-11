#!/bin/bash
# author: Jeff Reeves
# purpose: Adds formatting options to text, such as color or bolding.
# how to use: Source this file in a BASH script, then:
#   - call the functions: 
#       color 'error' 'This is an error'
#       color 'blue' 'Do you wish to continue?'
#       bold 'this is bold text'
#   - call macro variables:
#       DEBUG INFO TASK COMMAND PROMPT HELP SUCCESS WARNING ERROR
# note: can be used in echo, printf, echo, etc.


#= FUNCTIONS ==================================================================

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
            'hidden'|'black')
                SELECTED_COLOR='COLOR_BLACK'
                ;;
            'info'|'task'|'gray')
                SELECTED_COLOR='COLOR_GRAY'
                ;;
            'prompt'|'blue')
                SELECTED_COLOR='COLOR_BLUE'
                ;;
            'help'|'cyan')
                SELECTED_COLOR='COLOR_CYAN'
                ;;
            'success'|'green')
                SELECTED_COLOR='COLOR_GREEN'
                ;;
            'warning'|'yellow')
                SELECTED_COLOR='COLOR_YELLOW'
                ;;
            'error'|'red')
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


#= MACRO VARIABLES ============================================================

export DEBUG=$(color 'hidden' '[DEBUG]')
export INFO=$(color 'info' '[INFO]')
export TASK=$(color 'task' '[TASK]')
export COMMAND=$(color 'prompt' '[COMMAND]')
export PROMPT=$(color 'prompt' '[PROMPT]')
export HELP=$(color 'help' '[HELP]')
export SUCCESS=$(color 'success' '[SUCCESS]')
export WARNING=$(color 'warning' '[WARNING]')
export ERROR=$(color 'error' '[ERROR]')
