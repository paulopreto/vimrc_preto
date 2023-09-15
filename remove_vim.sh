#!/bin/bash

# Remove Vim and dependencies
sudo apt remove --purge vim vim-runtime vim-gtk vim-tiny vim-gui-common -y

# Remove YouCompleteMe's compiled components (if they exist)
if [ -d "~/.vim/plugged/YouCompleteMe" ]; then
    cd ~/.vim/plugged/YouCompleteMe
    ./install.py --all --force-clean
fi

# Remove Vim-Plug and associated plugins
rm -rf ~/.vim

# Remove user's .vimrc file
rm -f ~/.vimrc

echo "Vim and associated configurations have been removed."
