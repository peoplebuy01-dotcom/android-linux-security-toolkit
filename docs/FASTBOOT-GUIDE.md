# Fastboot Guide | सावधानीपूर्वक उपयोग

Fastboot communicates with a device bootloader. It is not a general-purpose repair shortcut.

## Identify the interface safely

```bash
fastboot --version
fastboot devices
```

Expected: tool version and, when a compatible device is in bootloader mode, a device identifier.

## Risk boundaries

Fastboot commands can wipe user data, alter boot images, or make a device unbootable. This learning repository limits examples to version and device detection. No bootloader unlocking, partition flashing, FRP removal, lock bypass, or MDM bypass instructions are provided.

For recovery, use the phone manufacturer's official support channel and model-specific documentation. Back up data before any manufacturer-authorized repair.
