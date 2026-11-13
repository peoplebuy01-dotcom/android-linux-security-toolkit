#!/usr/bin/env bash
# Android & Linux Security Toolkit | Version 2.0.0
# English-only responsive dashboard for safe local diagnostics and authorized ADB inspection.
# No exploitation, bypasses, credential collection, stealth, or destructive actions.
set -uo pipefail
IFS=$'\n\t'
VERSION="2.0.0"
SCRIPT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
REPORTS="$ROOT/reports"

if [[ -t 1 ]]; then
  R=$'\033[0m'; B=$'\033[1m'; C=$'\033[36m'; G=$'\033[32m'; Y=$'\033[33m'; E=$'\033[31m'; D=$'\033[2m'
else R=""; B=""; C=""; G=""; Y=""; E=""; D=""; fi
has(){ command -v "$1" >/dev/null 2>&1; }
width(){
  local n=80
  if has tput && [[ -t 1 ]]; then n="$(tput cols 2>/dev/null || echo 80)"; fi
  [[ "$n" =~ ^[0-9]+$ ]] || n=80
  ((n<52)) && n=52
  ((n>100)) && n=100
  printf '%s' "$n"
}
W="$(width)"; CW=$((W-4))
rule(){ printf '%*s\n' "$W" '' | tr ' ' '-'; }
wrap(){ if has fold; then printf '%s\n' "$*" | fold -s -w "$CW"; else printf '%s\n' "$*"; fi; }
ok(){ printf '%s[OK]%s ' "$G" "$R"; wrap "$*"; }
note(){ printf '%s[NOTE]%s ' "$Y" "$R"; wrap "$*"; }
err(){ printf '%s[ERROR]%s ' "$E" "$R"; wrap "$*"; }
pause(){ printf '\n'; read -r -p "Press Enter to return to the menu..." _ || true; }
section(){ printf '\n%s%s%s\n' "$B" "$1" "$R"; rule; }
header(){
  [[ -t 1 ]] && clear 2>/dev/null || true
  printf '%s' "$C"
  if ((W>=72)); then
    printf '  _____ _   _ ____  ____   ___ ___  ____  _____\n'
    printf ' |_   _| | | |  _ \|  _ \ / _ \_ _|/ ___|| ____|\n'
    printf '   | | | |_| | |_) | |_) | | | | | \___ \|  _|\n'
    printf '   | | |  _  |  __/|  __/| |_| | |___) | |___\n'
    printf '   |_| |_| |_|_|   |_|    \___/|____/|_____|\n'
  else printf '  [ A L S T ]\n'; fi
  printf '%s%sANDROID & LINUX SECURITY TOOLKIT%s\n' "$R" "$B" "$R"
  printf '%sVersion %s | Defensive diagnostics | English edition%s\n' "$D" "$VERSION" "$R"
  rule
}
system_info(){
  header; section "SYSTEM OVERVIEW"
  printf 'Operating system : %s\n' "$(uname -s 2>/dev/null || echo Unknown)"
  printf 'Kernel           : %s\n' "$(uname -r 2>/dev/null || echo Unknown)"
  printf 'Architecture     : %s\n' "$(uname -m 2>/dev/null || echo Unknown)"
  printf 'Hostname         : %s\n' "$(hostname 2>/dev/null || echo Unknown)"
  if [[ -r /etc/os-release ]]; then . /etc/os-release; printf 'Distribution     : %s\n' "$PRETTY_NAME"; fi
  if has getprop; then
    printf 'Android maker    : %s\n' "$(getprop ro.product.manufacturer 2>/dev/null)"
    printf 'Android model    : %s\n' "$(getprop ro.product.model 2>/dev/null)"
    printf 'Android version  : %s\n' "$(getprop ro.build.version.release 2>/dev/null)"
    printf 'Android SDK      : %s\n' "$(getprop ro.build.version.sdk 2>/dev/null)"
  fi
  if has uptime; then printf 'Uptime           : '; uptime 2>/dev/null || true; fi
  ok "System information collected."
}
cpu_memory(){
  header; section "CPU AND MEMORY"
  if [[ -r /proc/cpuinfo ]]; then
    awk -F: '/model name|Hardware|Processor/ {gsub(/^[ \t]+/,"",$2); print "CPU model: " $2; exit}' /proc/cpuinfo
    printf 'Logical CPUs: '; if has nproc; then nproc; else grep -c '^processor' /proc/cpuinfo 2>/dev/null || echo Unknown; fi
  else note "CPU details unavailable in this environment."; fi
  if has free; then free -h; elif [[ -r /proc/meminfo ]]; then head -n 10 /proc/meminfo; else note "Memory details unavailable."; fi
  ok "CPU and memory report complete."
}
storage(){
  header; section "STORAGE AND FILESYSTEMS"
  if has df; then df -h; else note "df is not installed."; fi
  printf '\nRepository size:\n'; if has du; then du -sh "$ROOT" 2>/dev/null || true; fi
  ok "Read-only storage report complete."
}
battery(){
  header; section "BATTERY STATUS"
  if has termux-battery-status; then termux-battery-status 2>/dev/null || note "Termux:API permission may be required."
  elif has dumpsys; then dumpsys battery 2>/dev/null || note "Battery service unavailable."
  else note "Battery information is not exposed on this platform."; fi
}
processes(){
  header; section "PROCESS SNAPSHOT"
  if ! has ps; then err "ps is unavailable."; return; fi
  if ps -eo pid,comm,%cpu,%mem --sort=-%cpu >/dev/null 2>&1; then ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 18
  else ps | head -n 22; fi
  ok "Snapshot only; no process was stopped."
}
network(){
  header; section "NETWORK INTERFACES, ROUTES AND DNS"
  if has ip; then
    printf 'Interfaces:\n'; ip -brief address 2>/dev/null || ip address 2>/dev/null || true
    printf '\nRoutes:\n'; ip route 2>/dev/null || ip -6 route 2>/dev/null || true
  elif has ifconfig; then ifconfig 2>/dev/null || true
  else note "Install iproute2 or net-tools to view interfaces."; fi
  printf '\nDNS:\n'
  if [[ -r /etc/resolv.conf ]]; then awk '/^nameserver/ {print}' /etc/resolv.conf
  elif has getprop; then getprop | grep -E '\[net\.dns[0-9]*\]' || note "DNS properties unavailable."
  else note "DNS configuration unavailable."; fi
  note "Local configuration only. No hosts are scanned."
}
sockets(){
  header; section "LOCAL LISTENING SOCKETS"
  if has ss; then ss -tuln 2>/dev/null || true
  elif has netstat; then netstat -tuln 2>/dev/null || true
  else note "Install iproute2 (ss) or net-tools (netstat)."; fi
  note "Local socket listing only; no network scan."
}
connectivity(){
  header; section "BASIC HTTPS CONNECTIVITY"
  if has curl; then
    if curl -I --connect-timeout 5 --max-time 8 -sS https://example.com/ >/dev/null; then ok "HTTPS request to example.com succeeded."
    else note "HTTPS request failed. Check connection, DNS, date/time, or restrictions."; fi
  elif has ping; then
    ping -c 1 -W 3 1.1.1.1 2>/dev/null && ok "One ping reply received." || note "Ping failed or ICMP is blocked."
  else note "Install curl for a basic HTTPS check."; fi
  note "Only one basic connectivity request is made."
}
adb_ready(){
  if ! has adb; then err "ADB is not installed. Use official Android SDK Platform Tools."; return 1; fi
  local s; s="$(adb get-state 2>/dev/null || true)"
  if [[ "$s" != "device" ]]; then note "No authorized ADB device. Connect your own device and approve its RSA prompt."; adb devices -l 2>/dev/null || true; return 1; fi
  return 0
}
adb_status(){
  header; section "ADB CONNECTION STATUS"
  if ! has adb; then err "ADB is not installed."; return; fi
  adb version 2>/dev/null || true; printf '\nConnected devices:\n'; adb devices -l 2>/dev/null || true
  note "Authorize only devices you own or administer."
}
android_info(){
  header; section "ANDROID DEVICE INFORMATION"
  if ! adb_ready; then return; fi
  local p
  for p in ro.product.manufacturer ro.product.model ro.product.device ro.build.version.release ro.build.version.sdk ro.build.version.security_patch; do
    printf '%-34s : ' "$p"; adb shell getprop "$p" 2>/dev/null | tr -d '\r' || true
  done
  ok "Read-only Android properties retrieved."
}
android_battery(){
  header; section "ANDROID BATTERY DIAGNOSTICS"
  if ! adb_ready; then return; fi
  adb shell dumpsys battery 2>/dev/null || note "Battery service unavailable."
}
app_list(){
  header; section "INSTALLED USER APPLICATIONS"
  if ! adb_ready; then return; fi
  adb shell pm list packages -3 2>/dev/null | sort || note "Package list unavailable."
  note "Package names only. App data is not accessed."
}
logs(){
  header; section "ANDROID DIAGNOSTIC LOG CAPTURE"
  note "Logs may contain private notifications, identifiers, and app data."
  if ! adb_ready; then return; fi
  local answer out
  read -r -p "Capture up to 20 seconds of logs from your own device? Type YES: " answer || true
  [[ "$answer" == "YES" ]] || { note "Cancelled."; return; }
  if ! has timeout; then err "timeout utility missing; capture cancelled."; return; fi
  mkdir -p "$REPORTS" || { err "Cannot create reports folder."; return; }
  out="$REPORTS/android-log-$(date +%Y%m%d-%H%M%S).txt"
  (umask 077; timeout 20 adb logcat -v time > "$out" 2>&1) || true
  chmod 600 "$out" 2>/dev/null || true
  ok "Log saved locally: $out"; note "Redact private data before sharing."
}
dependencies(){
  header; section "DEPENDENCY CHECK"
  local x missing=0
  printf 'Required commands:\n'
  for x in bash uname df du ps awk grep sed sort head tr date find fold; do
    if has "$x"; then printf ' [OK] %s\n' "$x"; else printf ' [MISSING] %s\n' "$x"; missing=1; fi
  done
  printf '\nOptional commands:\n'
  for x in ip ss adb curl timeout free getprop termux-battery-status; do
    if has "$x"; then printf ' [AVAILABLE] %s\n' "$x"; else printf ' [NOT FOUND] %s\n' "$x"; fi
  done
  ((missing==0)) && ok "Required command check complete." || note "Some utilities are missing; related features may not work."
}
validate_scripts(){
  header; section "PROJECT SHELL SCRIPT VALIDATION"
  local f count=0 errors=0
  shopt -s nullglob
  for f in "$ROOT"/scripts/*.sh; do
    ((count+=1))
    if bash -n "$f" 2>/dev/null; then printf '%s[PASS]%s %s\n' "$G" "$R" "$(basename "$f")"
    else printf '%s[FAIL]%s %s\n' "$E" "$R" "$(basename "$f")"; ((errors+=1)); fi
  done
  shopt -u nullglob
  printf '\nChecked: %s | Errors: %s\n' "$count" "$errors"
  ((count>0 && errors==0)) && ok "All discovered scripts passed Bash syntax validation." || note "Review any failed scripts."
}
install_help(){
  header; section "OPTIONAL PACKAGE INSTALLATION GUIDE"
  if has pkg; then printf 'Termux:\n pkg update\n pkg install bash coreutils procps iproute2 curl android-tools\n'
  elif has apt-get; then printf 'Debian/Ubuntu:\n sudo apt update\n sudo apt install bash coreutils procps iproute2 curl android-tools\n'
  elif has dnf; then printf 'Fedora:\n sudo dnf install bash coreutils procps iproute curl android-tools\n'
  elif has pacman; then printf 'Arch:\n sudo pacman -S bash coreutils procps iproute2 curl android-tools\n'
  else note "Package manager not recognized. Check official OS documentation."; fi
  note "Suggestions only. No packages are installed by this toolkit."
}
docs(){
  header; section "DOCUMENTATION FILES"
  if [[ -d "$ROOT/docs" ]]; then find "$ROOT/docs" -maxdepth 1 -type f -name '*.md' -print 2>/dev/null | sort
  else note "Documentation folder not found."; fi
  printf '\nMain README: %s/README.md\nScript guide: %s/scripts/README.md\n' "$ROOT" "$ROOT"
}
safe_suite(){
  system_info; pause; cpu_memory; pause; storage; pause; processes; pause; network; pause; sockets; pause; dependencies; pause; validate_scripts
}
main(){
  local choice
  while true; do
    header; section "MAIN MENU"
    printf ' 1   System overview\n 2   CPU and memory report\n 3   Storage and filesystems\n'
    printf ' 4   Battery status (local API)\n 5   Process snapshot\n 6   Network interfaces, routes and DNS\n'
    printf ' 7   Local listening sockets\n 8   Basic HTTPS connectivity check\n 9   ADB connection status\n'
    printf '10   Android device information\n11   Android battery diagnostics (ADB)\n'
    printf '12   Installed user application list (ADB)\n13   Capture Android logs (explicit consent)\n'
    printf '14   Dependency and environment check\n15   Validate project shell scripts\n'
    printf '16   Optional package installation guide\n17   Browse documentation files\n'
    printf '18   Run safe diagnostics suite\n 0   Exit\n'
    rule
    read -r -p "Select an option [0-18]: " choice || choice=0
    case "$choice" in
      1) system_info; pause ;; 2) cpu_memory; pause ;; 3) storage; pause ;;
      4) battery; pause ;; 5) processes; pause ;; 6) network; pause ;;
      7) sockets; pause ;; 8) connectivity; pause ;; 9) adb_status; pause ;;
      10) android_info; pause ;; 11) android_battery; pause ;; 12) app_list; pause ;;
      13) logs; pause ;; 14) dependencies; pause ;; 15) validate_scripts; pause ;;
      16) install_help; pause ;; 17) docs; pause ;; 18) safe_suite; pause ;;
      0) printf '\n%sToolkit closed. Thank you.%s\n' "$G" "$R"; break ;;
      *) err "Invalid choice. Enter a number from 0 to 18."; sleep 1 ;;
    esac
  done
}
main
