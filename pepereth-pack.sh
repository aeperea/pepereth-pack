#!/bin/bash

package_list=(
    'zsh'
    'git'
    'emacs-mac --with-spacemacs-icon'
    'R'
    'elixir'
    'fasd'
    'ag'
    'postgres'
    'fortune'
    'redis'
    'nethack'
    'figlet'
    'Caskroom/cask/java'
)

brew_repos=(
    'railwaycat/homebrew-emacsmacport'
    'homebrew/science'
    'homebrew/games'
)

linux_repos=(
    'ppa:cassou/emacs'
)

osx_installer ()
{
    echo "[PEPERETH PACK] -----> Installing Peperth Pack for OSX"
    echo "[PEPERETH PACK] -----> (might need password for package installation)"

    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install gpg2
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash

    echo "[PEPERETH PACK] -----> Installing repositories"
    for i in "${brew_repos[@]}"
    do
        brew tap $i
    done

    echo "[PEPERETH PACK] -----> Intstalling packages"
    for i in "${package_list[@]}"
    do
        brew install $i
    done

    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

}

linux_installer ()
{
    echo "[PEPERETH PACK] -----> Installing Peperth Pack for Linux Debian"
    echo "[PEPERETH PACK] -----> (might need password for package installation)"
    sudo apt-get update

    echo "[PEPERETH PACK] -----> Installing repositories"
    for i in "${linux_repos[@]}"
    do
	      sudo apt-add-repository $i
    done

    echo "[PEPERETH PACK] -----> Intstalling packages"
    for i in "${package_list[@]}"
    do
	      sudo apt-get install -y $i
    done

    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
}

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
    linux_installer
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='osx'
    osx_installer
fi
