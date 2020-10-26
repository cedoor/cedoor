#!/bin/bash -e

#
# Variables
#

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

setConfigurationFiles() {
    curl -sfLo "${HOME}/.gitcommit" --create-dirs https://raw.githubusercontent.com/cedoor/cedoor/main/git/.gitcommit
    curl -sfLo "${HOME}/.gitconfig" --create-dirs https://raw.githubusercontent.com/cedoor/cedoor/main/git/.gitconfig
}

#
# Main script
#

sudo pacman -Syuq git
echo -e "\n${TEXT_SUCCESS} ✔${NC} Git was successfully installed!"

progress setConfigurationFiles " Setting configuration files" "${TEXT_SUCCESS} ✔${NC} Configuration files have been set up correctly!\n\n"
