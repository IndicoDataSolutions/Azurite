#!/bin/bash

# Exit on any error
set -e

GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GIT_COMMIT=$(git rev-parse HEAD)

# Check if GIT_BRANCH and GIT_COMMIT are set
if [ -z "$GIT_BRANCH" ] || [ -z "$GIT_COMMIT" ]; then
    echo "Error: GIT_BRANCH and GIT_COMMIT environment variables must be set"
    exit 1
fi

# Define image name and tag
IMAGE_NAME="harbor.devops.indico.io/indico/azurite"
IMAGE_TAG="${GIT_BRANCH}.${GIT_COMMIT}"
FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"

# Build the image
echo "Building Docker image: ${FULL_IMAGE_NAME}"
docker build -t "${FULL_IMAGE_NAME}" .

# Push the image
echo "Pushing Docker image to registry"
docker push "${FULL_IMAGE_NAME}"

echo "Successfully built and pushed ${FULL_IMAGE_NAME}" 