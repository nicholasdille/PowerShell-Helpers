function Set-PSSession {
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
        throw ('[{0}] Credential file {0} not found. Aborting.' -f $MyInvocation.MyCommand, $Path)
    }
    $Credential = Import-Clixml -Path $Path
    if (-not $Credential) {
        throw ('[{0}] Failed to import credentials. Aborting' -f $MyInvocation.MyCommand)
    }

    $Session = New-PSSession -ComputerName $ComputerName -Credential $Credential
    if (-not $Session) {
        throw ('[{0}] Failed to create remote session. Aborting.' -f $MyInvocation.MyCommand)
    }
        
    Get-Command -ParameterType PSSession -ParameterName Session | Select-Object -ExpandProperty Name | ForEach-Object {
        $PSDefaultParameterValues."$_:Session" = $Session
    }
}