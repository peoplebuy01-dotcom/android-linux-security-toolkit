# Linux Command Handbook | Linux कमांड गाइड

Examples assume Bash. Paths and package managers vary by distribution.

## Files and directories

| Command | Example | Purpose | Risk |
|---|---|---|---|
| `pwd` | `pwd` | Current directory | Low |
| `ls` | `ls -lah` | List files | Low |
| `cd` | `cd ~/Downloads` | Change directory | Low |
| `find` | `find . -type f -name '*.log'` | Find files below current folder | Low |
| `locate` | `locate config.yml` | Search indexed paths | Low; may reveal path names |
| `tree` | `tree -L 2` | Directory tree | Low |
| `stat` | `stat file.txt` | File metadata | Low |
| `file` | `file app.apk` | Identify file type | Low |
| `du` | `du -sh ~/Downloads` | Directory size | Low |
| `df` | `df -h` | Filesystem free space | Low |

## System administration

| Command | Example | Purpose | Risk |
|---|---|---|---|
| `uname` | `uname -a` | Kernel/system info | Low |
| `hostnamectl` | `hostnamectl` | Host details | Low |
| `uptime` | `uptime` | Uptime/load | Low |
| `free` | `free -h` | Memory | Low |
| `top` / `htop` | `top` | Process monitor | Low |
| `ps` | `ps aux` | Process snapshot | Low |
| `systemctl` | `systemctl --no-pager status` | Service manager status | Low |
| `journalctl` | `journalctl -n 50 --no-pager` | Recent system logs | Low; logs may be sensitive |

## Networking

| Command | Example | Purpose | Risk |
|---|---|---|---|
| `ip` | `ip address` | Interface addresses | Low |
| `ss` | `ss -tuln` | Listening sockets | Low |
| `ping` | `ping -c 4 1.1.1.1` | Basic reachability | Low |
| `curl` | `curl -I https://example.com` | HTTP headers | Low |
| `wget` | `wget -O page.html https://example.com` | Download a known resource | Medium; writes file |
| `dig` | `dig example.com` | DNS lookup | Low |
| `nslookup` | `nslookup example.com` | DNS lookup | Low |
| `traceroute` | `traceroute example.com` | Network path diagnostics | Low; may be filtered |

## Permissions and users

`whoami`, `id`, and `groups` inspect identity. `chmod` changes mode bits; `chown` changes ownership; `sudo` runs privileged commands; `passwd` changes a password.

```bash
whoami
id
groups
chmod u+x my-script.sh
```

Risk: changing permissions/ownership can expose files or break services. Avoid broad recursive permission changes such as `chmod -R 777`.

## Storage and processes

`lsblk`, `blkid`, `df -h`, and `du -sh PATH` inspect storage. `mount` and `umount` change mount state. `lsof` lists open files. `kill PID` requests process termination; `pkill NAME` matches process names.

Risk: unmounting active filesystems or terminating critical processes can interrupt work or cause data loss. Verify target and backups first.

## Package management

- Debian/Ubuntu: `apt`, `dpkg`
- Termux: `pkg`
- Arch: `pacman`
- Fedora: `dnf`

Examples: `sudo apt update`, `apt list --installed`, `pkg list-installed`. Installation/removal modifies the system; inspect package origin and proposed changes.

## Text processing and productivity

```bash
grep -n 'ERROR' app.log
awk '{print $1}' access.log
cut -d: -f1 /etc/passwd
sort names.txt | uniq
sed -n '1,20p' notes.txt
printf 'hello\n' | tee output.txt
tar -tf archive.tar
unzip -l archive.zip
history | tail
env | sort
```

`xargs` executes commands from input; review the generated arguments before using it with delete or modification operations. `sed -i` edits files in place; make a backup first. `rm`, `dd`, filesystem formatting, and recursive ownership changes are intentionally not taught as casual examples.
