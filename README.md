# My dotfile configuration

## Setup Machine
  * Ubuntu

    ```shell
      sudo apt install curl
    ```

    ```shell
      curl --remote-name https://raw.githubusercontent.com/andymarthin/dotfiles/master/installer/ubuntu.sh && sudo chmod +x ubuntu.sh && ./ubuntu.sh 2>&1 | tee ~/laptop.log
    ```

  * Mac

    ```shell
      Coming Soon
    ```
## VIM
  ### Vundle


      git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  # FZF
  * OSX

    ```shell
      brew install fzf
    ```

  ### Ag

  * Mac

     ```shell
      brew install the_silver_searcher
     ```

  * Ubuntu

      ```shell
        sudo apt-get install silversearcher-ag
      ```

  ### ctags

  * Mac

      ```shell
        brew install ctags
      ```

  * Ubuntu

    ```shell
      sudo apt-get install exuberant-ctags
    ```
  ### vim-seeing-is-believing

  ```shell

  ```
## Install Plugin

  ```shell
    :PluginInstall
  ```
## Install Solargraph
  ```shell
    gem install solargraph
  ```