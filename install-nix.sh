#!/bin/sh

# This script installs the Nix package manager on your system by
# downloading a binary distribution and running its installer script
# (which in turn creates and populates /nix).

{ # Prevent execution if this script was only partially downloaded
oops() {
    echo "$0:" "$@" >&2
    exit 1
}

umask 0022

tmpDir="$(mktemp -d -t nix-binary-tarball-unpack.XXXXXXXXXX || \
          oops "Can't create temporary directory for downloading the Nix binary tarball")"
cleanup() {
    rm -rf "$tmpDir"
}
trap cleanup EXIT INT QUIT TERM

require_util() {
    command -v "$1" > /dev/null 2>&1 ||
        oops "you do not have '$1' installed, which I need to $2"
}

case "$(uname -s).$(uname -m)" in
    Linux.x86_64)
        hash=a3ecb68cbc2af3b64c96e5ed85e1172a99b5945874d2d6f4b685e43cb196344a
        path=hg2906h6n0p1lp5hk3mfs418i5wchvgn/nix-2.28.1-x86_64-linux.tar.xz
        system=x86_64-linux
        ;;
    Linux.i?86)
        hash=699c579ba96a389d134226ae12b85cf90cd0bfeeab68f915c1ce3a7fcf597ab7
        path=akglcv97dcfhfbif5ri2cwqgg5s4jvgm/nix-2.28.1-i686-linux.tar.xz
        system=i686-linux
        ;;
    Linux.aarch64)
        hash=4fa343e1c09c05e860e53b1fafbae2d6570136028681a7330d7d34694eae90fa
        path=08v02qf8sm0fvwrivawvq23gilfk7jcx/nix-2.28.1-aarch64-linux.tar.xz
        system=aarch64-linux
        ;;
    Linux.armv6l)
        hash=fda0b1637f994ffca7363ff899aa3658b5b2b0090dea2c9fb4f2e7956793773a
        path=0cggdcc497rxfcgpmgrm3cj727ihs8l8/nix-2.28.1-armv6l-linux.tar.xz
        system=armv6l-linux
        ;;
    Linux.armv7l)
        hash=a020e035a95819d145535142257a9af909cfb51a81b65c69ff8c62aee19eddb4
        path=x572hvn4a8vsgp2b2qbjv0yg94hf1qpp/nix-2.28.1-armv7l-linux.tar.xz
        system=armv7l-linux
        ;;
    Linux.riscv64)
        hash=6e9af2b22cb63c7c41b9c4a3a033d902ec8b7c1ee0307a9ac53e5e02d1996b3c
        path=k66323fz3acdd7kbfjh30231a99sbs9y/nix-2.28.1-riscv64-linux.tar.xz
        system=riscv64-linux
        ;;
    Darwin.x86_64)
        hash=5c84dc30f47967b2921c06cce1f78f886f1f7b3566f1cdc490021dcb293c5f8c
        path=pdp44s2pqwkjgycajjg876q0ayahzcir/nix-2.28.1-x86_64-darwin.tar.xz
        system=x86_64-darwin
        ;;
    Darwin.arm64|Darwin.aarch64)
        hash=e0673c823f2ce1483e1b4a0bc50304a503e91389e91a240fe107382898e279cc
        path=51x2m0i6rvkb9cjvqhni8zvk20qwb4i6/nix-2.28.1-aarch64-darwin.tar.xz
        system=aarch64-darwin
        ;;
    *) oops "sorry, there is no binary distribution of Nix for your platform";;
esac

# Use this command-line option to fetch the tarballs using nar-serve or Cachix
if [ "${1:-}" = "--tarball-url-prefix" ]; then
    if [ -z "${2:-}" ]; then
        oops "missing argument for --tarball-url-prefix"
    fi
    url=${2}/${path}
    shift 2
else
    url=https://releases.nixos.org/nix/nix-2.28.1/nix-2.28.1-$system.tar.xz
fi

tarball=$tmpDir/nix-2.28.1-$system.tar.xz

require_util tar "unpack the binary tarball"
if [ "$(uname -s)" != "Darwin" ]; then
    require_util xz "unpack the binary tarball"
fi

if command -v curl > /dev/null 2>&1; then
    fetch() { curl --fail -L "$1" -o "$2"; }
elif command -v wget > /dev/null 2>&1; then
    fetch() { wget "$1" -O "$2"; }
else
    oops "you don't have wget or curl installed, which I need to download the binary tarball"
fi

echo "downloading Nix 2.28.1 binary tarball for $system from '$url' to '$tmpDir'..."
fetch "$url" "$tarball" || oops "failed to download '$url'"

if command -v sha256sum > /dev/null 2>&1; then
    hash2="$(sha256sum -b "$tarball" | cut -c1-64)"
elif command -v shasum > /dev/null 2>&1; then
    hash2="$(shasum -a 256 -b "$tarball" | cut -c1-64)"
elif command -v openssl > /dev/null 2>&1; then
    hash2="$(openssl dgst -r -sha256 "$tarball" | cut -c1-64)"
else
    oops "cannot verify the SHA-256 hash of '$url'; you need one of 'shasum', 'sha256sum', or 'openssl'"
fi

if [ "$hash" != "$hash2" ]; then
    oops "SHA-256 hash mismatch in '$url'; expected $hash, got $hash2"
fi

unpack=$tmpDir/unpack
mkdir -p "$unpack"
tar -xJf "$tarball" -C "$unpack" || oops "failed to unpack '$url'"

script=$(echo "$unpack"/*/install)

[ -e "$script" ] || oops "installation script is missing from the binary tarball!"
export INVOKED_FROM_INSTALL_IN=1
"$script" "$@"

} # End of wrapping
