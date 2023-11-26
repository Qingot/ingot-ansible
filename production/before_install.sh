#!/bin/bash

# Check for ansible tools, and attempt to install if not

apt list installed python-pip &> /dev/null
if [ $? != 0 ]; then
    apt install -y python-pip
fi

pip list | grep -q ansible
if [ $? != 0 ]; then
    pip install ansible
fi
