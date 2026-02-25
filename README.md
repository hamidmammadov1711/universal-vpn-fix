# Universal VPN Fix

**Universal VPN Fix** is a one-time, system-level networking correction tool designed to resolve
VPN connection failures caused by ISP interference and common OS misconfigurations.

This project does **not provide a VPN**.  
It prepares your operating system so VPNs can work reliably.

---

## 🚩 The Problem

In many regions, VPN connections fail even when:

- the VPN provider is reliable
- credentials are correct
- the application is properly installed

Root causes are usually **outside the VPN itself**:

- ISP-level DNS filtering  
- UDP throttling or blocking  
- IPv6 routing conflicts  
- WebRTC UDP leakage  
- Misconfigured firewall or TCP stack  

Switching VPN providers rarely solves these issues.

---

## ✅ The Solution

Universal VPN Fix applies **persistent, system-level network adjustments**
that significantly improve VPN connection reliability.

✔ One-time execution  
✔ Survives system reboot  
✔ No background services  
✔ No third-party dependencies  
✔ Fully open-source  
✔ Reversible (rollback included)

---

## ⚙️ What This Tool Does

- Disables IPv6 to prevent routing conflicts
- Applies trusted public DNS resolvers
- Resets TCP/IP and Winsock stack
- Applies safe TCP optimizations
- Allows VPN-friendly firewall rules
- Mitigates WebRTC UDP interference (Chromium-based browsers)

These changes are **OS-level**, not application-level.

---

## 🖥 Supported Operating Systems

### Windows

- Windows 10
- Windows 11

### Linux

- Ubuntu
- Debian
- Kali Linux

(systemd-based distributions)

---

## 🚀 How to Use (One-Time Setup)

### 💻 Windows

1. Download this repository
2. Right-click **PowerShell** → *Run as Administrator*
3. Execute:

```powershell
.\fix_webrtc_vpn.ps1

```

### 💻 Linux

```powershell
sudo chmod +x fix_webrtc_vpn.sh
sudo ./fix_webrtc_vpn.sh
```

Reboot once after execution.
