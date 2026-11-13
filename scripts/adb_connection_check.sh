#!/usr/bin/env bash
# Check an authorized ADB connection | अपने authorized device की जाँच
set -u
if ! command -v adb >/dev/null 2>&1; then echo 'ADB not found. Install official Android SDK Platform Tools.'; exit 1; fi
adb version
echo 'Connected devices:'
adb devices -l
echo 'Accept authorization only for your own trusted computer.'
