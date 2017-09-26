function Set-Credential {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", 
        "", 
        Justification = "Only changes default parameters for remoting cmdlets"
    )]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ParameterSetName='CredentialName')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
        ,
        [Parameter(Mandatory,ParameterSetName='CredentialFile')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
        ,
        [Parameter(Mandatory,ParameterSetName='CredentialObject')]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $Credential
    )

    if ($PSCmdlet.ParameterSetName -ieq 'CredentialName') {
        $Path = Join-Path -Path $PSScriptRoot -ChildPath "$Name.clixml"
    }
    if (-not (Test-Path -Path $Path)) {
        throw ('Credential file {0} not found. Aborting.' -f $Path)
    }
    $Credential = Import-Clixml -Path $Path

    $PSDefaultParameterValues.'Invoke-Command:Credential'   = $Credential
    $PSDefaultParameterValues.'Enter-PSSession:Credential'  = $Credential
    $PSDefaultParameterValues.'New-PSSession:Credential'    = $Credential
    $PSDefaultParameterValues.'New-CimSession:Credential'   = $Credential
    $PSDefaultParameterValues.'Invoke-CimMethod:Credential' = $Credential
    $PSDefaultParameterValues.'New-CimInstance:Credential'  = $Credential
}