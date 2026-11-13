# Troubleshooting

| Symptom | Checks |
|---|---|
| `adb: command not found` | Install official Android SDK Platform Tools and check PATH |
| ADB shows `unauthorized` | Unlock your own device and accept its debugging authorization prompt |
| ADB shows no device | Try a data cable, USB mode, port, and official driver |
| `fastboot devices` empty | Confirm model-specific bootloader mode and cable; consult manufacturer support |
| Termux package errors | Update Termux and select a trusted mirror with `termux-change-repo` |
| `permission denied` | Check file permissions and Android storage permission; avoid unnecessary root |
| `command not found` | Check package installation and PATH |
| Disk full | Run `df -h` and inspect large directories with `du -sh` |

Do not paste unredacted logs publicly. Remove tokens, email addresses, serial numbers, phone numbers, and personal paths before sharing.
