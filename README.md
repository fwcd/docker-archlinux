# Docker images of Arch Linux

[![Build and Deploy](https://github.com/fwcd/docker-archlinux/actions/workflows/build-deploy.yml/badge.svg)](https://github.com/fwcd/docker-archlinux/actions/workflows/build-deploy.yml)

Unofficial, automated Docker multi-platform images of Arch Linux for the following architectures:

| Architecture | Docker Platform | Distribution |
| ------------ | --------------- | ------------ |
| x86_64 | `linux/amd64` | [Arch Linux](https://archlinux.org) |
| aarch64 | `linux/arm64` | [Arch Linux ARM](https://archlinuxarm.org) |
| armv7h | `linux/arm/v7` | [Arch Linux ARM](https://archlinuxarm.org) |
| pentium4[^1] | `linux/386` | [Arch Linux 32](https://archlinux32.org) |

[^1]: The pentium4 architecture is for 32-bit CPUs that support SSE2 and the only one we support (for now). See [here](https://archlinux32.org/architecture) for a comparison of architectures supported by upstream.
