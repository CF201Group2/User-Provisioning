# Script Name:              Account-creator-automated
# Author:                   juan maldonado
# Date of latest revision:  11/14/2023
# Purpose:                  Endpoint configuration


# This sets up variables
$UserName = Read-Host "Enter new username"
$Password = Read-Host -Prompt "Enter the password for $UserName" -AsSecureString
$FullName = Read-Host "Enter the full name for $UserName"
$Description = Read-Host "Enter a description for $UserName"
$ComputerName = Read-Host "Enter a ComputerName"
$ISOPath = "C:\Users\juan9\OneDrive\Desktop" # this is for the source computer, find the path to the windows 10 iso.

# This installs Windows 10
# Note: Replace \\Server\Share with the actual network path to your Windows 10 installation files
$SetupPath = "\\Server\Share\setup.exe"
Invoke-Command -ComputerName $ComputerName -ScriptBlock {
    Start-Process -Wait -FilePath $using:SetupPath -ArgumentList "/quiet /noreboot"
}

# This set up user account
New-LocalUser -Name $UserName -Password $Password -FullName $FullName -Description $Description
Add-LocalGroupMember -Group "Administrators" -Member $UserName

# This configures system settings
# Example: Change time zone
$TimeZone = Read-Host "Enter the time zone (e.g., Pacific Standard Time)"
Set-TimeZone -Id $TimeZone

# Thos Runs Windows Update
Install-WindowsUpdate -AcceptAll -AutoReboot

# This installs google chrome
Start-Process -Wait -FilePath "C:\Users\juan9\OneDrive\Desktop\Programs-to-install"

# This installs Thunderbird email
Start-Process -Wait -FilePath "C:\Users\juan9\OneDrive\Desktop\Programs-to-install"

# This installs Slack
Start-Process -Wait -FilePath "C:\Users\juan9\OneDrive\Desktop\Programs-to-install"

# This installs VLC
Start-Process -Wait -FilePath "C:\Users\juan9\OneDrive\Desktop\Programs-to-install"

# This installs Malwarebytes
Start-Process -Wait -FilePath "C:\Users\juan9\OneDrive\Desktop\Programs-to-install"

# This installs AMD Software: Adrenalin Edition
Start-Process -Wait -FilePath "C:\Users\juan9\OneDrive\Desktop\Programs-to-install"

# This configures security settings
# Enable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $false

# This sets up file and folder permissions
# Example: Grant permissions to a folder
$Folder = "C:\Path\to\Folder"
$Acl = Get-Acl $Folder
$Permission = "BUILTIN\Users", "ReadAndExecute", "Allow"
$Rule = New-Object System.Security.AccessControl.FileSystemAccessRule $Permission
$Acl.SetAccessRule($Rule)
Set-Acl -Path $Folder -AclObject $Acl

# This creates a system backup and restore points
# Example: Create a system restore point
Checkpoint-Computer -Description "Before Software Installation" -RestorePointType "MODIFY_SETTINGS"

# This will Reboot the computer
Restart-Computer -Force
