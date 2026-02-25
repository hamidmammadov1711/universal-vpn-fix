# Universal VPN Fix - Windows
# Persistent after reboot

Write-Host "[+] Universal VPN Fix (Windows) started"

# 1. Disable IPv6
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6 -ErrorAction SilentlyContinue

# 2. Set strong DNS
Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
    Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex `
        -ServerAddresses ("1.1.1.1", "1.0.0.1", "8.8.8.8", "8.8.4.4")
}

# 3. Flush + reset network stack
ipconfig /flushdns | Out-Null
netsh winsock reset | Out-Null
netsh int ip reset | Out-Null

# 4. Firewall rules (VPN-friendly)
netsh advfirewall firewall add rule name="VPN TCP 443" dir=out action=allow protocol=TCP remoteport=443
netsh advfirewall firewall add rule name="VPN UDP 1194" dir=out action=allow protocol=UDP remoteport=1194

# 5. Disable WebRTC UDP (Chrome / Edge)
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v WebRtcUdpPortRange /t REG_SZ /d "0-0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v WebRtcUdpPortRange /t REG_SZ /d "0-0" /f

Write-Host "[✓] Done. Reboot required."