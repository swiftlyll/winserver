<#
.SYNOPSIS
    Configures and intalls active directory for lab migration
.NOTES
    Author: Kennet Morales
    Created: April 25, 2024
#>
 
# Variables
$hostname = Read-Host "Enter server name"

$hostConfig = @{
    NewName = $hostname
    ErrorAction = "Stop"
    Confirm = $false
    Force = $true
    Verbose = $true
}

$intInfo = Get-NetConnectionProfile

$staticConfig = @{
    InterfaceIndex = $intInfo.InterfaceIndex
    IPAddress = "A.B.C.D"
    PrefixLenght = "24"
    DefaultGateway = "A.B.C.D"
    ErrorAction = "Stop"
    Confirm = $false
    Verbose = $true
}

$dnsServers = @{
    ServerAddresses = @(
        "A.B.C.D"
        "A.B.C.D"
        "8.8.8.8"
    )
    ErrorAction = "Continue"
    Confirm = $false
    Verbose = $true
}

$ADDS = @{
    Name = "AD-Domain-Services"
    # IncludeManagementTools = $true
    Confirm = $false
    Verbose = $true
    Force = $true
}

$ADDSForest = @{
    DomainName = "contoso"
}

# pre-req server config
try {
    Write-Output "[INFO] Setting static IP information"
    New-NetIPAddress @staticConfig
    Write-Output "[INFO] Setting DNS servers"
    Set-DnsClientServerAddress @dnsServers
    Write-Output "[INFO] Setting hostname"
    Rename-Computer @hostConfig
}
catch {
    Write-Error -Verbose "[ERROR] Initial host configuration failed"
}

# install services plus initial forest creation
Install-WindowsFeature @ADDS
Install-ADDSForest @ADDSForest