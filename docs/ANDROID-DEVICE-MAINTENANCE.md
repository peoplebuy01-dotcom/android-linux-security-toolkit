# Android Device Management & Diagnostics

## Developer Options

Enable Developer Options only when needed. The menu path varies by manufacturer. USB debugging allows an authorized computer to issue developer commands; turn it off when finished and remove authorizations for computers you no longer trust.

## Device information

With your own authorized device connected:

```bash
adb devices -l
adb shell getprop ro.product.manufacturer
adb shell getprop ro.product.model
adb shell getprop ro.build.version.release
adb shell getprop ro.build.version.sdk
adb shell getprop ro.boot.hardware
```

Expected: text properties for the connected device. Some properties may be blank or restricted on particular builds.

## Battery and storage

```bash
adb shell dumpsys battery
adb shell df -h
adb shell du -sh /sdcard/Download
```

These are diagnostic queries. Android may restrict directory visibility. Battery values are estimates and should not be treated as calibrated health measurements.

## Performance diagnostics

```bash
adb shell uptime
adb shell cat /proc/meminfo
adb shell dumpsys meminfo
adb shell top -n 1
```

Output availability differs by Android release. Process information can be sensitive. Do not publish it without redaction.

## App/package inventory

```bash
adb shell pm list packages
adb shell pm list packages -3
adb shell dumpsys package PACKAGE_NAME
```

These inspect package metadata. Do not remove system packages based on online lists. Removing an app may delete its data or break device features.

## Install, uninstall, and file transfer

```bash
adb install ./your-own-test-app.apk
adb pull /sdcard/Download/test.txt ./test.txt
adb push ./sample.txt /sdcard/Download/sample.txt
```

Only install apps from trusted sources. Uninstall only apps you understand and are authorized to remove. Verify destination paths before push/pull; transfers may expose private data or overwrite files.

## Logcat

```bash
adb logcat -d -t 300
```

This reads a limited recent log buffer. Logs may include identifiers, URLs, or app data. Store privately and redact before sharing.

## scrcpy screen mirroring

Official project: https://github.com/Genymobile/scrcpy

Install scrcpy from the official project instructions for your desktop OS. Connect your own device with ADB authorization, then run:

```bash
scrcpy --version
scrcpy
```

The app mirrors and can control a device when authorized. Keep the USB/Wireless debugging trust boundary in mind; disconnect and disable debugging when finished. Do not mirror another person's phone without consent.

## Android Emulator

Official guide: https://developer.android.com/studio/run/emulator

Use Android Studio Device Manager to create and manage virtual devices. Check system image compatibility, available RAM/storage, and virtualization support. Emulator commands and options vary by SDK version; use the official command-line reference rather than unverified flags.

## Recovery and maintenance

For boot loops, account recovery, screen locks, FRP, or MDM, use the device maker's official support and account recovery process. Do not use unofficial bypass tools or scripts. Back up data before manufacturer-authorized resets; a factory reset can erase user data.
