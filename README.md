# eams-linux
A **collection of scripts** used to automate the process of building a bootable .iso image of **EaMS Linux**, a tiny Linux distribution made for fun.

The OS itself consists of a Linux kernel, Libc (Musl) and Libstdc++ (Libgcc), Unix utils (Busybox), a bootloader with UEFI support (Limine) and other tools (Kbd, Opendoas and e2fsprogs).

## Project structure
- `config/`: settings for the kernel and Busybox releases distributed with the OS;
- `initrd/`: root of the initial RAM filesystem;
- `root/`: root of the ISO filesystem;
- `scripts/`: executable shell scripts that automate the building process.

## Building
### Make
Simply run `make` on the root of the code to start downloading and building the components of the OS. At the end you should have an `eams-linux.iso` file.

Run `make wayland` to include the `wayland` and `wayland-protocols` packages in the init filesystem of the OS.
You can boot the iso on QEMU with `make run`.

### With Docker
Run `scripts/make_with_docker.sh` from the root of the repo in order to build EaMS Linux inside a temporary docker container, with all its dependencies.
You can also run `scripts/make_with_docker.sh wayland` to include `wayland` and `wayland-protocols` as well.

### Building Dependencies
You will need *at least* `gcc`, `clang` (with `llvm`), `musl` (`musl-gcc` and `musl-clang`) and the Linux **kernel headers** for building and linking, and `xorriso` for making the iso file.

The building process downloads and compiles many different projects, with each one having its own dependencies.
I suggest checking out the packages listed inside `scripts/Dockerfile`, which should cover everything.
