#!/bin/bash
set -e

echo "[+] Universal VPN Fix (Linux) started"

# 1. Disable IPv6 (persistent)
cat <<EOF > /etc/sysctl.d/99-disable-ipv6.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF

sysctl --system

# 2. DNS fix (systemd-resolved)
mkdir -p /etc/systemd/resolved.conf.d
cat <<EOF > /etc/systemd/resolved.conf.d/dns.conf
[Resolve]
DNS=1.1.1.1 1.0.0.1 8.8.8.8
FallbackDNS=9.9.9.9
EOF

systemctl restart systemd-resolved

# 3. TCP hardening
cat <<EOF >> /etc/sysctl.conf
net.ipv4.tcp_mtu_probing=1
net.ipv4.tcp_syn_retries=5
net.ipv4.ip_forward=1
EOF

sysctl -p

# 4. Firewall (iptables)
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT
iptables-save > /etc/iptables.rules

echo "[✓] Done. Reboot required."