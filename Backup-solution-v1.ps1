# This displays your username
$UserName = $env:USERNAME
Write-Host "Current username: $Username"

# This sets up variables
$BackupPath = "C:\Backups\$UserName"

# This creates a backup folder if it doesn't exist
if (-not(Test-Path $BackupPath -PathType Container)) {
    New-Item -ItemType Directory -Path $BackupPath -Force
}

# This uses robocopy to backup files
$SourcePath = "C:\users\$UserName\Documents"
robocopy $SourcePath $BackupPath /E /COPY:DAT /R:0 /W:0 

# This creates a system restore point
$RestorePointDescription = "Backup for $UserName"

# This invokes the Checkpoint-Computer cmdlet using PowerShell
try {
     Checkpoint-Computer -Description $RestorePointDescription -RestorePointType MODIFY_SETTINGS
     Write-Host "System restore point created successfully."
     } catch {
         Write-Host "Failed to create system restore point: $_"
     }
Write-Host "Backup and checkpoint process completed."
