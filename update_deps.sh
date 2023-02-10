#!/bin/bash

set -eux

if [ "$(uname)" == "Darwin" ]; then
    echo "Running update for MacOS environment"

    CMDS='echo "Updating brew"; brew update && brew upgrade && brew cleanup'

    echo "Please confirm this script is being run from a non-privileged user account"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) read -p "Enter admin username: " admin && su $admin -c "$CMDS"; break;;
            No ) exit;;
        esac
    done
elif [ "$(uname)" == "Linux" ]; then
    echo "Running update for Ubuntu environment"
    sudo apt update && sudo apt upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y
else
    echo "This script has not been tested on your operating system/environment. Exiting."
    exit 1
fi

# Update python packages
pip3 list --outdated --format=json | jq -r '.[] | "\(.name)==\(.latest_version)"' | xargs -n1 pip3 install -U

# Update rust dist and binary packages
rustup update && cargo install-update -a

# Clean unused docker resources
docker system prune -a

echo "Done! You may wish to update node dependencies manually: \"ncu -g\""