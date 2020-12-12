# exports
export TERM='screen-256color'
export EDITOR='vim'

# locate dotfiles directory
DOTFILES_DIRECTORY=$(find -O3 "${HOME}" -user ${USER} -type d -name 'dotfiles')

# import common scripts
MAIN_INCLUDE_FILE="${DOTFILES_DIRECTORY}/includes/_main.sh"
if [ -f "${MAIN_INCLUDE_FILE}" ]; then
    source "${MAIN_INCLUDE_FILE}"
fi

# aliases
ALIAS_FILE="${DOTFILES_DIRECTORY}/configs/.bash_aliases"
if [ -f "${ALIAS_FILE}" ]; then
    source "${ALIAS_FILE}"
fi