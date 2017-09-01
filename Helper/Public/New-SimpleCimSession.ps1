function New-SimpleCimSession {
    <#
    .SYNOPSIS
    XXX

    .DESCRIPTION
    XXX

    .PARAMETER ComputerName
    Hyper-V host

    .PARAMETER CredentialName
    Name of credential

    .EXAMPLE
    New-SimpleCimSession -ComputerName hv-01

    .EXAMPLE
    New-SimpleCimSession -ComputerName hv-01 -CredentialName 'administrator@example.com'

    .NOTES
    This cmdlet relys on the credential cmdlets of this module
    #>
    [CmdletBinding()]
    [OutputType([Microsoft.Management.Infrastructure.CimSession])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ComputerName
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $CredentialName
    )

    $params = @{}
                           $params.Add('ComputerName',    $ComputerName)
    if ($CredentialName) { $params.Add('Credential',      (Get-CredentialFromStore -CredentialName $CredentialName)) }

    $CimSession = New-CimSession @params
    if (-Not $CimSession) {
        throw ('[{0}] Failed to create PowerShell remote session to <{1}>. Aborting.' -f $MyInvocation.MyCommand, $ComputerName)
    }

    $CimSession
}