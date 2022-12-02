### Create container image for running script to check for changes
```
podman build \
   -t ostree-update-check \
   -f Containerfile.check_update
```

### Run the container and provide your GitHub personal access token to allow the container to push digest.txt to the repo
```
podman run \
   --name=ostree-check-update \
   -e "GIT_TOKEN=YourPersonalAccessToken" \
guiltydoggy/ostree-update-check
```

### Generate systemd unit to run the container
```
podman generate systemd -n -f ostree-update-check
```
