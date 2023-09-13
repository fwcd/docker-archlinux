FROM alpine:edge AS bootstrap

ARG TARGETARCH
ARG TARGETVARIANT

# Set up the bootstrap tree
COPY /bootstrap/any /
COPY /bootstrap/${TARGETARCH}${TARGETVARIANT} /

# Set up the initial rootfs tree
COPY /rootfs/any /rootfs
COPY /rootfs/${TARGETARCH}${TARGETVARIANT} /rootfs

# Set up pacman
RUN apk add pacman && \
    cp -r /rootfs/etc/pacman.d /etc/ && \
    cp /rootfs/etc/pacman.conf /etc/pacman.conf && \
    sed -i 's/\(SigLevel\s\+=\s\+\).\+/\1Never/g' /etc/pacman.conf

# Install the base packages
RUN cat /etc/bootstrap-packages.txt | xargs pacstrap-docker /rootfs

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
