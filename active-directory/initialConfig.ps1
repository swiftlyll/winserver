<#
.SYNOPSIS
    Configures and intalls active directory for lab migration

.NOTES
    Author: Kennet Morales
    Created: April 25, 2024
    Last Modified: April 25, 2024
#>

# Variables
$pcName = Read-Host "Enter server name: "

$netProfile = Get-NetConnectionProfile

$netConfig = @{
    InterfaceIndex = $netProfile.InterfaceIndex
    IPAddress = ""
    PrefixLenght = ""
    DefaultGateway = ""
    ErrorAction = "Stop"
    Verbose = $true
}

$AD = @{
    Name = "AD-Domain-Services"
    IncludeManagementTools = $true
}

$ADForest = @{

}

# Prep work
New-NetIPAddress @netConfig
Rename-Computer -NewName $pcName -Confirm:$false -Force -ErrorAction Continue

# Install services plus initial forest creation
Install-WindowsFeature @AD
Install-ADDSForest