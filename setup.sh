#!/bin/bash

DOT_DIRECTORY="${HOME}/dotfiles"
REMOTE_URL="git@github.com:akannke/dotfiles.git"

has() {
	type "$1" > /dev/null 2>&1
}

usage() {
	name=`basename $0`
	cat <<EOF
Usage:
	$name [arguments] [command]

Commands:
	deploy
	initialize

Arguments:
	-f $(tput setaf 1)** warning **$(tput sgr0) Overwrite dotfiles.
	-h Print help (this message)
}
EOF
	exit 1
}

if [ ! -d ${DOT_DIRECTORY} ]; then
	echo "Downloading dotfiles..."
	mkdir ${DOT_DIRECTORY}

	if has "git"; then
		git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
	else
		curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
		tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
		rm -f ${HOME}/dotfiles.tar.gz
	fi
fi

vim_init(){
	if [ ! -d ${HOME}/.vim ]; then
		echo "Downloading vim-plug"
		if has "nvim"; then
				curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		else
				curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		fi
	fi
}

vim_init


