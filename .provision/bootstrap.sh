#!/usr/bin/env bash

# nginx
sudo apt-get update
sudo apt-get -y install nginx
sudo service nginx start

# set up nginx server
sudo cp /vagrant/.provision/nginx/nginx.conf /etc/nginx/sites-available/site.conf
sudo chmod 644 /etc/nginx/sites-available/site.conf
sudo ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
sudo service nginx restart

# clean /var/www
sudo rm -Rf /var/www

# symlink /var/www => /vagrant
ln -s /vagrant /var/www

# Download and unzip Python 3.5.2
wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
gunzip Python-3.5.2.tgz
tar -xf Python-3.5.2.tar

# Install openssl-dev
sudo apt-get -y install openssl-dev

# Get and install make
sudo apt-get -y install make

# Build Python 3.5.2
cd Python-3.5.2
sudo ./configure --with-ensurepip=install
sudo make
sudo make install
python3 --version

CFLAGS='-O2'

# Get Tensorflow
# Ubuntu/Linux 64-bit, CPU only, Python 3.5
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0-cp35-cp35m-linux_x86_64.whl 

# Install pelican, markdown
sudo pip3 install --upgrade $TF_BINARY_URL