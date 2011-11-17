#!/usr/bin/env bash
# bash < <(curl -s https://raw.github.com/rajraj/ubuntu/master/ruby)
# Inspired by https://github.com/thoughtbot/laptop

echo "Using apt-get to install OS packages so let's update it first ..."
  sudo apt-get update -y

echo "Installing OS packages. You will be prompted for your password ..."
  sudo apt-get install build-essential bison openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev -y

echo "Install Postgres, a great open source relational database ..."
  sudo apt-get install libmysqlclient15-dev mysql-server -y

echo "Install Redis, a key-value database ..."
  sudo apt-get install redis-server -y

echo "Installing ack, a good way to search through files ..."
  sudo apt-get install ack-grep -y

echo "Installing ImageMagick, good for cropping and re-sizing images ..."
  sudo apt-get install imagemagick --fix-missing -y

echo "Installing rbenv ..."
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  source ~/.bash_profile

echo "Installing ruby-build and then Ruby 1.9.2-p290 ..."
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build/
  sudo ./install.sh 

echo "Installing Ruby 1.9.2-p290 and making it the default Ruby ..."
  rbenv install 1.9.2-p290
  rbenv global 1.9.2-p290

echo "Updating Rubygems ..."
  sudo gem update --system
  rbenv rehash

echo "Installing Bundler Gem ..."
  gem install bundler --no-rdoc --no-ri
  rbenv rehash

echo "Installing Rails to write and run web applications ..."
  gem install rails --no-rdoc --no-ri

echo "Installing the Taps gem to push and pull SQL databases between development, staging, and production environments ..."
  gem install taps --no-rdoc --no-ri

echo "Downloading and installing Sphix v0.9.9 ..."
  cd && mkdir code && cd code
  curl -O http://sphinxsearch.com/files/sphinx-0.9.9.tar.gz
  tar -xvzf sphinx-0.9.9.tar.gz
  cd sphinx-0.9.9
  ./configure && make && sudo make install

echo "Checking for SSH key, generating one if it exists ..."
  [[ -f ~/.ssh/id_rsa.pub ]] || ssh-keygen -t rsa

echo "Copying public key to clipboard. Paste it into your Github account ..."
  [[ -f ~/.ssh/id_rsa.pub ]] && cat ~/.ssh/id_rsa.pub | xclip
  open https://github.com/account/ssh