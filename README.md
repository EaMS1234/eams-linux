# eams-linux
A **collection of scripts** used to automate the process of building a bootable .iso image of **EaMS Linux**, a (very) tiny Linux distribution made for fun.

The OS itself consists of a Linux kernel with Musl (libc), Busybox & Opendoas (utils) and Limine as a bootloader (with UEFI support).

## Project structure
- `config/`: base configuration for the kernel and Busybox releases distributed with the OS;
- `initrd/`: root of the initial RAM filesystem;
- `root/`: root of the ISO filesystem;
- `scripts/`: executable shell scripts that automate the building process.

## Building
### Make
Simply run `make` on the root of the code to start downloading and building the components of the OS. At the end you should have an `eams-linux.iso` file.

Run `make ui` to include the `wayland` and `wayland-protocols` packages in the init filesystem of the OS.
You can boot the iso on QEMU with `make run`.

### Make with Docker
Run `scripts/make_with_docker.sh` from the root of the repo to build EaMS Linux inside a temporary docker container, with all its dependencies.
You can also run `scripts/make_with_docker.sh ui` to include `wayland` and `wayland-protocols` as well.

### Dependencies
You will need *at least* `gcc`, `clang` (with `llvm`), `musl` (`musl-gcc` and `musl-clang`) and the Linux **kernel headers** for building and linking, and `xorriso` for making the iso file.

The building process downloads and compiles many different projects, with each one having its own dependencies.
I suggest checking out the packages listed inside `scripts/make_with_docker.sh`, on the variables `TOOLS` and `LIBS`, which should cover everything.
