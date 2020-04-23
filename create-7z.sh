#!/bin/bash 

# all registries
declare -a repos=(
)

PARENT_DIR="images"

if [ -d $PARENT_DIR ]; then
    cd $PARENT_DIR
else
    mkdir $PARENT_DIR
    cd $PARENT_DIR
fi

for repo in "${repos[@]}";
    do
		tmp=${repo##*/}   # remove last prefix ending in "/"
        DIRECTORY=${tmp%:*}   # remove suffix starting with "."
        docker pull $repo
		docker image save $repo -o "./${DIRECTORY}.tar"
		unamestr=`uname`
	done

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then 
	7z a -t7z -r "./images.7z" "./*"
else 
	'C:\Program Files\7-Zip\7z' a -t7z -r "./images.7z" "./*"
fi