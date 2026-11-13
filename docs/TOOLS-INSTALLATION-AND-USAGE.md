# Tool Installation & Usage Reference | टूल इंस्टॉलेशन

> **Version note:** Tool releases, package names, and supported platforms change. The official project documentation linked below is authoritative. Confirm current OS support and checksums/signatures before installing. Never download repackaged binaries from file-sharing sites.

## Platform overview

| Tool | Linux | Windows | macOS | Android/Termux |
|---|---|---|---|---|
| Nmap | Yes | Yes | Yes | Limited/community builds |
| Wireshark | Yes | Yes | Yes | No official desktop build |
| tcpdump | Yes | Yes | Yes | Depends on permissions/build |
| Burp Community | Java-supported platforms | Yes | Yes | No full supported Android setup |
| OWASP ZAP | Yes | Yes | Yes | No |
| Metasploit | Supported Linux/macOS setup | Limited | Supported setup | Not a supported beginner setup |
| Nikto | Perl environments | Via compatible Perl | Yes | Possible with dependencies |
| OpenSSL | Yes | Yes | Yes | Package availability varies |
| Ghidra | Yes | Yes | Yes | No |
| JADX | Yes | Yes | Yes | CLI/GUI support varies |
| Apktool | Yes | Yes | Yes | Community workflows vary |
| MobSF | Docker-supported environments | Docker Desktop | Docker Desktop | Not recommended on phone |
| Frida | Host OS support varies | Yes | Yes | Android device/host workflows |
| Git | Yes | Yes | Yes | Yes |
| Python | Yes | Yes | Yes | Yes |
| Termux | Android app | N/A | N/A | Yes |

## Installation and first verification

### Nmap
Official: https://nmap.org/book/install.html
- Linux: use your distribution's official package manager.
- Windows/macOS: use the official installer/package guidance.
- Verify: `nmap --version`.
- Lab: inspect your own lab machine's local interface configuration before any scan. Only scan explicitly authorized targets.
- Common issue: raw-packet features may require elevated permissions; do not use root casually.

### Wireshark
Official: https://www.wireshark.org/docs/
- Install from the official download page or OS repository.
- Verify: `wireshark --version` or open About.
- Lab: open a supplied sample PCAP and filter DNS packets with `dns`.
- Common issue: capture permissions; follow official OS capture-group guidance. Analyze sample files if live capture permissions are unavailable.
- Safety: captures can contain credentials and private traffic. Do not capture networks or people without permission.

### tcpdump
Official: https://www.tcpdump.org/
- Install from your OS repository.
- Verify: `tcpdump --version`.
- Safe exercise: inspect a trusted sample capture file with `tcpdump -r sample.pcap`.
- Common issue: permission errors on live interfaces. Do not work around this by running arbitrary scripts as root.
- Safety: use sample PCAPs or a lab network you own.

### Burp Suite Community
Official: https://portswigger.net/burp/communitydownload
- Download the Community Edition from PortSwigger.
- Supported desktop platforms and Java/runtime requirements are listed by PortSwigger.
- Verify: launch the application and inspect Help/About.
- Lab: use PortSwigger Web Security Academy labs or an app you own.
- Common issue: browser proxy/certificate configuration. Use a dedicated lab browser profile and remove lab CA certificates afterward.
- Safety: never proxy another person's traffic or install a lab CA on your daily-use device.

### OWASP ZAP
Official: https://www.zaproxy.org/getting-started/
- Use the official installer or supported container instructions.
- Verify: `zap.sh -version` where available, or Help/About.
- Lab: use the intentionally vulnerable OWASP Juice Shop in a local isolated environment.
- Common issue: Java/runtime or port conflicts; consult current official installation guide.
- Safety: passive scanning first; active scanning only against systems you own or have written authorization to test.

### Metasploit Framework
Official: https://docs.metasploit.com/
- Follow the official install guide for a supported OS. Do not use random one-line installer scripts.
- Verify: `msfconsole --version` where the package exposes it.
- Lab: learn workspace and help commands in an isolated intentionally vulnerable lab.
- Common issue: database service configuration; follow the current official documentation.
- Safety: this project documents no exploitation of real targets. Keep all validation inside an isolated lab with explicit authorization.

### Nikto
Official: https://github.com/sullo/nikto
- Install from the official repository or trusted distribution package.
- Verify: `nikto -Version`.
- Lab: study the help output and run only against a local intentionally vulnerable training server you control.
- Common issue: Perl modules or TLS dependencies; follow upstream instructions.
- Safety: web server scanning creates traffic and may trigger alerts. Never scan third-party sites without written permission.

### OpenSSL
Official: https://www.openssl.org/
- Install from your OS's trusted package source or official platform package guidance.
- Verify: `openssl version -a`.
- Lab: inspect a public test endpoint certificate: `openssl s_client -connect example.com:443 -servername example.com`.
- Common issue: certificate chain failures may reflect local trust-store or network configuration.
- Safety: do not expose private keys; never paste private key material into issues.

### Ghidra
Official: https://ghidra-sre.org/
- Download the official release and check the current JDK requirements.
- Supported desktop OS details are in the official installation guide.
- Verify: launch Ghidra and inspect Help/About.
- Lab: analyze a toy program you compiled yourself.
- Common issue: unsupported Java version or archive extraction problems.
- Safety: analyze software you own or are authorized to inspect; respect license and distribution rights.

### JADX
Official: https://github.com/skylot/jadx
- Use official releases or build instructions; avoid unofficial APK download mirrors.
- Desktop GUI and CLI availability depends on release/platform.
- Verify: `jadx --version` if installed on PATH.
- Lab: open your own demo APK and inspect its manifest and package structure.
- Common issue: large APK memory use; close other apps or analyze a smaller training APK.
- Safety: decompiled output is approximate and may contain sensitive proprietary code.

### Apktool
Official: https://apktool.org/
- Follow the official install guide for the wrapper and required Java runtime.
- Verify: `apktool --version`.
- Lab: decode resources from an APK you own: `apktool d demo.apk -o demo-decoded`.
- Common issue: framework/resource decode errors; use the matching official Apktool version and consult upstream troubleshooting.
- Safety: rebuilding or signing an APK changes the artifact. Do not redistribute modified third-party apps.

### MobSF
Official: https://mobsf.github.io/
- Prefer the current official Docker deployment guide on a computer with adequate resources.
- Verify using the health/status information documented for your selected release.
- Lab: submit only a deliberately vulnerable training APK or your own app.
- Common issue: Docker daemon, port conflicts, and memory requirements.
- Safety: analysis reports may contain endpoints, source paths, and secrets. Keep them private.

### Frida
Official: https://frida.re/docs/installation/
- Install host tools using the official Python/package instructions and obtain device components only from official release assets.
- Verify: `frida --version`.
- Lab: follow the official tutorial against a toy process or an app you own in an isolated environment.
- Common issue: host/device version mismatch and architecture mismatch.
- Safety: dynamic instrumentation is powerful. No stealth, credential capture, protection bypass, or unauthorized app modification is covered here.

### Git
Official: https://git-scm.com/
- Install through the official OS package manager or Git downloads.
- Verify: `git --version`.
- Lab: `git init demo && cd demo && git status`.
- Common issue: identity configuration; set a display name/email you control with `git config --global user.name` and `git config --global user.email`.
- Safety: never commit tokens, passwords, private keys, or personal logs.

### Python
Official: https://www.python.org/
- Install from python.org or the OS package manager.
- Verify: `python3 --version` and `python3 -m pip --version`.
- Lab: `python3 -c "print('Hello, security lab')"`.
- Common issue: multiple Python versions and PATH conflicts; use virtual environments for project dependencies.
- Safety: inspect third-party packages and avoid running unknown scripts.

### Termux
Official: https://termux.dev/ and https://github.com/termux/termux-app
- Install using an official distribution source and do not mix APK/plugin signing sources.
- Verify: `termux-info`.
- Lab: install Git and run `git --version`.
- Common issue: outdated app build or mirror errors; consult official Termux guidance.
- Safety: Android app sandbox restrictions remain. Do not root or bypass Android security to follow this guide.

## General troubleshooting checklist

1. Confirm OS, architecture, and tool version.
2. Read the official installation page for that exact release.
3. Verify downloaded artifacts where upstream provides checksums/signatures.
4. Check PATH and runtime dependencies.
5. Read the exact error; do not paste secrets or private logs into public issues.
6. Avoid running unknown installers with administrator/root privileges.
