function New-PsRemoteSession {
    <#
    .SYNOPSIS
    XXX

    .DESCRIPTION
    XXX

    .PARAMETER ComputerName
    Hyper-V host

    .PARAMETER CredentialName
    Name of credential

    .PARAMETER UseCredSsp
    Whether the connection uses CredSSP

    .EXAMPLE
    New-PsRemoteSession -ComputerName hv-01

    .EXAMPLE
    New-PsRemoteSession -ComputerName hv-01 -CredentialName 'administrator@example.com'

    .EXAMPLE
    New-PsRemoteSession -ComputerName hv-01 -CredentialName 'administrator@example.com' -UseCredSsp

    .NOTES
    This cmdlet relys on the credential cmdlets of this module
    #>
    [CmdletBinding()]
    [OutputType([System.Management.Automation.Runspaces.PSSession])]
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
        ,
        [Parameter()]
        [switch]
        $UseCredSsp
    )

    if ($UseCredSsp -And -Not $CredentialName) {
        throw ('[{0}] When using CredSSP credentials must be specified. Aborting.' -f $MyInvocation.MyCommand)
    }

    $params = @{}
                           $params.Add('ComputerName',    $ComputerName)
    if ($CredentialName) { $params.Add('Credential',      (Get-CredentialFromStore -CredentialName $CredentialName)) }
    if ($UseCredSsp)     { $params.Add('Authentication', 'Credssp') }

    $Session = New-PSSession @params
    if (-Not $Session) {
        throw ('[{0}] Failed to create PowerShell remote session to <{1}>. Aborting.' -f $MyInvocation.MyCommand, $ComputerName)
    }

    $Session
}