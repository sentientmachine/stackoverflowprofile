#!/bin/bash

echo "k"

scp -i /var/lib/jenkins/.ssh/id_rsa profile.html machines@machinesentience.com:public_html/profile.html

cd /var/lib/jenkins/workspace/stackoverflowprofile

sudo /usr/bin/html2ps profile.html > ~/profile.ps

sudo cp ~/profile.ps /var/lib/jenkins/stackoverflowprofile/profile.ps

cd /var/lib/jenkins/stackoverflowprofile

rm profile*.png

git pull

convert -quality 100 profile.ps profile.png

convert -trim -quality 100 -append *.png profile.png

git add profile.png

git commit -m "jenkins update image"

git push
