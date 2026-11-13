# Safe Command Examples

Run from the repository root. These examples inspect local system information and do not change settings.

## Linux
```bash
pwd
ls -lah
df -h
free -h
ip -brief address
ss -tuln
```

## Android via an authorized ADB connection
```bash
adb devices -l
adb get-state
adb shell getprop ro.build.version.release
adb shell df -h /data
```

Review privacy before sharing command output. Device identifiers, paths, and logs can be sensitive.
