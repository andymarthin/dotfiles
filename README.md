# My dotfile configuration

## Setup Ubuntu Machine
 `sudo apt install curl`

 `curl --remote-name https://raw.githubusercontent.com/andymarthin/dotfiles/master/installer/ubuntu.sh && sudo chmod +x ubuntu.sh && ./ubuntu.sh 2>&1 | tee ~/laptop.log`

## Setup Mac Machine
  `Coming Soon`
## VIM
  ### Vundle
  `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

  ### FZF
  * OSX
    `brew install fzf`

  ### Ag

  * Mac

     `brew install the_silver_searcher`

  * Ubuntu

      `$ sudo apt-get install silversearcher-ag`

  ### ctags

  * Mac

      `brew install ctags`

  * Ubuntu

     ` $ sudo apt-get install exuberant-ctags`

  ### vim-seeing-is-believing

    `gem install seeing_is_believing`

## Install Plugin

  `:PluginInstall`