# Cybersecurity Tools | Trusted tool directory

Install tools only from their official project sites or trusted OS repositories. Verify platform support, signatures/checksums where provided, and license terms. Availability changes by OS and release.

| Tool | Main use | Official source |
|---|---|---|
| Nmap | Network inventory on authorized networks | https://nmap.org/ |
| Wireshark | Packet analysis | https://www.wireshark.org/ |
| tcpdump | Packet capture | https://www.tcpdump.org/ |
| Burp Suite Community | Web application testing | https://portswigger.net/burp/communitydownload |
| OWASP ZAP | Web security testing | https://www.zaproxy.org/ |
| Metasploit Framework | Security validation in isolated labs | https://docs.metasploit.com/ |
| Nikto | Web server checks in authorized labs | https://github.com/sullo/nikto |
| OpenSSL | TLS and certificate utilities | https://www.openssl.org/ |
| Ghidra | Reverse engineering education | https://ghidra-sre.org/ |
| JADX | DEX to Java-like source viewer | https://github.com/skylot/jadx |
| Apktool | APK resource inspection/rebuild | https://apktool.org/ |
| MobSF | Mobile app security analysis | https://mobsf.github.io/ |
| Frida | Dynamic instrumentation of authorized apps | https://frida.re/ |
| Git | Version control | https://git-scm.com/ |
| Python | Scripting and automation | https://www.python.org/ |
| Termux | Android terminal | https://termux.dev/ |

## Safe first exercises

- Run `nmap --version`; do not scan a network unless you own it or have written authorization.
- Open a provided PCAP training sample in Wireshark; do not capture other people's traffic.
- Use OpenSSL to inspect a public test endpoint's certificate: `openssl s_client -connect example.com:443 -servername example.com`.
- Open an intentionally vulnerable sample APK in JADX; do not redistribute apps you do not own.
- Run MobSF only against a lab APK you are permitted to analyze.

Tool installation procedures vary. Follow each project's current official installation documentation rather than copying third-party binaries or outdated commands. Metasploit, Frida, scanners, and proxy tools must remain inside an isolated authorized lab.
