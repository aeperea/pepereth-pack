#!/bin/bash

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
    linux_installer
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='osx'
    osx_installer
fi

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
    echo "Installing Peperth Pack for OSX"
    echo "(might need password for package installation)"

    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install gpg2
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash

    echo "Installing repositories"
    for i in "${brew_repos[@]}"
    do
        brew tap $i
    done

    echo "Intstalling packages"
    for i in "${package_list[@]}"
    do
        brew install $i
    done

    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

}

linux_installer ()
{
    echo "Installing Peperth Pack for Linux Debian"
    echo "(might need password for package installation)"
    sudo apt-get update

    echo "Installing repositories"
    for i in "${linux_repos[@]}"
    do
	      apt-add-repository $i
    done

    echo "Intstalling packages"
    for i in "${package_list[@]}"
    do
	      apt-get install -y $i
    done

    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
}
