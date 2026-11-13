# Networking & TLS Fundamentals Lab

## Scope

This chapter teaches local diagnostics and certificate concepts. Use your own device, a local test service, or a training PCAP. No third-party scanning or interception.

## Local interface and listening sockets

```bash
ip address
ip route
ss -tuln
```

- `ip address`: local interface addresses.
- `ip route`: local routing table.
- `ss -tuln`: listening TCP/UDP sockets without resolving service names.

Expected output depends on the device and active services. Do not publish internal addresses or socket inventories if they reveal sensitive infrastructure.

## DNS and HTTP basics

```bash
dig example.com
nslookup example.com
curl -I https://example.com
```

DNS translates names to records; HTTP headers describe a response. A successful lookup does not prove a website is trustworthy.

## TLS certificate inspection

```bash
openssl version
openssl s_client -connect example.com:443 -servername example.com
```

Look for certificate subject/issuer, validity dates, negotiated protocol, and verification result. Certificate validation depends on hostname, trust chain, time, and local trust store. Never share private keys.

## Packet analysis exercise

1. Download a sample PCAP from a trusted educational source.
2. Open it in Wireshark.
3. Apply the display filter `dns`.
4. Inspect query/response names and record types.
5. Note which metadata is visible even when application payloads use TLS.
6. Write a short report and redact personal information.

## Common errors

- DNS timeout: check network connectivity and resolver configuration.
- TLS verification failure: check device date/time, hostname, certificate chain, and trust store.
- Permission denied for packet capture: use an educational PCAP file instead of elevating privileges.
- Empty socket list: the device may not currently have listening services.

Never install a lab CA certificate on a personal daily-use phone. Use a dedicated lab device/profile and remove temporary certificates after the exercise.
