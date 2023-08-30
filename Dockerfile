# TODO: We'd want to use $BUILDPLATFORM, perhaps with our own image eventually
FROM --platform=linux/amd64 docker.io/archlinux AS bootstrap

ARG TARGETARCH
ARG TARGETARCH

WORKDIR /rootfs

# Copy the overlay files into the new rootfs
COPY /rootfs/any /rootfs
COPY /rootfs/${TARGETARCH}${TARGETVARIANT} /rootfs

# Install the base packages
COPY pacstrap-docker /usr/local/bin
RUN pacstrap-docker /rootfs base base-devel

# Remove the current pacman database (usually outdated very soon anyway)
RUN rm /rootfs/var/lib/pacman/sync/*

FROM scratch

# Copy the bootstrapped rootfs
COPY --from=bootstrap /rootfs /

# Set up locale
ENV LANG=en_US.UTF-8
RUN locale-gen

# Set up pacman-key without distributing the lsign key
# See https://gitlab.archlinux.org/archlinux/archlinux-docker/-/blob/301942f9e5995770cb5e4dedb4fe9166afa4806d/README.md#principles
# Source: https://gitlab.archlinux.org/archlinux/archlinux-docker/-/blob/301942f9e5995770cb5e4dedb4fe9166afa4806d/Makefile#L22
RUN pacman-key --init && \
    pacman-key --populate && \
    bash -c "rm -rf etc/pacman.d/gnupg/{openpgp-revocs.d/,private-keys-v1.d/,pubring.gpg~,gnupg.S.}*"

CMD ["/usr/bin/bash"]
