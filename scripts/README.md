# Scripts Index / स्क्रिप्ट गाइड

## Main program — एक ही मेन्यू में Toolkit

**[toolkit.sh](toolkit.sh)** सभी मुख्य read-only diagnostics को एक bilingual terminal menu में जोड़ता है। इसमें बड़ा ASCII banner, Hindi + English menu और हर feature का अलग विकल्प है।

Repository root से चलाएँ:

```bash
bash scripts/toolkit.sh
```

Termux या Linux पर Bash उपलब्ध होना चाहिए। ADB वाले विकल्पों के लिए Android SDK Platform Tools और अपने फोन की अनुमति-प्राप्त ADB connection चाहिए।

## Menu में उपलब्ध सुविधाएँ

1. System information — OS, kernel, architecture, Android properties, memory
2. Storage report — filesystem और repository size
3. Process snapshot — process list
4. Local network overview — local interfaces और listening sockets
5. ADB connection check — जुड़े हुए devices
6. Android device details — basic Android properties
7. Android log collection — स्पष्ट YES confirmation के बाद अधिकतम 30 सेकंड
8. Tool installation hints — OS के अनुसार package suggestions; auto-install नहीं
9. Documentation browser — docs की सूची
10. Safe reports — read-only reports क्रम से

## अलग-अलग helper scripts

| Script | काम |
|---|---|
| `linux_system_info.sh` | Linux system summary |
| `linux_network_info.sh` | Local network overview |
| `disk_usage_report.sh` | Disk usage |
| `process_monitor.sh` | Process snapshot |
| `adb_connection_check.sh` | ADB status |
| `android_device_info.sh` | Android properties |
| `android_log_collector.sh` | Confirmed diagnostic log capture |
| `tool_installer.sh` | Package installation suggestions only |

हर script चलाने से पहले उसका source पढ़ें। उदाहरण: `less scripts/toolkit.sh`

## Safety notes

- यह toolkit defensive, read-only diagnostics के लिए है।
- कोई exploit, network scan, lock/FRP/MDM bypass, credential collection या privilege escalation नहीं है।
- Log files में निजी जानकारी हो सकती है; उन्हें सुरक्षित रखें और साझा करने से पहले redact करें।
- Tool installation helper सिर्फ सुझाव दिखाता है; वह packages install नहीं करता।

[मुख्य README](../README.md) · [Documentation Center](../docs/README.md)
