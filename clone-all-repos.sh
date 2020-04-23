#!/bin/bash 
#
# Clones all repos into ./services
# Installs all NPM Modules

# all repos (ssh)
declare -a repos=(
)

# parent dir
PARENT_DIR="services"

if [ -d $PARENT_DIR ]; then
    cd $PARENT_DIR
else
    mkdir $PARENT_DIR
    cd $PARENT_DIR
fi

for repo in "${repos[@]}";
    do
        tmp=${repo##*/}   # remove last prefix ending in "/"
        DIRECTORY=${tmp%.*}   # remove suffix starting with "."
        echo $DIRECTORY
        if [ -d "$DIRECTORY" ]; then
            # Control will enter here if $DIRECTORY exists.
            rm -rf $DIRECTORY
        fi
        
        git clone $repo
        cd $DIRECTORY
        npm install --silent 
        cd ../
    done