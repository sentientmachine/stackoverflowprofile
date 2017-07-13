#!/bin/bash

echo "k"

scp -i /home/el/.ssh/id_rsa profile.html machines@machinesentience.com:public_html/profile.html

html2ps profile.html > /tmp/profile.ps; sudo cp /tmp/profile.ps .
