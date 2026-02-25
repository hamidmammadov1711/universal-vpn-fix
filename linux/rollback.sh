#!/bin/bash

rm -f /etc/sysctl.d/99-disable-ipv6.conf
sysctl --system

rm -f /etc/systemd/resolved.conf.d/dns.conf
systemctl restart systemd-resolved

sed -i '/tcp_mtu_probing/d' /etc/sysctl.conf
sed -i '/tcp_syn_retries/d' /etc/sysctl.conf
sed -i '/ip_forward/d' /etc/sysctl.conf
sysctl -p

iptables -D OUTPUT -p tcp --dport 443 -j ACCEPT || true
iptables -D OUTPUT -p udp --dport 1194 -j ACCEPT || true

echo "[✓] Rollback complete. Reboot recommended."
