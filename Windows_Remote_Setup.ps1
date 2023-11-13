# Script Name:                  Automated Endpoint Configuration
# Author:                       John Kelly
# Date of latest revision:      11/13/2023
# Purpose:                      Create a Powershell script that automatically establishes settings to enable RDP and to remove bloatware

# ---------------------Configure Sharing and allow Ping------------------------------
# Enable File and Printer Sharing
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True

# Allow ICMP traffic
netsh advfirewall firewall add rule name="Allow incoming ping requests IPv4" dir=in action=allow protocol=icmpv4

# ---------------------Configure RDP ------------------------------

# Enable Remote management
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

# Enable Hyper-V
 Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# Enable NLA
Set-ItemProperty ‘HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\‘ -Name “UserAuthentication” -Value 1

# --------------------------Remove Bloatware-------------------------
# Remove bloatware
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://git.io/debloat'))
