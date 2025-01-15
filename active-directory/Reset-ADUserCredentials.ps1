<#
.DESCRIPTION
    Reset AD user credentials on some remote server. Either replace $env:ADServer with the server IP
    or define the environmental variable.
.NOTES
    Date: January 14, 2025
#>

Import-Module ActiveDirectory

try {
    $userSearch = Read-Host "Enter User"
    $userProperties = Get-ADUser -Identity $userSearch -Server $env:ADServer -Properties * -ErrorAction Stop 
    $userSamAccountName = $userProperties.SamAccountName
    $userDisplayName = $userProperties.DisplayName
    $userPrincipalName = $userProperties.UserPrincipalName

    ""
    Write-Output "USER INFORMATION"
    Write-Output "================="
    Write-Output "Display Name: $userDisplayName"
    Write-Output "SAN: $userSamAccountName"
    Write-Output "UPN: $userPrincipalName"
    ""
}
catch {
    Write-Output "The specified user does not exist"
    Exit 1
}

try {
    $confirmation = Read-Host "Please confirm this is the correct user (Y/N)"
    if($confirmation -eq 'Y'){
        Write-Output "Starting credential reset for specified user"
        $tempPasswd = ConvertTo-SecureString -AsPlainText "Temp123!?" -Force # change depending on complexity requirements
        Set-ADAccountPassword -Identity $userSamAccountName -Server $env:ADServer -NewPassword $tempPasswd -Reset -ErrorAction Stop
        Write-Output "Successfully reset user credentials"
        Write-Output "Temporary Password: $(ConvertFrom-SecureString -SecureString $tempPasswd -AsPlainText)"
    }
    else{
        Write-Output "No changes were made"
    }
}
catch {
    Write-Output "Failed to perform credential reset"
    Exit 1
}