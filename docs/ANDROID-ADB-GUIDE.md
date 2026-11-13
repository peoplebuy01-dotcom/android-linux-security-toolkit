# Android ADB Guide | Android डिवाइस प्रबंधन

ADB (Android Debug Bridge) developer tool है जो आपके authorized Android device और computer के बीच debugging connection बनाता है.

## Setup

1. Android Settings → About phone → Build number पर सामान्यतः 7 बार tap करके Developer Options enable करें (manufacturer steps अलग हो सकते हैं).
2. Developer Options में USB debugging enable करें.
3. USB से अपने computer से connect करें.
4. Phone पर दिखने वाले RSA authorization prompt को तभी accept करें जब computer आपका हो और आप उसे trust करते हों.
5. Official Platform Tools: https://developer.android.com/tools/releases/platform-tools

## Command reference

| Command | Purpose | Risk |
|---|---|---|
| `adb devices -l` | Authorized devices list | Low |
| `adb get-state` | Connection state | Low |
| `adb shell getprop ro.build.version.release` | Android version | Low |
| `adb shell df -h` | Storage overview | Low |
| `adb logcat -d` | Read current logs | Low; logs may contain private data |
| `adb install app.apk` | Install a chosen APK | Medium |
| `adb uninstall package.name` | Remove an app | High; app data may be lost |
| `adb pull /sdcard/file ./` | Copy accessible file to computer | Medium; privacy |
| `adb push ./file /sdcard/Download/` | Copy file to device | Medium; overwrites possible |

## Examples

```bash
adb devices -l
adb get-state
adb shell getprop ro.build.version.sdk
adb shell df -h /data
```

Expected output for `adb devices -l` includes a device serial and state such as `device`. If it says `unauthorized`, unlock your own phone and review the RSA prompt.

## Device diagnostics

| Goal | Command | Expected result | Risk |
|---|---|---|---|
| Manufacturer/model | `adb shell getprop ro.product.model` | Model string or blank | Low |
| Android release | `adb shell getprop ro.build.version.release` | Version string | Low |
| Battery status | `adb shell dumpsys battery` | Battery service fields | Low; device details |
| Storage | `adb shell df -h` | Mounted filesystems and free space | Low |
| Packages | `adb shell pm list packages -3` | Third-party package IDs | Low; privacy |
| Recent logs | `adb logcat -d -t 200` | Recent log lines | Low; logs can be sensitive |

Example: 

```bash
adb shell dumpsys battery
adb shell df -h /data
adb shell pm list packages -3
```

Output varies by Android release and manufacturer. Some commands may be restricted. Do not remove packages or change device settings based only on diagnostic output.

## File transfer details

```bash
adb pull /sdcard/Download/report.txt ./report.txt
adb push ./sample.txt /sdcard/Download/sample.txt
```

Confirm source and destination before transfer. Pulling copies private data to the computer; pushing can overwrite an existing destination file. Use test files first.

## Wireless debugging

Use Android's built-in **Wireless debugging** pairing workflow on a trusted private network. Follow the pairing IP/port and pairing code shown on the phone; do not expose ADB ports to the public internet. Disable Wireless debugging when finished.

## Logcat privacy

`adb logcat -d` can reveal app names, identifiers, and personal data. Store logs privately, redact them before sharing, and delete them when no longer needed.

## Fastboot

Fastboot is a bootloader interface. It can erase data or change firmware state. This guide intentionally does not provide unlock, FRP, lock bypass, or flashing recipes. Use manufacturer-supported recovery instructions only: https://support.google.com/android/answer/6088915

## Troubleshooting

- No device: try a known data-capable cable and another USB port.
- Unauthorized: accept the prompt on your own device; revoke debugging authorizations only through Android settings if needed.
- Linux permission error: use the official distro udev guidance; do not solve it by running every ADB command as root.
- Windows driver issue: install the device maker's official USB driver.
