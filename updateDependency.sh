#!/bin/bash 
#
# Updates a dependency 

read -p "Dependency to update: " dependency

declare -a repos=(
    "git@gitlab.com:zdropbox/pull-service.git"
)

PARENT_DIR="servicesToUpdate"

if [ -d $PARENT_DIR ]; then 
    cd $PARENT_DIR

else 
    mkdir $PARENT_DIR
    cd $PARENT_DIR

fi 

for repo in "${repos[@]}"
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
        npm install --save $dependency
        git add ./package.json
        git commit -m "chore: update ${dependency} dependency"
        git push 
        cd ../
    done 

cd ../ 
rm -rf $PARENT_DIR