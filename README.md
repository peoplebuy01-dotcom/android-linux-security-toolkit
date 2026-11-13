# Android & Linux Security Toolkit

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE) [![Docs](https://img.shields.io/badge/Docs-Hindi%20%2B%20English-orange)](docs/) [![安全](https://img.shields.io/badge/Focus-Defensive%20Security-success)](SECURITY.md)

**A bilingual, beginner-to-advanced learning platform for Android administration, Linux operations, and authorized application security testing.**

यह repository Android और Linux को सुरक्षित तरीके से समझने, diagnostics करने और अपने या स्पष्ट अनुमति वाले lab systems पर security सीखने के लिए है।

## Start here

1. [Getting Started](docs/GETTING-STARTED.md)
2. [Installation](docs/INSTALLATION.md)
3. [Android ADB Guide](docs/ANDROID-ADB-GUIDE.md)
4. [Linux Command Handbook](docs/LINUX-COMMAND-HANDBOOK.md)
5. [Termux Guide](docs/TERMUX-GUIDE.md)
6. [Cybersecurity Tools](docs/CYBERSECURITY-TOOLS.md)
7. [Android Security Lab](docs/ANDROID-SECURITY-LAB.md)
8. [Android Device Maintenance](docs/ANDROID-DEVICE-MAINTENANCE.md)
9. [Tool Installation & Usage](docs/TOOLS-INSTALLATION-AND-USAGE.md)
10. [Networking & TLS Lab](docs/NETWORKING-AND-TLS-LAB.md)
11. [Fastboot Guide](docs/FASTBOOT-GUIDE.md)
12. [Learning Roadmap](docs/LEARNING-ROADMAP.md)
13. [Troubleshooting](docs/TROUBLESHOOTING.md)
14. [Quality Assurance](docs/QUALITY-ASSURANCE.md)
15. [FAQ](docs/FAQ.md)
16. [Documentation Index](docs/README.md)

## Learning roadmap

| Level | Topics | Outcome |
|---|---|---|
| Beginner | Terminal basics, files, permissions, ADB | Safely inspect your own device |
| Intermediate | Linux services, networking, logs, APK structure | Diagnose and understand systems |
| Advanced | Static analysis, TLS, lab instrumentation, DevSecOps | Assess authorized test apps |

## Repository map

- `docs/` — bilingual guides and labs
- `scripts/` — read-only diagnostic helpers
- `examples/` — safe command examples
- `.github/workflows/` — automated quality checks

## Quick start

Linux:
```bash
git clone https://github.com/peoplebuy01-dotcom/android-linux-security-toolkit.git
cd android-linux-security-toolkit
bash scripts/linux_system_info.sh
```

Termux:
```bash
pkg update
pkg install git bash coreutils android-tools
git clone https://github.com/peoplebuy01-dotcom/android-linux-security-toolkit.git
cd android-linux-security-toolkit
bash scripts/android_device_info.sh
```

Scripts are diagnostic and do not modify device settings. Some Android information requires USB debugging and an authorized ADB connection.

## Safety first

Only test devices, apps, networks, and accounts you own or have explicit permission to assess. Do not use this project to bypass screen locks, FRP, MDM, account protections, or access controls. Never scan public or third-party systems without written authorization. See [SECURITY.md](SECURITY.md).

## Contributing

Issues, corrections, translations, and safe lab improvements are welcome. Read [CONTRIBUTING.md](CONTRIBUTING.md) and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## License

MIT — see [LICENSE](LICENSE). Third-party tools retain their own licenses and terms.
