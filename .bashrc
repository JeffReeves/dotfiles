export TERM='screen-256color'

# import common scripts
COMMON_IMPORT_FILE="${HOME}/dotfiles/common/_main.sh"
if [ -f "${COMMON_IMPORT_FILE}" ]; then
    source "${COMMON_IMPORT_FILE}"
fi

# aliases
ALIAS_FILE="${HOME}/dotfiles/.bash_aliases"
if [ -f "${ALIAS_FILE}" ]; then
    source "${ALIAS_FILE}"
fi
