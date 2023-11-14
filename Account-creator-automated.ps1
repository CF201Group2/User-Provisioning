# This contains information of user
param (
    [string]$UserName = Read-Host "Enter username",
    [string]$UserEmail = Read-Host "Enter email"
)

# This creates a new user
function Create-NewUser {
    param (
        [string]$Name,
        [string]$Email
    )
    
    # This creates a new user account with cmdlets
    New-LocalUser -Name $Name -Description "Auto create user" -Password (ConvertTo-SecureString -AsPlainText "Password123" -Force) -Enabled $true

    # Set the user's email address
    Set-LocalUser -Name $Name -Description $Email
}

# Main
Create-NewUser -Name $UserName -Email $UserEmail
