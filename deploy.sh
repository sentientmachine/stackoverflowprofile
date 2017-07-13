#!/bin/bash

echo "k"

scp -i /home/el/.ssh/id_rsa profile.html machines@machinesentience.com:public_html/profile.html

cd /var/lib/jenkins/workspace/stackoverflowprofile; /usr/bin/html2ps profile.html > /tmp/profile.ps; sudo cp /tmp/profile.ps /var/lib/jenkins/workspace/stackoverflowprofile/profile.ps
