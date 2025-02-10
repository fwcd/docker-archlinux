# Docker images of Arch Linux

[![Build and Deploy](https://github.com/fwcd/docker-archlinux/actions/workflows/build-deploy.yml/badge.svg)](https://github.com/fwcd/docker-archlinux/actions/workflows/build-deploy.yml)

Unofficial, automated Docker multi-platform images of Arch Linux for the following architectures:

| Architecture | Docker Platform | Distribution |
| ------------ | --------------- | ------------ |
| x86_64 | `linux/amd64` | [Arch Linux](https://archlinux.org) |
| aarch64 | `linux/arm64` | [Arch Linux ARM](https://archlinuxarm.org) |
| armv7h | `linux/arm/v7` | [Arch Linux ARM](https://archlinuxarm.org) |
| riscv64 | `linux/riscv64` | [Arch Linux RISC-V](https://archriscv.felixc.at) |
| powerpc64le | `linux/ppc64le` | [Arch POWER](https://archlinuxpower.org) |

## Usage

To pull the Docker image, run

```sh
docker pull ghcr.io/fwcd/archlinux
```

If you have QEMU installed, you can also pass `--platform <someplatform>` (e.g. `linux/arm64`) to fetch the image for a specific architecture.

[^1]: The pentium4 architecture is for 32-bit CPUs that support SSE2 and the only one we support (for now). See [here](https://archlinux32.org/architecture) for a comparison of architectures supported by upstream.
