#!/usr/bin/env bash
# Read basic information from an authorized Android device.
set -u
if ! command -v adb >/dev/null 2>&1; then echo 'ADB not found. Install official Platform Tools.'; exit 1; fi
if [ "$(adb get-state 2>/dev/null || true)" != "device" ]; then
  echo 'No authorized device. Connect your own phone and approve its RSA prompt.'
  adb devices -l; exit 1
fi
for prop in ro.product.manufacturer ro.product.model ro.build.version.release ro.build.version.sdk; do
  printf '%s: ' "$prop"
  adb shell getprop "$prop" 2>/dev/null | tr -d '\r'
done
echo 'Read-only query complete.'
