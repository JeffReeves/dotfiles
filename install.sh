#!/bin/bash
# purpose: set user variables and put dotfiles where they need to be
# author: Jeffrey Reeves
# how to use: run this script
# 	- cd ~
#   - ./install.sh

# define home directory
if [ -z "${HOME}" ]; then
    export HOME=~
fi

# define user
if [ -z "${USER}" ]; then
    export USER=$(whoami)
fi

# get the script directory
DOTFILES_DIRECTORY=$(cd $(dirname "${BASH_SOURCE[0]}") > /dev/null 2>&1 && pwd)

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
fi
"

# append dotfiles' .bashrc to ~/.bashrc
if [ -f "${BASHRC}" ]; then
    if ! grep -q "${DOTFILE_BASHRC}" "${BASHRC}"; then
        echo "${INFO-[INFO]} ${BASHRC} does not contain ${DOTFILE_BASHRC}"
		echo "${TASK-[TASK]} Appending ${DOTFILE_BASHRC} ..."
		echo -e "${COMMAND-[COMMAND]} ${SOURCE_FILES} >> \"${BASHRC}\""
		echo -e "${SOURCE_FILES}" >> "${BASHRC}"
		if [ ${?} -eq 0 ]; then 
			echo "${SUCCESS-[SUCCESS]} ${BASHRC} now contains ${DOTFILE_BASHRC}"
			echo "${TASK-[TASK]} Source ${BASHRC} file to take effect ..." 
			echo "${COMMAND-[COMMAND]} source ${BASHRC}"
			source "${BASHRC}"
		fi
    else
		echo "${SUCCESS-[SUCCESS]} ${BASHRC} already contains ${DOTFILE_BASHRC}"
    fi
else
    echo "${ERROR-[ERROR]} ${BASHRC} not found"
    echo "${HELP-[HELP]} Please create a ${BASHRC} file"
fi


# configure git user and email
GIT_NAME='JeffReeves'
GIT_EMAIL='jeff@binary.run'
echo "${TASK} Set global git config username and email ..."
echo "${COMMAND} git config --global user.name  \"${GIT_NAME}\"" 
echo "${COMMAND} git config --global user.email \"${GIT_EMAIL}\"" 
git config --global user.name  "${GIT_NAME}"
git config --global user.email "${GIT_EMAIL}"
echo "${SUCCESS} Set username and email for git"


# create links to dotfiles in home directory
ln -fs "${CONFIGS}/.gitconfig" "${HOME}/.gitconfig"
ln -fs "${CONFIGS}/.tmux.conf" "${HOME}/.tmux.conf"
ln -fs "${CONFIGS}/.vimrc"     "${HOME}/.vimrc"