#!/bin/sh

# This is my script for setting up ubuntu machines in
# a similar setup to how thoughtbot's laptop script
# works (https://github.com/thoughtbot/laptop)

# how to run
# curl --remote-name [change to raw file url] && sudo chmod +x ubuntu.sh && ./ubuntu.sh 2>&1 | tee ~/laptop.log

sudo apt update && sudo apt upgrade -y
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

# add all ppa's first
#sudo add-apt-repository -y "deb https://cli-assets.heroku.com/branches/stable/apt ./"
# sudo add-apt-repository -y ppa:martin-frost/thoughtbot-rcm
# curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
# sudo apt-get install -y nodejs

# basics
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev snapd ctags git tmux vim zsh wget
chsh -s "$(which zsh)"
# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

if [ -z "$(git config --global user.name)" ]; then
  echo Your Name?
  read name
  git config --global user.name $name
fi

if [ -z "$(git config --global user.email)"  ]; then
  echo Your Email?
  read email
  git config --global user.email $email
fi


# heroku
#sudo apt-get install -y heroku
sudo snap install --classic heroku


# image manip
sudo apt-get install -y imagemagick libmagickwand-dev --fix-missing

# capybara-webkit dependencies
sudo apt-get install -y qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x


# sudo apt-get install -y nodejs
sudo snap install node --channel=10/stable --classic


# databases
sudo apt-get install -y redis-server
sudo apt-get install -y postgresql postgresql-contrib libpq-dev

# visual code
sudo snap install code --classic

# POSTMAN
sudo snap install postman

# INSTALL GOOGLE CHROME 
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install -y google-chrome-stable

# language related
[ ! -e "$HOME/.rbenv" ] && git clone https://github.com/rbenv/rbenv.git ~/.rbenv
[ ! -e "$HOME/.rbenv/plugins/ruby-build" ] && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
if [ -z "$(which rbenv)" ]; then
  cd ~/.rbenv && src/configure && make -C src
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
  rbenv install -s "$ruby_version"
fi

rbenv global "$ruby_version"
rbenv shell "$ruby_version"

gem update --system
gem install bundler
gem install parity
