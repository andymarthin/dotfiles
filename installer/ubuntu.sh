#!/bin/sh

# This is my script for setting up ubuntu machines in
# a similar setup to how thoughtbot's laptop script
# works (https://github.com/thoughtbot/laptop)

# how to run
# curl --remote-name https://raw.githubusercontent.com/andymarthin/dotfiles/master/installer/ubuntu.sh && sudo chmod +x ubuntu.sh && ./ubuntu.sh 2>&1 | tee ~/laptop.log

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

install_gem(){
  if [ ! "$(gem list $1 --installed)" ]; then
    gem install $1
  fi
}
append_to_zshrc() {
  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  grep -q -F "$1" "$zshrc" || echo "$1" >> "$zshrc"
}

set -e

[ ! -e "$HOME/.bin" ] && mkdir "$HOME/.bin"
[ ! -f "$HOME/.zshrc" ] && touch "$HOME/.zshrc"

append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'

sudo apt update && sudo apt upgrade -y

# basics
fancy_echo "Installing libraries for common gem dependencies ..."
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev snapd ctags git tmux vim zsh wget

if [ "$SHELL" = "$(getent passwd $(id -un) | awk -F : '{print $NF}')" ];then
  chsh -s "$(which zsh)"
fi

fancy_echo "Installing oh my zsh ..."
# oh my zsh
if [ ! -e "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

fancy_echo "Setup git config global user name ..."
if [ -z "$(git config --global user.name)" ]; then
  echo Your Name?
  read name
  git config --global user.name $name
fi

fancy_echo "Setup git config global user email ..."
if [ -z "$(git config --global user.email)"  ]; then
  echo Your Email?
  read email
  git config --global user.email $email
fi

#Heroku
fancy_echo "Installng heroku"
sudo snap install --classic heroku

# image manip
sudo apt-get install -y imagemagick libmagickwand-dev --fix-missing

# capybara-webkit dependencies
sudo apt-get install -y qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

# install nodejs
fancy_echo "Installing nodejs ..."
sudo snap install node --channel=12/stable --classic

# databases
fancy_echo "Installing Redis ..."
sudo apt-get install -y redis-server
fancy_echo "Installing Postgresql ..."
sudo apt-get install -y postgresql postgresql-contrib libpq-dev

# visual code
fancy_echo "Installing Vscode ..."
sudo snap install code --classic

# POSTMAN
fancy_echo "Installing Postman ..."
sudo snap install postman

# INSTALL GOOGLE CHROME
fancy_echo "Installing Google Chrome ..."
if [ ! -e "/etc/apt/sources.list.d/google-chrome.list" ]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
  sudo apt update
fi
[ "$(which google-chrome)" = "google-chrome not found" ] && sudo apt install -y google-chrome-stable

# Install Rbenv
fancy_echo "Installing Rbenv ..."
[ ! -e "$HOME/.rbenv" ] && git clone https://github.com/rbenv/rbenv.git ~/.rbenv
[ ! -e "$HOME/.rbenv/plugins/ruby-build" ] && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
if [ "$(which rbenv)" = "rbenv not found" ] || [ -z "$(which rbenv) " ]; then
  cd ~/.rbenv && src/configure && make -C src
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - --no-rehash)"
fi

# rbenv setup
append_to_zshrc 'export PATH="$HOME/.rbenv/bin:$PATH"'
append_to_zshrc 'eval "$(rbenv init - --no-rehash)"'

find_latest_ruby() {
  rbenv install -l | grep -v - | tail -1 | sed -e 's/^ *//'
}
ruby_version="$(find_latest_ruby)"

eval "$(rbenv init -)"
rbenv install -s "$ruby_version"

if ! rbenv versions | grep -Fq "$ruby_version"; then
  fancy_echo "Instaling latesest Ruby ..."
  rbenv install -s "$ruby_version"
fi

rbenv global "$ruby_version"
rbenv shell "$ruby_version"

gem update --system
install_gem "bundler"
install_gem "parity"
install_gem "rails"
