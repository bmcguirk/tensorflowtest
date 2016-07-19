#!/usr/bin/env bash

# Supposedly this speeds up Python...
CFLAGS='-O2'

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
# wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
# gunzip Python-3.5.2.tgz
# tar -xf Python-3.5.2.tar

# Get and install make
sudo apt-get -y install make

## Commenting out to try and use apt-get.
# Build Python 3.5.2
# cd Python-3.5.2
# sudo ./configure --with-ensurepip=install
# sudo make
# sudo make install

# Install and verify Python version.
sudo apt-get -y install python3 python3-pip
python3 --version



# Get Tensorflow
# Ubuntu/Linux 64-bit, CPU only, Python 3.5 - not working
# export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0-cp35-cp35m-linux_x86_64.whl 
# Python 3.4 - current version of Python installed by apt-get.
export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0-cp34-cp34m-linux_x86_64.whl

# Install Tensorflow.
sudo pip3 install --upgrade $TF_BINARY_URL

# Install Protobuf.
sudo pip3 install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/protobuf-3.0.0b2.post2-cp34-none-linux_x86_64.whl

# Print TF directory.
python3 -c 'import os; import inspect; import tensorflow; print(os.path.dirname(inspect.getfile(tensorflow)))'

# The above script ACTUALLY works, after a few iterations.