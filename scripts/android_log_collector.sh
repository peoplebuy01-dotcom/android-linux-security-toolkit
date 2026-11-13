#!/usr/bin/env bash
# Collect a short logcat snapshot after explicit confirmation.
# Logs may contain private data. Keep them secure and redact before sharing.
set -u
if ! command -v adb >/dev/null 2>&1; then echo 'ADB not found.'; exit 1; fi
if [ "$(adb get-state 2>/dev/null || true)" != "device" ]; then echo 'No authorized device.'; adb devices -l; exit 1; fi
read -r -p 'Logs may contain private data. Save up to 60 seconds? Type YES: ' answer
[ "$answer" = "YES" ] || { echo 'Cancelled.'; exit 0; }
out="android-log-$(date +%Y%m%d-%H%M%S).txt"
echo 'Capturing for up to 60 seconds; Ctrl-C stops early.'
timeout 60 adb logcat -v time > "$out" 2>&1 || true
chmod 600 "$out"
echo "Saved locally: $out"
echo 'Review/redact before sharing; delete when no longer needed.'
