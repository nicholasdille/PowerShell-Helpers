function Enter-PsRemoteSession {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSAvoidUsingPlainTextForPassword", 
        "", 
        Justification = "CredentialName only specifies an entry in the credential database"
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

    .PARAMETER UseCredSsp
    Whether the connection uses CredSSP

    .PARAMETER Session
    XXX

    .EXAMPLE
    Enter-PsRemoteSession -ComputerName hv-01

    .EXAMPLE
    Enter-PsRemoteSession -ComputerName hv-01 -CredentialName 'administrator@example.com'

    .EXAMPLE
    Enter-PsRemoteSession -ComputerName hv-01 -CredentialName 'administrator@example.com' -UseCredSsp

    .EXAMPLE
    Enter-PsRemoteSession -Session $session

    .NOTES
    This cmdlet relys on the credential cmdlets of this module
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ParameterSetName='Computer')]
        [ValidateNotNullOrEmpty()]
        [string]
        $ComputerName
        ,
        [Parameter(ParameterSetName='Computer')]
        [ValidateNotNullOrEmpty()]
        [string]
        $CredentialName
        ,
        [Parameter(ParameterSetName='Computer')]
        [switch]
        $UseCredSsp
        ,
        [Parameter(Mandatory,ParameterSetName='PsSession')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.Runspaces.PSSession]
        $Session
    )

    if (-Not $Session) {
        $Session = New-PsRemoteSession @PSBoundParameters
    }
    Enter-PSSession -Session $Session
}