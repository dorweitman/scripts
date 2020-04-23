#!/bin/bash 

read -p "Path to folder with tars: " PATH_TO_TARS
read -p "Registry to push images: " REGISTRY
read -p "New tag for images: " NEW_TAG

for tar in $(ls ${PATH_TO_TARS})
do
    echo "Processing $tar"

    IMAGE_NAME_AND_TAG=$(docker load -i busybox.tar | awk '{print $3}') #get image name and tag from tar file 
    IMAGE_NAME=$(echo busybox:latest | awk -F: '{print $1}') #get image name with out 
    IMAGE_TO_PUSH="${REGISTRY}/${NEW_IMAGE_NAME}:${NEW_TAG}" #construct new image to push to registry 
    docker tag ${IMAGE_NAME_AND_TAG} ${IMAGE_TO_PUSH}
    docker push ${IMAGE_TO_PUSH}

    echo "Pushed image: ${IMAGE_TO_PUSH}"
done; 