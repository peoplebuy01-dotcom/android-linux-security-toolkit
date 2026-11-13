# Android Application Security Lab

## Lab rules

Use an emulator or spare device and an intentionally vulnerable training app that you are authorized to test. Keep test accounts and data synthetic. Do not inspect another person's app data or intercept traffic without permission.

## Lab 1 — APK anatomy

An APK is a ZIP-based package. Inspect a copy you are allowed to analyze:

```bash
file training-app.apk
unzip -l training-app.apk
```

Look for `AndroidManifest.xml`, `classes.dex`, `resources.arsc`, and resource directories. Binary manifest files need Android-aware tools for readable output.

## Lab 2 — Manifest and permissions

Use JADX or Apktool from official sources. Record requested permissions and compare them with the app's documented features. A permission is not proof of misuse; assess context and runtime behavior.

## Lab 3 — Static analysis

Open the lab APK in JADX. Search for hard-coded test credentials, insecure logging, cleartext network settings, exported components, and weak cryptographic patterns. Report evidence and remediation; do not exploit real services.

## Lab 4 — Network and TLS concepts

Use a lab proxy and a test app/server you control. Understand DNS, TCP, TLS certificates, hostname validation, and certificate chains. Never install a proxy CA certificate on a personal daily-use device. Remove lab certificates after testing.

## Lab 5 — MobSF

Deploy MobSF using its official documentation. Upload only the intentionally vulnerable APK or your own app. Treat reports as sensitive; they may expose source paths, endpoints, or secrets.

## Lab 6 — Frida

Use Frida only with an app and device you own or are authorized to instrument. Start with the official tutorial and a deliberately vulnerable sample. This repository does not include stealth, evasion, credential capture, or bypass recipes.

## Reporting template

- App/build and lab environment:
- Test scope and authorization:
- Finding:
- Evidence (redacted):
- Impact:
- Reproduction in lab:
- Recommended fix:
- Retest result:

Further reading: OWASP Mobile Application Security Testing Guide (MASTG), https://mas.owasp.org/MASTG/
