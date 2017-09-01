function New-CredentialInStore {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $CredentialName
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $Credential
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $CredentialStore
    )

    $Path = Join-Path -Path $CredentialStore -ChildPath ($CredentialName + '.clixml')
    $Credential | Export-Clixml -Path $Path
}