#!/bin/bash
# purpose: set user variables and put dotfiles where they need to be
# author: Jeffrey Reeves
# how to use: run this script with bash
#   ex: ~/dotfiles/install.sh


# define home directory
if [ -z "${HOME}" ]; then
    export HOME=~
fi

# define user
if [ -z "${USER}" ]; then
    export USER=$(whoami)
fi

# get the script directory
export DOTFILES_DIRECTORY=$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null 2>&1 && pwd)

# define paths
CONFIGS="${DOTFILES_DIRECTORY}/configs"
INCLUDES="${DOTFILES_DIRECTORY}/includes"

# import includes scripts (common functions and environment variables)
MAIN_INCLUDE_FILE="${INCLUDES}/_main.sh"
if [ -f "${MAIN_INCLUDE_FILE}" ]; then
    source "${MAIN_INCLUDE_FILE}"
fi

# define bashrc files and the contents needed to be added to them
BASHRC="${HOME}/.bashrc"
DOTFILE_BASHRC="${CONFIGS}/.bashrc"
DATETIME_NOW=$(date "+%Y %b %d @ %H:%M:%S" | tr '[a-z]' '[A-Z]')
SOURCE_FILES="# inserted by dotfiles on ${DATETIME_NOW}
if [ -f \"${DOTFILE_BASHRC}\" ]; then
    source \"${DOTFILE_BASHRC}\"
    export DOTFILES_DIRECTORY=\"${DOTFILES_DIRECTORY}\"
fi
"

# append dotfiles' .bashrc to ~/.bashrc
if [ -f "${BASHRC}" ]; then
    if ! grep -q "${DOTFILE_BASHRC}" "${BASHRC}"; then
        ADD_SOURCE_FILES_TO_BASHRC="echo -e \"${SOURCE_FILES}\" >> \"${BASHRC}\""
        message INFO    "${BASHRC} does not contain ${DOTFILE_BASHRC}"
        message TASK    "Appending ${DOTFILE_BASHRC} ..."
        message COMMAND "${ADD_SOURCE_FILES_TO_BASHRC}"
        eval "${ADD_SOURCE_FILES_TO_BASHRC}"
        EXIT_CODE=${?}
        if [ "${EXIT_CODE}" -eq 0 ]; then
            SOURCE_BASHRC="source \"${BASHRC}\""
            message SUCCESS "${BASHRC} now contains ${DOTFILE_BASHRC}"
            message TASK    "Source ${BASHRC} file to take effect ..." 
            message COMMAND "${SOURCE_BASHRC}"
			eval "${SOURCE_BASHRC}"
        else 
            message ERROR "Unable to add source files to ${BASHRC} (Exit Code: ${EXIT_CODE})"
		fi
    else
        message SUCCESS "${BASHRC} already contains ${DOTFILE_BASHRC}"
    fi
else
    message ERROR "${BASHRC} not found"
    message HELP "Please create a ${BASHRC} file"
fi
echo ''


# create links to dotfiles in home directory
message TASK "Create symlinks to dotfiles in home directory ..."
create_softlink "${CONFIGS}/.gitconfig" "${HOME}/.gitconfig" 
create_softlink "${CONFIGS}/.tmux.conf" "${HOME}/.tmux.conf"
create_softlink "${CONFIGS}/.vimrc"     "${HOME}/.vimrc"
create_softlink "${CONFIGS}/.vim/"      "${HOME}/.vim"
mkdir -p "${HOME}/.config/Code/User"
create_softlink "${CONFIGS}/settings.json" "${HOME}/.config/Code/User/settings.json"
message SUCCESS "Created dotfile symlinks"
echo ''


# configure git username, email, and author name
GIT_NAME='JeffReeves'
GIT_EMAIL='jeff@binary.run'
GIT_AUTHOR='Jeff Reeves'
GIT_CONFIG_NAME="git config --global user.name \"${GIT_NAME}\""
GIT_CONFIG_EMAIL="git config --global user.email \"${GIT_EMAIL}\""
GIT_CONFIG_AUTHOR="git config --global author.name \"${GIT_AUTHOR}\""
message TASK    "Set global git config username, email, and author name ..."
message COMMAND "${GIT_CONFIG_NAME}"
message COMMAND "${GIT_CONFIG_EMAIL}"
message COMMAND "${GIT_CONFIG_AUTHOR}"
eval "${GIT_CONFIG_NAME}"
eval "${GIT_CONFIG_EMAIL}"
eval "${GIT_CONFIG_AUTHOR}"
message SUCCESS "Set username, email, and author name for git"
echo ''


# install vim-plug, if it doesn't already exist
VIM_DIRECTORY="${CONFIGS}/.vim"
VIM_PLUG_FILE="${VIM_DIRECTORY}/autoload/plug.vim"
if [ ! -f "${VIM_PLUG_FILE}" ]; then
    VIM_PLUG_URL='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    CURL_VIM_PLUG="curl -fLo \"${VIM_PLUG_FILE}\" --create-dirs \"${VIM_PLUG_URL}\""
    message TASK    "Downloading and installing vim-plug for vim ..."
    message COMMAND "${CURL_VIM_PLUG}"
    eval "${CURL_VIM_PLUG}"
fi
echo ''
