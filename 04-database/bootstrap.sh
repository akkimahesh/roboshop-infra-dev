#!/bin/bash
set -xe

component=$1
environment=$2   # don't use env (reserved)

# Install system python tools (platform-python)
dnf install -y python3 python3-pip

# Install ansible using SYSTEM python
pip3 install ansible botocore boto3

# Force ansible to use platform-python
export ANSIBLE_PYTHON_INTERPRETER=/usr/libexec/platform-python

ansible-pull \
  -U https://github.com/daws-76s/roboshop-ansible-roles-tf.git \
  -e component=$component \
  -e env=$environment \
  main-tf.yaml
