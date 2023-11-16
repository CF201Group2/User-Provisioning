# Script Name:              Account-creator-automated.ps1
# Author:                   juan maldonado
# Date of latest revision:  11/15/2023
# Purpose:                  Endpoint configuration

# This sets up variables
$UserName = Read-Host "Enter new username"
$Password = Read-Host -Prompt "Enter the password for $UserName" -AsSecureString
$FullName = Read-Host "Enter the full name for $UserName"
$Description = Read-Host "Enter a description for $UserName"
$ComputerName = Read-Host "Enter a ComputerName"


# This sets up user account
New-LocalUser -Name $UserName -Password $Password -FullName $FullName -Description $Description
Add-LocalGroupMember -Group "Administrators" -Member $UserName

# This configures system settings
# Example: Change time zone
$TimeZone = Read-Host "Enter the time zone (e.g., Pacific Standard Time)"
Set-TimeZone -Id $TimeZone

 # This Enables File and Printer Sharing 
Enable-NetFirewallRule -Name "FPS-SMB-In-TCP"

# This allow ICMP traffic 
Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In"


# This installs google chrome
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\ChromeSetup.exe"

# This installs Thunderbird email
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\Thunderbird Setup 115.4.2.exe"

# This installs Slack
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\SlackSetup.exe"

# This installs VLC
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\vlc-3.0.20-win64.exe"

# This installs Malwarebytes
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\MBSetup-5.5.exe"


# This configures security settings
# Enable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $false

 # This Enables File and Printer Sharing 
Enable-NetFirewallRule -Name "FPS-SMB-In-TCP"

# This allow ICMP traffic 
Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In"

# This disables SMBv1
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

# This enables remote desktop protocol
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

# This allows RDP through the Windows Firewall
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# This allows changes to apply
Restart-Service -Name TermService -Force


# This displays a message to the user that the user provisioning is completed
Write-Host "Windows 10 configuration complete."
Read-Host "Press Enter to continue and to reboor the computer..."

# This will Reboot the computer
Restart-Computer -Force
