#!/bin/bash
set -x

# Set the repo URL
REPO_URL="https://<TOKEN>@dev.azure.com/<PROJECT>/voting-app/_git/voting-app"

# Clone the git repo into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repo directory
cd /tmp/temp_repo

# To change the image tag in a deployment.yaml file. $1 represents the service name. $2 is repository name. $3 is the build tag.
sed -i "s|image:.*|image: <ACR_LOGIN_SERVER>/$2:$3|g" k8s-specifications/$1-deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Updated Kubernetes manifest"

# Push the changes back into the repo
git push

# Cleanup: remove the tmp directory
rm -rf /tmp/temp_repo
