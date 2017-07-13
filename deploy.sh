#!/bin/bash

echo "k"

scp -i /var/lib/jenkins/id_rsa profile.html machines@machinesentience.com:public_html/profile.html

cd /var/lib/jenkins/workspace/stackoverflowprofile

sudo /usr/bin/html2ps profile.html > ~/profile.ps; 

sudo cp ~/profile.ps /var/lib/jenkins/stackoverflowprofile/profile.ps

cd /var/lib/jenkins/stackoverflowprofile

git add profile.ps

git commit -m "jenkins update image"

git push
