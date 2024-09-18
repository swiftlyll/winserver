<#
.SYNOPSIS
    Configures and intalls active directory for lab migration
.NOTES
    Author: Kennet Morales
    Created: April 25, 2024
    Last Modified: April 25, 2024
#>

# Variables
$hostname = Read-Host "Enter server name: "

$intInfo = Get-NetConnectionProfile

$staticConfig = @{
    InterfaceIndex = $intInfo.InterfaceIndex
    IPAddress = ""
    PrefixLenght = ""
    DefaultGateway = ""
    ErrorAction = "Stop"
    Verbose = $true
}

$dnsServers = @{
    ServerAddresses = @(
        "A.B.C.D"
        "A.B.C.D"
        "A.B.C.D"
    )
}

$ADDS = @{
    Name = "AD-Domain-Services"
    # IncludeManagementTools = $true
}

$ADForest = @{

}

# pre-req server config
New-NetIPAddress @staticConfig
Rename-Computer -NewName $hostname -Confirm:$false -Force -ErrorAction Continue
Set-DnsClientServerAddress -ServerAddresses @dnsServers

# Install services plus initial forest creation
Install-WindowsFeature @ADDS
Install-ADDSForest