#!/bin/bash
# purpose: includes vim 8.0 if the OS == RHEL 7.x
# author: Jeff Reeves

# skip if not RHEL
if [ -f "/etc/redhat-release" ]; then 
    exit 0
fi

# get RHEL version and extract major version number
REDHAT_VERSION=$(grep -Eo '[0.9].[0-9]+' "/etc/redhat-release")
REDHAT_MAJOR=$(echo "${REDHAT_VERSION}" | cut -c1)

echo "[INFO] RedHat Version: ${REDHAT_VERSION}" 

# if RHEL 7, include vim 8.0
#   - default vim 7.4 lacks necessary features
if [ "${REDHAT_MAJOR}" == '7' ]; then
    unzip "${HOME}/dotfiles/dist/rhel7.zip"
    export VIMRUNTIME="${HOME}/dotfiles/dist/rhel7/usr/share/vim/vim80"
    alias vim="${HOME}/dotfiles/dist/rhel7/usr/bin/vim"
fi