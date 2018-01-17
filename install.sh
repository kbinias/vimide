#!/bin/bash

dotfiles="`pwd`/dotfiles"
destination=$HOME
#minttyrc=.minttyrc_solarized_light
copy_command="cp -sfR"

function copy_tmux
{
  $copy_command $dotfiles/tmux/. $destination
}

function copy_vim
{
  if [ ! -d $destination/.vim ]; then
    mkdir $destination/.vim
  fi
  $copy_command $dotfiles/vim/.vimrc $destination
  $copy_command $dotfiles/vim/.vim/. $destination/.vim
  if [ ! -d $destination/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $destination/.vim/bundle/Vundle.vim
  fi
}

function install_vim_plugins
{
  vim +PluginUpdate +qall
}

#copy_tmux
copy_vim
install_vim_plugins

python $destination/.vim/bundle/YouCompleteMe/install.py --clang-completer

