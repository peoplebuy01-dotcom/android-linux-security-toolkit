#!/usr/bin/env bash
# Read-only network overview | केवल जानकारी दिखाता है
set -u
printf '=== Network interfaces ===\n'
if command -v ip >/dev/null 2>&1; then ip -brief address; else echo 'ip command not found'; fi
printf '\n=== Listening sockets ===\n'
if command -v ss >/dev/null 2>&1; then ss -tuln; else echo 'ss command not found'; fi
printf '\nNo packets were captured and no network settings were changed.\n'
