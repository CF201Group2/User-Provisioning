# Script Name:              MSP-Test-file.ps1
# Author:                   juan maldonado
# Date of latest revision:  11/14/2023
# Purpose:                  Endpoint configuration

# This sets up variables
$UserName = Read-Host "Enter new username"
$Password = Read-Host -Prompt "Enter the password for $UserName" -AsSecureString
$FullName = Read-Host "Enter the full name for $UserName"
$Description = Read-Host "Enter a description for $UserName"
$ComputerName = Read-Host "Enter a ComputerName"
$ISOPath = "C:\Users\Admin01\Desktop\Windows-ISO\Windows-ISO\Windows10.iso" # this is for the source computer, find the path to the windows 10 iso.

# This installs Windows 10
# Note: Replace \\Server\Share with the actual network path to your Windows 10 installation files
# $SetupPath = "C:\Users\Admin01\Desktop\Windows-ISO"
# Invoke-Command -ComputerName $ComputerName -ScriptBlock {
   # Start-Process -Wait -FilePath $using:SetupPath -ArgumentList "/quiet /noreboot"
#}

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


# This Runs Windows Update
$updates = Get-WindowsUpdate -Online
if ($updates.Count -gt 0) {
    # this installs updates
    Install-WindowsUpdate -Updates $updates -AcceptAll -AutoReboot
}

# This installs google chrome
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\Programs-to-install\ChromeSetup.exe"

# This installs Thunderbird email
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\Programs-to-install\Thunderbird Setup 115.4.2.exe"

# This installs Slack
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\Programs-to-install\SlackSetup.exe"

# This installs VLC
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\Programs-to-install\vlc-3.0.20-win64.exe"

# This installs Malwarebytes
Start-Process -Wait -FilePath "C:\Users\Admin01\Desktop\Programs-to-install\Programs-to-install\MBSetup-5.5.exe"


# This configures security settings
# Enable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $false

 # This Enables File and Printer Sharing 
Enable-NetFirewallRule -Name "FPS-SMB-In-TCP"

# This allow ICMP traffic 
Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In"


# This creates a system backup and restore points
# Example: Create a system restore point
Checkpoint-Computer -Description "Before Software Installation" -RestorePointType "MODIFY_SETTINGS"

# This disables SMBv1
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

Write-Host "Windows 10 configuration complete."

# This will Reboot the computer
Restart-Computer -Force
