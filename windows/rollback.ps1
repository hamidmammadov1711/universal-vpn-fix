# Rollback VPN Fix - Windows

Enable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | ForEach-Object {
    Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ResetServerAddresses
}

reg delete "HKLM\SOFTWARE\Policies\Google\Chrome" /v WebRtcUdpPortRange /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v WebRtcUdpPortRange /f

netsh advfirewall firewall delete rule name="VPN TCP 443"
netsh advfirewall firewall delete rule name="VPN UDP 1194"

Write-Host "[✓] Rollback complete. Reboot recommended."