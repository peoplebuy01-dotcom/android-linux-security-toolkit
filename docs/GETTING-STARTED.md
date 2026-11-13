# Getting Started | शुरुआत करें

## 1. Prerequisites

- Android phone or Linux computer
- Terminal: Termux on Android, or Bash on Linux
- Git and an internet connection for installation
- A spare/test device or emulator for security labs

## 2. Clone the project

```bash
git clone https://github.com/peoplebuy01-dotcom/android-linux-security-toolkit.git
cd android-linux-security-toolkit
```

## 3. Run a safe diagnostic

Linux:
```bash
bash scripts/linux_system_info.sh
bash scripts/disk_usage_report.sh
```

Android with ADB installed and an authorized device connected:
```bash
bash scripts/adb_connection_check.sh
bash scripts/android_device_info.sh
```

## 4. Learning sequence

1. Learn `pwd`, `ls`, `cd`, `cat`, and file permissions.
2. Understand Android Developer Options and ADB authorization.
3. Read system logs without changing system state.
4. Learn IP addressing, DNS, and TLS concepts.
5. Inspect a deliberately vulnerable training APK.
6. Document findings and remediation.

## Safety labels

- **LOW** — read-only information.
- **MEDIUM** — changes local configuration or installs software; review first.
- **HIGH** — destructive or security-sensitive; not included in default scripts.

Hindi: किसी भी command को चलाने से पहले उसका उद्देश्य और प्रभाव समझें। Unknown script को root/sudo से कभी न चलाएँ।
