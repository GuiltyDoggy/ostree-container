#!/bin/sh
# This script will be run from inside the Check Update container


# Get the ostree.commit of the official base image of Kinoite
export UPSTREAM_DIGEST=$(skopeo inspect -n docker://quay.io/fedora-ostree-desktops/kinoite:37 | jq -r '.Labels["ostree.commit"]')

# Get the ostree.commit of our latest custom image 
export OUR_DIGEST=$(skopeo inspect -n docker://https://quay.io/repository/guiltydoggy/kinoite-gd:latest | jq -r '.Labels["ostree.commit"]')

# Check if the digests are the same
if [ "$UPSTREAM_DIGEST" = "$LAST_DIGEST" ]; then
    echo "Image has not changed"
else
    # New base image is available, start new custom image build
    echo "New image available. Starting build"
    set IMAGE (podman build -q -t kinoite-gd -f Containerfile)
    podman login -u guiltydoggy -p $QUAY_PASS quay.io/guiltydoggy 
    podman push $IMAGE docker.io/guiltydoggy/kinoite-gd:latest
fi

echo "Old: $LAST_DIGEST"
echo "New: $UPSTREAM_DIGEST"
