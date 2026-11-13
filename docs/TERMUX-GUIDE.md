# Termux Guide | Android पर Linux terminal

Termux Android के लिए terminal और Linux-like environment देता है. यह rooted phone की आवश्यकता नहीं रखता; Android sandbox की सीमाएँ लागू रहती हैं.

## Install safely

Use official project distribution information: https://termux.dev/ and https://github.com/termux/termux-app. Do not mix APKs/plugins from different signing sources.

## First setup

```bash
pkg update
pkg upgrade
pkg install git bash coreutils procps
termux-info
```

## Useful commands

```bash
pwd
ls -lah
df -h
free -h
ps -A
ip address
```

## Shared storage

`termux-setup-storage` requests Android shared-storage permission and creates access links. Review the Android permission prompt. Do not assume Termux can read protected app-private data.

## ADB note

ADB host/target arrangements differ by Android version and device. Wireless debugging must be paired through Android's own UI on a trusted network. Never expose ADB to the internet.

## Troubleshooting

- Package mirror issue: run `termux-change-repo` and choose a trusted official mirror.
- Permission denied: check Android app permissions and the path; do not root the device just to access private app data.
- Storage full: inspect `df -h` and remove only files you recognize.
