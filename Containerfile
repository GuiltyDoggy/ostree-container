# This is where to define the customizations of your image. The base image is what is used in FROM. Use this Containerfile in quay.io for automated builds.

FROM quay.io/fedora-ostree-desktops/kinoite:37
RUN  rpm-ostree install bat doas exa vim zsh cockpit && \
     rpm-ostree cleanup -m && \
     systemctl enable cockpit.socket && \
     ostree container commit
COPY doas.conf /etc/doas.conf
