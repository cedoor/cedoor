#!/bin/bash -e

#
# Variables
#

# Main nvim directories.
CONFIG_DIR="${HOME}/.config/nvim"
SNIPPETS_CONFIG_DIR="${HOME}/.config/coc/ultisnips"

# Colors.
TEXT_PRIMARY='\033[1;32m'
TEXT_WARNING='\033[0;33m'
TEXT_ERROR='\033[1;31m'
TEXT_INFO='\033[0;37m'
TEXT_SUCCESS='\033[0;32m'
NC='\033[0m' # No Color.

#
# Functions
#

# Set a waiting spinner.
spinner() {
    MESSAGE=${1}
    echo
    while :; do
        for s in / - \\ \|; do
            echo -ne "\r${MESSAGE}${TEXT_SUCCESS} ${s} ${NC}"
            sleep .1
        done
    done
}

# Create a pregress animation.
progress() {
    # Run asynchronous function & save its pid.
    spinner "$2" &
    SPINNER_PID=$!
    # Fake waiting.
    sleep .5
    # Do something.
    $1
    # Kill the spinner function.
    disown ${SPINNER_PID}
    kill ${SPINNER_PID}
    echo -ne "\r$3"
}

installVimPlug() {
    curl -sfLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

setConfigurationFiles() {
    curl -sfLo "${CONFIG_DIR}/init.vim" --create-dirs https://raw.githubusercontent.com/cedoor/cedoor/main/neovim/init.vim
    curl -sfLo "${CONFIG_DIR}/coc-settings.json" --create-dirs https://raw.githubusercontent.com/cedoor/cedoor/main/neovim/coc-settings.json
}

setSnippets() {
    curl -sfLo "${SNIPPETS_CONFIG_DIR}/gitcommit.snippets" --create-dirs https://raw.githubusercontent.com/cedoor/cedoor/main/neovim/ultisnips/gitcommit.snippets
}

#
# Main script
#

sudo pacman -Syuq neovim npm nodejs python3 python-pip python-neovim xclip xsel git curl ttf-hack ttf-nerd-fonts-symbols
echo -e "\n${TEXT_SUCCESS} ✔${NC} Neovim and dependencies was successfully installed!"

progress installVimPlug " Installing Vim Plug" "${TEXT_SUCCESS} ✔${NC} Vim Plug was successfully installed!"

progress setConfigurationFiles " Setting configuration files" "${TEXT_SUCCESS} ✔${NC} Configuration files have been set up correctly!"

nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall'

echo -e "\n${TEXT_SUCCESS} ✔${NC} Neovim plugins was successfully installed!"

progress setSnippets " Setting snippets" "${TEXT_SUCCESS} ✔${NC} Snippets have been set up correctly!"

echo -e "\n${TEXT_SUCCESS} ✔${NC} Done, welcome to ${TEXT_PRIMARY}Neovim${NC}!\n"
