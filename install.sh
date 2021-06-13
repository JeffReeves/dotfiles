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
        echo -e "${INFO-[INFO]} ${BASHRC} does not contain ${DOTFILE_BASHRC}"
		echo -e "${TASK-[TASK]} Appending ${DOTFILE_BASHRC} ..."
		echo -e "${COMMAND-[COMMAND]} ${SOURCE_FILES} >> \"${BASHRC}\""
		echo -e "${SOURCE_FILES}" >> "${BASHRC}"
		if [ ${?} -eq 0 ]; then 
			echo -e "${SUCCESS-[SUCCESS]} ${BASHRC} now contains ${DOTFILE_BASHRC}"
			echo -e "${TASK-[TASK]} Source ${BASHRC} file to take effect ..." 
			echo -e "${COMMAND-[COMMAND]} source ${BASHRC}"
			source "${BASHRC}"
		fi
    else
		echo -e "${SUCCESS-[SUCCESS]} ${BASHRC} already contains ${DOTFILE_BASHRC}"
    fi
else
    echo -e "${ERROR-[ERROR]} ${BASHRC} not found"
    echo -e "${HELP-[HELP]} Please create a ${BASHRC} file"
fi
echo ''


# configure git username, email, and author name
GIT_NAME='JeffReeves'
GIT_EMAIL='jeff@binary.run'
GIT_AUTHOR='Jeff Reeves'
echo -e "${TASK-[TASK]} Set global git config username, email, and author name ..."
echo -e "${COMMAND-[COMMAND]} git config --global user.name    \"${GIT_NAME}\""  
echo -e "${COMMAND-[COMMAND]} git config --global user.email   \"${GIT_EMAIL}\"" 
echo -e "${COMMAND-[COMMAND]} git config --global author.name  \"${GIT_AUTHOR}\""
git config --global user.name     "${GIT_NAME}"
git config --global user.email    "${GIT_EMAIL}"
git config --global author.name   "${GIT_AUTHOR}"
echo -e "${SUCCESS-[SUCCESS]} Set username, email, and author name for git"
echo ''


# create links to dotfiles in home directory
echo -e "${TASK-[TASK]} Create symlinks to dotfiles in home directory ..."
create_softlink "${CONFIGS}/.gitconfig" "${HOME}/.gitconfig" 
create_softlink "${CONFIGS}/.tmux.conf" "${HOME}/.tmux.conf"
create_softlink "${CONFIGS}/.vimrc"     "${HOME}/.vimrc"
create_softlink"${CONFIGS}/.vim/"     "${HOME}/.vim"
mkdir -p "${HOME}/.config/Code/User"
create_softlink "${CONFIGS}/settings.json" "${HOME}/.config/Code/User/settings.json"
echo -e "${SUCCESS-[SUCCESS]} Created dotfile symlinks"
echo ''

# install vim-plug, if it doesn't already exist
VIM_DIRECTORY="${CONFIGS}/.vim"
VIM_PLUG_FILE="${VIM_DIRECTORY}/autoload/plug.vim"
if [ ! -f "${VIM_PLUG_FILE}" ]; then
    VIMPLUG_URL='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    echo -e "${TASK-[TASK]} Downloading and installing vim-plug for vim ..."
    echo -e "${COMMAND-[COMMAND]} curl -fLo \"${VIM_PLUG_FILE}\" --create-dirs \"${VIM_PLUG_URL}\""
    curl -fLo "${VIM_PLUG_FILE}" --create-dirs "${VIM_PLUG_URL}"
fi
echo ''
