#!/bin/bash
# Use this to build the custom image (one-time, on demand). If you want an automated process, use quay.io with a build trigger and use the container in /check_updates

# Source environment variables for password
source .env

set IMAGE (podman build -q -t kinoite-gd -f Containerfile)
podman login -u guiltydoggy -p $DOCKERPASS docker.io/guiltydoggy
podman push $IMAGE docker.io/guiltydoggy/kinoite-gd:latest
