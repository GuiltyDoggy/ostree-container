Test of rpm-ostree container deployment with customized container image of Kinoite.

### Manual Build
Run `build.sh` to push new image to Docker Hub. Image pushed to https://hub.docker.com/r/guiltydoggy/kinoite-gd

### Automated Build
The build system at [quay.io](https://quay.io/repository/guiltydoggy/kinoite-gd) is set up to trigger a new build of the custom image when a new commit is made to this GitHub repo. The Containerfile in the check_updates directory can be used to create a container that will use the check_update.sh script to check for updated base images and trigger a new custom build by pushing a new commit here. It queries the [base Kinoite 37 image](https://quay.io/repository/fedora-ostree-desktops/kinoite?tab=tags) and retrieve the digest of the latest build. The digest of the last build is stored in `digest.txt`. If a new digest is detected, the `digest.txt` is updated and pushed to this GitHub repo thus triggering the new build.  

#### Systemd Units
Examples of systemd unit files for automating the script are included.

### Usage
New image can be used to rebase using:

```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:docker.io/guiltydoggy/kinoite-gd:latest
```
or
```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:quay.io/guiltydoggy/kinoite-gd:latest
```
