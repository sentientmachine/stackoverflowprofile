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

scp -i /var/lib/jenkins/.ssh/id_rsa profile.png machines@machinesentience.com:public_html/profile.png

#This crop and repage bullshit is to prevent imagemagick's convert program
#from casting the final image as color greyscale because the first one is
#greyscale.  This is a serious bug in the software, requires ridiculous workaround.
convert -trim -quality 100 xc:red *.png -append -crop +0+1 +repage profile.png

git add profile.png

git commit -m "jenkins update image"

git push
