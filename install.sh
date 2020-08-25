#!/bin/bash
# purpose: set user variables and put dotfiles where they need to be
# author: Jeffrey Reeves
# how to use: run this script
#    - ./install.sh

# define home directory
if [ -z "${HOME}" ]; then
    export HOME=~
fi

# import common scripts
COMMON_IMPORT_FILE="${HOME}/dotfiles/common/_main.sh"
if [ -f "${COMMON_IMPORT_FILE}" ]; then
    source "${COMMON_IMPORT_FILE}"
fi

# define bashrc files and the contents needed to be added
BASHRC="${HOME}/.bashrc"
DOTFILE_BASHRC="${HOME}/dotfiles/.bashrc"
SOURCE_FILES="
# inserted by dotfiles on $(date +%Y%b%d)
if [ -f \"${DOTFILE_BASHRC}\" ]; then
    source \"${DOTFILE_BASHRC}\"
fi
"

# append dotfiles/.bashrc to ~/.bashrc
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

# configure git user and emai
GIT_NAME='JeffReeves'
GIT_EMAIL='jeff@binary.run'
echo "${TASK} Set global git config username and email ..."
echo "${COMMAND} git config --global user.name \"${GIT_NAME}\"" 
echo "${COMMAND} git config --global user.email \"${GIT_EMAIL}\"" 
git config --global user.name "${GIT_NAME}"
git config --global user.email "${GIT_EMAIL}"
echo "${SUCCESS} Set username and email for git"

# move dotfiles to home directory
cp "${HOME}/dotfiles/.gitconfig" "${HOME}/.gitconfig" 
