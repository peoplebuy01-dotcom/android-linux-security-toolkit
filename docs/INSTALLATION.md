# Installation Guide | इंस्टॉलेशन

## Linux (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install -y git bash coreutils procps iproute2
git clone https://github.com/peoplebuy01-dotcom/android-linux-security-toolkit.git
cd android-linux-security-toolkit
```

## Termux (Android)

Install Termux from its official F-Droid or GitHub distribution. Avoid unofficial repackaged APKs.

```bash
pkg update && pkg upgrade
pkg install git bash coreutils procps
git clone https://github.com/peoplebuy01-dotcom/android-linux-security-toolkit.git
cd android-linux-security-toolkit
```

Optional Android platform tools availability varies by Termux repository/device. On a computer, install ADB from Google's official Android SDK Platform Tools page: https://developer.android.com/tools/releases/platform-tools

## Script permissions

You can run scripts without changing permissions:
```bash
bash scripts/linux_system_info.sh
```

Or make a script executable:
```bash
chmod u+x scripts/linux_system_info.sh
./scripts/linux_system_info.sh
```

Do not use `sudo` for these read-only scripts. Package installation changes your environment; review package names and official sources first.
