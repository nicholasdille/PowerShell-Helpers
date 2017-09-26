function New-SimpleCimSession {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", 
        "", 
        Justification = "Object is only created in memory"
    )]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSAvoidUsingPlainTextForPassword", 
        "CredentialName", 
        Justification = "CredentialName only refers to an entry in CredentialStore"
    )]
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