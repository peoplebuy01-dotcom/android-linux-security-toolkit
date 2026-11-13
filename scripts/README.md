# Scripts Index

## Main program: Unified Toolkit v2.0.0

**[toolkit.sh](toolkit.sh)** is the main English-language terminal dashboard. It includes a large ASCII title on wider terminals, a compact title on narrow screens, and responsive text wrapping to reduce clipped menu descriptions.

Run it from the repository root:

```bash
bash scripts/toolkit.sh
```

Or run it from any current directory:

```bash
bash /path/to/android-linux-security-toolkit/scripts/toolkit.sh
```

## Features in the main menu

1. System overview
2. CPU and memory report
3. Storage and filesystem report
4. Battery status (when Termux:API is available)
5. Process snapshot
6. Network interfaces, routes and DNS
7. Local listening sockets
8. Basic HTTPS connectivity check
9. ADB connection status
10. Android device information
11. Android battery diagnostics through authorized ADB
12. Installed user application package names through authorized ADB
13. Optional Android log capture with explicit confirmation
14. Dependency and environment check
15. Bash syntax validation for project scripts
16. Platform-specific package installation suggestions
17. Documentation file listing
18. Safe diagnostics suite

## Other helper scripts

| Script | Purpose |
|---|---|
| `linux_system_info.sh` | Linux system summary |
| `linux_network_info.sh` | Local network overview |
| `disk_usage_report.sh` | Disk usage report |
| `process_monitor.sh` | Process snapshot |
| `adb_connection_check.sh` | ADB connection status |
| `android_device_info.sh` | Android device properties |
| `android_log_collector.sh` | Confirmed diagnostic log capture |
| `tool_installer.sh` | Package installation suggestions only |

## Compatibility notes

- Requires Bash 4+ where available; Termux and mainstream Linux distributions are supported targets.
- Some commands are optional and will be reported as unavailable rather than silently assumed.
- ADB features require official Android SDK Platform Tools, USB/Wireless debugging enabled by the device owner, and an authorized connection.
- Battery status through Termux requires the Termux:API app and matching package.
- On narrow terminals the banner switches to a compact form and long status messages are wrapped. Terminal emulators differ, so verify on your own device.

## Safety and privacy

- This is a defensive diagnostics utility, not an exploitation framework.
- It does not scan third-party networks, bypass screen locks/FRP/MDM, collect credentials, or stop processes.
- Log capture requires typing `YES`, saves locally under `reports/`, and applies restrictive file permissions where supported. Logs may contain private information; redact before sharing.
- The HTTPS check makes one ordinary request to `example.com`.
- Package installation commands are displayed as suggestions; the script does not install packages automatically.

[Main README](../README.md) · [Documentation Center](../docs/README.md)
