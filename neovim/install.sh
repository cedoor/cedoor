#!/bin/bash -e

#
# Variables
#

# Main nvim directories.
INSTALL_DIR="${HOME}/.opt/nvim"
BIN_DIR="${HOME}/.local/bin"
CONFIG_DIR="${HOME}/.config/nvim"

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

# Install neovim.
installNeovim() {
    rm -fr "${INSTALL_DIR}" "${BIN_DIR}/vim"
    mkdir -p "${INSTALL_DIR}"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -P "${INSTALL_DIR}" -q
    chmod u+x "${INSTALL_DIR}/nvim.appimage"
    ln -s "${INSTALL_DIR}/nvim.appimage" "${BIN_DIR}/vim"
    mkdir -p "${CONFIG_DIR}"
}

installVimPlug() {
    curl -s -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

#
# Main script
#

progress installNeovim "Installing Neovim..." "${TEXT_SUCCESS} ✔${NC} Neovim was successfully installed!\n\n"

sudo apt update -qq
sudo apt install python3 python3-pip python3-venv git curl exuberant-ctags fonts-hack-ttf -y -qq
echo -e "\n${TEXT_SUCCESS} ✔${NC} Neovim dependencies was successfully installed!"

installVimPlug
echo -e "${TEXT_SUCCESS} ✔${NC} Vim Plug was successfully installed!"

sed '/call plug#end/q' init.vim > ~/.config/nvim/init.vim
vim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall'
rm ~/.config/nvim/init.vim
cp init.vim ~/.config/nvim/

echo -e "${TEXT_SUCCESS} ✔${NC} Neovim plugins was successfully installed!"

echo -e "\n${TEXT_SUCCESS} ✔${NC} Done, welcome to ${TEXT_PRIMARY}Neovim${NC}!\n"
