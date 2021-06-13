#!/bin/bash
# purpose: archives all .git directories into git.tar.xz archives
#   for all vim-plug plugins.
#
# note: ordinarily git submodules could be used, but firewall
#   restrictions may prevent access to clone/pull submodules.
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
echo -e "${TASK-[TASK]} Archiving all vim-plug plugin .git directories into git.tar.xz archives ..." 
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

    # echo command to be ran
    echo -e "${COMMAND-[COMMAND]} cd \"${PLUGIN_DIRECTORY}\" && \ 
    tar -cJf \"${PLUGIN_TAR_FILE}\" '.git' && \ 
    rm -rf \"${PLUGIN_GIT_DIRECTORY}\""

    # run command to tar xz the .git directory, and remove the .git directory
    cd "${PLUGIN_DIRECTORY}" && \
    tar -cJf "${PLUGIN_TAR_FILE}" '.git' && \
    rm -rf "${PLUGIN_GIT_DIRECTORY}"

    # verify plugin tar file was created
    if [ ! -f "${PLUGIN_TAR_FILE}" ]; then
        echo -e "${ERROR-[ERROR]} Archiving failed for ${PLUGIN} plugin. Skipping ...\n"
        continue
    fi

    echo ''
done

echo -e "${INFO-[INFO]} Archiving complete\n"

# change back to original directory
cd "${CURRENT_DIRECTORY}"
