#!/bin/bash
# purpose: unarchives all git.tar.xz files into .git directories 
#   for all vim-plug plugins.
#
# note: an alternative option would be to run the following in vim:
#   `:PlugClean!` --> `:PlugInstall`
#
# author: Jeff Reeves

# get current directory
CURRENT_DIRECTORY=$(pwd)

# set dotfiles directory, if not in env variables already
if [ ! "${DOTFILES_DIRECTORY}" ]; then 
    DOTFILES_DIRECTORY=$(find -O3 "${HOME}" -user ${USER} -type d -name 'dotfiles' -prune)
fi

VIM_DIRECTORY="${DOTFILES_DIRECTORY}/configs/.vim"
VIM_PLUG_DIRECTORY="${VIM_DIRECTORY}/plugged"
VIM_PLUG_DIRECTORIES=$(ls -A "${VIM_PLUG_DIRECTORY}")
PLUGIN_COUNT=$(echo ${VIM_PLUG_DIRECTORIES} | wc -w)
echo -e "${TASK-[TASK]} Unarchiving all vim-plug plugin git.tar.xz archives into .git directories ..." 
echo -e "${INFO-[INFO]} Plugin Count: ${PLUGIN_COUNT}"
echo ''

# iterate over each plugin
for PLUGIN in ${VIM_PLUG_DIRECTORIES}; do 

    echo -e "${INFO-[INFO]} Plugin: ${PLUGIN}"

    PLUGIN_DIRECTORY="${VIM_PLUG_DIRECTORY}/${PLUGIN}"

    # verify plugin directory exists
    if [ ! -d "${PLUGIN_DIRECTORY}" ]; then
        echo -e "${WARNING-[WARNING]} Plugin directory ${PLUGIN_DIRECTORY} does NOT exist. Skipping ...\n"
        continue
    fi

    PLUGIN_TAR_FILE="${PLUGIN_DIRECTORY}/git.tar.xz"
    PLUGIN_GIT_DIRECTORY="${PLUGIN_DIRECTORY}/.git"

    # verify plugin archive exists
    if [ ! -f "${PLUGIN_TAR_FILE}" ]; then
        echo -e "${WARNING-[WARNING]} Plugin archive ${PLUGIN_TAR_FILE} does NOT exist. Skipping ...\n"
        continue
    fi

    # echo command to be ran
    echo -e "${COMMAND-[COMMAND]} cd \"${PLUGIN_DIRECTORY}\" && \ 
    tar -xJf \"${PLUGIN_TAR_FILE}\" && \ 
    rm -rf \"${PLUGIN_TAR_FILE}\""

    # run command to tar xz the .git directory, and remove the .git directory
    cd "${PLUGIN_DIRECTORY}" && \
    tar -xJf "${PLUGIN_TAR_FILE}" && \
    rm -rf "${PLUGIN_TAR_FILE}"

    # verify plugin directory exists
    if [ ! -d "${PLUGIN_GIT_DIRECTORY}" ]; then
        echo -e "${ERROR-[ERROR]} Unarchiving failed for ${PLUGIN} plugin. Skipping ...\n"
        continue
    fi

    echo ''
done

echo -e "${INFO-[INFO]} Unarchiving complete\n"

# change back to original directory
cd "${CURRENT_DIRECTORY}"
