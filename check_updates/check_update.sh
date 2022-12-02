#!/bin/sh
# This script will be run from inside the Check Update container

# Get latest digest.txt from GitHub in case this has been updated elsewhere
git pull --no-rebase

# Get digest of latest image from the official base image
export DIGEST=$(skopeo inspect  --format "Digest: {{.Digest}}" docker://quay.io/fedora-ostree-desktops/kinoite:37)

# Get digest of last image from the digest.txt file 
export LAST_DIGEST=$(cat digest.txt)

# Check if the digests are the same
if [ "$DIGEST" = "$LAST_DIGEST" ]; then
    echo "Image has not changed"
else
    # If the digest of the base image is new, update the digest.txt file and push it to the git repository, triggering the new build at quay.io
    echo "New image is available"
    echo $DIGEST > digest.txt
    git add digest.txt
    git commit -m "Digest changed. $DIGEST"
    git push 
fi

echo $LAST_DIGEST
echo $DIGEST
