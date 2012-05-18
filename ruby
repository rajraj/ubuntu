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

echo "Installing RVM ..."
curl -L get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo "Installing ruby 1.9.3 p320"
rvm install 1.9.3

echo "Updating Rubygems ..."
sudo gem update --system

echo "Installing Bundler Gem ..."
gem install bundler --no-rdoc --no-ri

echo "Installing Rails to write and run web applications ..."
gem install rails --no-rdoc --no-ri

echo "Installing the Taps gem to push and pull SQL databases between development, staging, and production environments ..."
gem install taps --no-rdoc --no-ri

echo "Installing Elastic Search for full text searching ..."
cd ~
sudo apt-get install openjdk-7-jre -y

wget https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-0.19.3.tar.gz -O elasticsearch.tar.gz

tar -xf elasticsearch.tar.gz
rm elasticsearch.tar.gz
mv elasticsearch-* elasticsearch
sudo mv elasticsearch /usr/local/share

curl -L http://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master | tar -xz
mv *servicewrapper*/service /usr/local/share/elasticsearch/bin/
rm -Rf *servicewrapper*
sudo /usr/local/share/elasticsearch/bin/service/elasticsearch install
sudo /etc/init.d/elasticsearch start
