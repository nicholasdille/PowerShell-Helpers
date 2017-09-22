function Get-CredentialFromStore {
    [CmdletBinding()]
    [OutputType([pscredential])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $CredentialName
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $CredentialStore
    )

    $Path = Join-Path -Path $CredentialStore -ChildPath ($CredentialName + '.clixml')
    Import-Clixml -Path $Path
}