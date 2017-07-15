#!/bin/bash

echo "starting"

#send the html over to the webspace
scp -i /var/lib/jenkins/.ssh/id_rsa profile.html machines@machinesentience.com:public_html/profile.html

#move to the place where jenkins can rebuild and redploy
cd /var/lib/jenkins/workspace/stackoverflowprofile

#convert the html to postscript
sudo /usr/bin/html2ps profile.html > ~/profile.ps

#Copy it over to the place where jenkins can do a git push to github so we can use https
sudo cp ~/profile.ps /var/lib/jenkins/stackoverflowprofile/profile.ps

#Go to the place where we can do the add, commit, push
cd /var/lib/jenkins/stackoverflowprofile

#clear out the old png files
rm profile*.png

#Any changes since last time, pull them in.
git pull

#Convert the postscript to png, for some boneheaded reason it converts every page of the postscript 
#file to a unique profile-#.png
convert -quality 100 profile.ps profile.png

#send the profile.png to webspace so we can see changes fast.
scp -i /var/lib/jenkins/.ssh/id_rsa profile.png machines@machinesentience.com:public_html/profile.png

#Force colorspace to RGB, append them all, trim whitespace.
convert -trim -colorspace sRGB *.png -append profile.png

#add commit push:
git add profile.png

git commit -m "jenkins update image"

git push
