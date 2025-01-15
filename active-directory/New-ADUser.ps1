<#
.DESCRIPTION
    Very WIP. Unsure when I created this.
.NOTES
    Date: ???
#>

$givenName = "fIrst"
$surname = "lASt"

$user = @{
    First = $givenName.ToLower().ToTitleCase($first)
    Last = $surname.Normalize()
    # $samAccountName = $givenName.ToLower()[0]+$surname.ToLower()
}

function Add-ADUser {
    param (
        # Parameter help description
        [Parameter(Position=0,Mandatory)]
        [string]
        $First,
        # Parameter help description
        [Parameter(Mandatory)]
        [string]
        $Last
    )
    
    $samAccountName = $first.ToLower()[0] + $last.ToLower()

    Write-Output "My name is $first $last. Sam is $samAccountName."

}

Add-ADUser @user