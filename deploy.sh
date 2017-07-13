#!/bin/bash

echo "k"

scp -i /home/el/.ssh/id_rsa profile.html machines@machinesentience.com:public_html/profile.html
