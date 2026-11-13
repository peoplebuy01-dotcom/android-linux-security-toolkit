#!/usr/bin/env bash
# Suggest basic packages; this script does not install anything.
set -u
if command -v pkg >/dev/null 2>&1; then
 echo 'Termux: pkg install git bash coreutils procps'
elif command -v apt-get >/dev/null 2>&1; then
 echo 'Debian/Ubuntu: sudo apt install git bash coreutils procps'
elif command -v dnf >/dev/null 2>&1; then
 echo 'Fedora: sudo dnf install git bash coreutils procps'
elif command -v pacman >/dev/null 2>&1; then
 echo 'Arch: sudo pacman -S git bash coreutils procps'
else
 echo 'Unsupported package manager. Consult official OS documentation.'
fi
echo 'No packages were installed. Review the suggestion first.'
