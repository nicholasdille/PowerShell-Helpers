function Set-CimSession {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", 
        "", 
        Justification = "Only changes default parameters for CIM cmdlets"
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
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ComputerName
    )

    if ($PSCmdlet.ParameterSetName -ieq 'CredentialName') {
        $Path = Join-Path -Path $PSScriptRoot -ChildPath "$Name.clixml"
    }
    if (-not (Test-Path -Path $Path)) {
        throw ('Credential file {0} not found. Aborting.' -f $Path)
    }
    $Credential = Import-Clixml -Path $Path
    if (-not $Credential) {
        throw ('[{0}] Failed to import credentials. Aborting' -f $MyInvocation.MyCommand)
    }

    $CimSession = New-CimSession -ComputerName $ComputerName -Credential $Credential
    if (-not $CimSession) {
        throw ('[{0}] Failed to create CIM session. Aborting.' -f $MyInvocation.MyCommand)
    }

    Get-Command -ParameterName CimSession | Select-Object -ExpandProperty Name | ForEach-Object {
        $PSDefaultParameterValues."$_:CimSession" = $CimSession
    }
}