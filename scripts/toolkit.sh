#!/usr/bin/env bash
# Android & Linux Security Toolkit - Unified safe diagnostics menu
# Version: 1.0.0
# Purpose: Read-only local diagnostics and authorized ADB checks.
# No scanning, exploitation, bypassing, privilege escalation, or destructive actions.

set -uo pipefail
IFS=$'\n\t'

VERSION="1.0.0"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
APP_NAME="ANDROID • LINUX SECURITY TOOLKIT"

# Terminal colors (disabled automatically when output is not a terminal).
if [[ -t 1 ]]; then
  C_RESET=$'\033[0m'; C_BOLD=$'\033[1m'; C_CYAN=$'\033[36m'
  C_GREEN=$'\033[32m'; C_YELLOW=$'\033[33m'; C_RED=$'\033[31m'
  C_BLUE=$'\033[34m'; C_DIM=$'\033[2m'
else
  C_RESET=""; C_BOLD=""; C_CYAN=""; C_GREEN=""
  C_YELLOW=""; C_RED=""; C_BLUE=""; C_DIM=""
fi

line() { printf '%s\n' "────────────────────────────────────────────────────────────"; }
header() {
  clear 2>/dev/null || true
  printf '%s' "$C_CYAN"
  printf '  █████╗ ███╗   ██╗██████╗ ██████╗  ██████╗ ██╗██████╗\n'
  printf ' ██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔═══██╗██║██╔══██╗\n'
  printf ' ███████║██╔██╗ ██║██║  ██║██████╔╝██║   ██║██║██║  ██║\n'
  printf ' ██╔══██║██║╚██╗██║██║  ██║██╔══██╗██║   ██║██║██║  ██║\n'
  printf ' ██║  ██║██║ ╚████║██████╔╝██║  ██║╚██████╔╝██║██████╔╝\n'
  printf ' ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝╚═════╝\n'
  printf '%s' "$C_RESET"
  printf '%s%s  %s%s\n' "$C_BOLD" "$C_CYAN" "$APP_NAME" "$C_RESET"
  printf '  %sVersion %s | Defensive diagnostics | Hindi + English%s\n' "$C_DIM" "$VERSION" "$C_RESET"
  line
}
say_ok()   { printf '%s[OK]%s %s\n' "$C_GREEN" "$C_RESET" "$*"; }
say_info() { printf '%s[INFO]%s %s\n' "$C_CYAN" "$C_RESET" "$*"; }
say_warn() { printf '%s[NOTE]%s %s\n' "$C_YELLOW" "$C_RESET" "$*"; }
say_err()  { printf '%s[ERROR]%s %s\n' "$C_RED" "$C_RESET" "$*"; }
pause() { printf '\n'; read -r -p "Enter दबाएँ menu पर लौटने के लिए..." _ || true; }
have() { command -v "$1" >/dev/null 2>&1; }

show_system_info() {
  header
  printf '%sSYSTEM INFORMATION / सिस्टम जानकारी%s\n\n' "$C_BOLD" "$C_RESET"
  printf 'OS: %s\n' "$(uname -s 2>/dev/null || printf 'Unknown')"
  printf 'Kernel: %s\n' "$(uname -r 2>/dev/null || printf 'Unknown')"
  printf 'Architecture: %s\n' "$(uname -m 2>/dev/null || printf 'Unknown')"
  if have hostname; then printf 'Hostname: %s\n' "$(hostname 2>/dev/null || printf 'Unavailable')"; fi
  if have uptime; then printf 'Uptime: '; uptime 2>/dev/null || true; fi
  if have getprop; then
    printf '\nAndroid properties:\n'
    printf 'Manufacturer: '; getprop ro.product.manufacturer 2>/dev/null || true
    printf 'Model: '; getprop ro.product.model 2>/dev/null || true
    printf 'Android: '; getprop ro.build.version.release 2>/dev/null || true
    printf 'SDK: '; getprop ro.build.version.sdk 2>/dev/null || true
  fi
  printf '\nMemory:\n'
  if have free; then free -h; elif [[ -r /proc/meminfo ]]; then head -n 8 /proc/meminfo; else say_warn "Memory details unavailable."; fi
  say_ok "Read-only system report complete."
}

show_storage() {
  header
  printf '%sSTORAGE REPORT / स्टोरेज रिपोर्ट%s\n\n' "$C_BOLD" "$C_RESET"
  if have df; then df -h; else say_err "df command उपलब्ध नहीं है."; fi
  printf '\nRepository size:\n'
  if have du; then du -sh "$REPO_ROOT" 2>/dev/null || say_warn "Folder size नहीं मिल पाया."; fi
  say_ok "कोई file delete या modify नहीं की गई."
}

show_processes() {
  header
  printf '%sPROCESS SNAPSHOT / चल रहे प्रोग्राम%s\n\n' "$C_BOLD" "$C_RESET"
  if have ps; then
    if ps -eo pid,comm,%cpu,%mem --sort=-%cpu >/dev/null 2>&1; then
      ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 16
    else
      ps | head -n 20
    fi
  else
    say_err "ps command उपलब्ध नहीं है."
  fi
  say_ok "यह केवल एक snapshot है; कोई process बंद नहीं किया गया."
}

show_network() {
  header
  printf '%sLOCAL NETWORK OVERVIEW / नेटवर्क जानकारी%s\n\n' "$C_BOLD" "$C_RESET"
  if have ip; then
    printf '%sNetwork interfaces:%s\n' "$C_BOLD" "$C_RESET"
    ip -brief address 2>/dev/null || ip address 2>/dev/null || true
  else
    say_warn "ip command नहीं मिला."
  fi
  printf '\n'
  if have ss; then
    printf '%sListening sockets (local view):%s\n' "$C_BOLD" "$C_RESET"
    ss -tuln 2>/dev/null || true
  else
    say_warn "ss command नहीं मिला."
  fi
  say_warn "यह local जानकारी है; कोई network scan या packet capture नहीं किया गया."
}

adb_ready() {
  if ! have adb; then
    say_err "ADB नहीं मिला. Official Android SDK Platform Tools install करें."
    return 1
  fi
  local state
  state="$(adb get-state 2>/dev/null || true)"
  if [[ "$state" != "device" ]]; then
    say_warn "Authorized ADB device नहीं मिला. अपने फोन पर USB debugging और RSA prompt जाँचें."
    adb devices -l 2>/dev/null || true
    return 1
  fi
  return 0
}

show_adb_devices() {
  header
  printf '%sADB CONNECTION CHECK%s\n\n' "$C_BOLD" "$C_RESET"
  if ! have adb; then say_err "ADB उपलब्ध नहीं है."; return; fi
  adb version 2>/dev/null || true
  printf '\nConnected devices:\n'
  adb devices -l 2>/dev/null || true
  say_warn "केवल अपने डिवाइस को authorize करें."
}

show_android_info() {
  header
  printf '%sANDROID DEVICE DETAILS%s\n\n' "$C_BOLD" "$C_RESET"
  if ! adb_ready; then return; fi
  local prop
  for prop in ro.product.manufacturer ro.product.model ro.build.version.release ro.build.version.sdk; do
    printf '%-32s : ' "$prop"
    adb shell getprop "$prop" 2>/dev/null | tr -d '\r' || true
  done
  say_ok "केवल basic properties पढ़ी गईं."
}

collect_logs() {
  header
  printf '%sANDROID LOG COLLECTION%s\n\n' "$C_BOLD" "$C_RESET"
  say_warn "Logs में निजी जानकारी, notifications या identifiers हो सकते हैं."
  if ! adb_ready; then return; fi
  local answer out
  read -r -p "अपने device से अधिकतम 30 सेकंड के logs save करें? Type YES: " answer || true
  if [[ "$answer" != "YES" ]]; then say_info "Cancelled."; return; fi
  if ! have timeout; then
    say_err "timeout command उपलब्ध नहीं है; safety के लिए log capture नहीं किया."
    return
  fi
  out="$REPO_ROOT/android-log-$(date +%Y%m%d-%H%M%S).txt"
  say_info "अधिकतम 30 सेकंड capture हो रहा है..."
  timeout 30 adb logcat -v time > "$out" 2>&1 || true
  chmod 600 "$out" 2>/dev/null || true
  say_ok "Log file local रूप से save हुई: $out"
  say_warn "इसे share करने से पहले redact करें; काम पूरा होने पर delete करें."
}

show_tool_hints() {
  header
  printf '%sPACKAGE / TOOL INSTALLATION HELP%s\n\n' "$C_BOLD" "$C_RESET"
  if have pkg; then
    printf 'Termux suggestion:\n  pkg update && pkg install git bash coreutils procps iproute2 android-tools\n'
  elif have apt-get; then
    printf 'Debian/Ubuntu suggestion:\n  sudo apt update && sudo apt install git bash coreutils procps iproute2 android-tools\n'
  elif have dnf; then
    printf 'Fedora suggestion:\n  sudo dnf install git bash coreutils procps iproute android-tools\n'
  elif have pacman; then
    printf 'Arch suggestion:\n  sudo pacman -S git bash coreutils procps iproute2 android-tools\n'
  else
    say_warn "Package manager पहचाना नहीं गया. अपने OS की official documentation देखें."
  fi
  say_warn "यह केवल सुझाव है. कोई package install नहीं किया गया."
}

show_guides() {
  header
  printf '%sDOCUMENTATION / सीखने की गाइड%s\n\n' "$C_BOLD" "$C_RESET"
  printf 'Repository: %s\n\n' "$REPO_ROOT"
  if [[ -d "$REPO_ROOT/docs" ]]; then
    find "$REPO_ROOT/docs" -maxdepth 1 -type f -name '*.md' -print 2>/dev/null | sort
  else
    say_warn "docs folder नहीं मिला."
  fi
  printf '\nREADME: %s/README.md\n' "$REPO_ROOT"
}

run_all_reports() {
  show_system_info
  pause
  show_storage
  pause
  show_processes
  pause
  show_network
  pause
  show_adb_devices
  pause
  show_android_info
}

main_menu() {
  local choice
  while true; do
    header
    printf '%sMAIN MENU / मुख्य मेन्यू%s\n' "$C_BOLD" "$C_RESET"
    printf '  1) System information       सिस्टम जानकारी\n'
    printf '  2) Storage report           स्टोरेज रिपोर्ट\n'
    printf '  3) Process snapshot         चल रहे processes\n'
    printf '  4) Local network overview   नेटवर्क जानकारी\n'
    printf '  5) ADB connection check     ADB कनेक्शन\n'
    printf '  6) Android device details   Android जानकारी\n'
    printf '  7) Collect Android logs     Logs (confirmation required)\n'
    printf '  8) Tool installation hints  Tools install help\n'
    printf '  9) Browse documentation    गाइड की सूची\n'
    printf ' 10) Run safe reports         सुरक्षित रिपोर्ट एक-एक करके\n'
    printf '  0) Exit                     बाहर निकलें\n'
    line
    read -r -p "अपना विकल्प चुनें [0-10]: " choice || choice="0"
    case "$choice" in
      1) show_system_info; pause ;;
      2) show_storage; pause ;;
      3) show_processes; pause ;;
      4) show_network; pause ;;
      5) show_adb_devices; pause ;;
      6) show_android_info; pause ;;
      7) collect_logs; pause ;;
      8) show_tool_hints; pause ;;
      9) show_guides; pause ;;
      10) run_all_reports; pause ;;
      0) printf '\n%sToolkit बंद किया गया. धन्यवाद!%s\n' "$C_GREEN" "$C_RESET"; break ;;
      *) say_err "गलत विकल्प. 0 से 10 में चुनें."; sleep 1 ;;
    esac
  done
}

main_menu
