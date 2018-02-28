function Import-RemoteModule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ModuleName
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Prefix
        ,
        [Parameter(Mandatory,ParameterSetName='ComputerName')]
        [ValidateNotNullOrEmpty()]
        [string]
        $ComputerName
        ,
        [Parameter(ParameterSetName='ComputerName')]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $Credential
        ,
        [Parameter(ParameterSetName='Session')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.Runspaces.PSSession]
        $Session
    )

    Process {
        if ($PSCmdlet.ParameterSetName -ieq 'ComputerName') {
            Write-Verbose -Message ('[{0}] Creating session to {1}' -f $MyInvocation.MyCommand, $ComputerName)
            $SessionParameters = @{
                ComputerName = $ComputerName
            }
            if ($Credential) {
                Write-Verbose -Message ('[{0}] Using credentials' -f $MyInvocation.MyCommand)
                $SessionParameters.Add('Credential', $Credential)
            }
            $Session = New-PSSession @SessionParameters
        }

        Write-Verbose -Message ('[{0}] Loading module {1} in remote session' -f $MyInvocation.MyCommand, $ModuleName)
        Invoke-Command -Session $Session -ScriptBlock {
            Import-Module -Name $Using:ModuleName
        }

        Write-Verbose -Message ('[{0}] Importing module {1} from remote session with prefix {2}' -f $MyInvocation.MyCommand, $ModuleName, $Prefix)
        $RemoteModule = Import-PSSession -Session $Session -Module $ModuleName -Prefix $Prefix -AllowClobber -FormatTypeName *

        Write-Verbose -Message ('[{0}] Loading remote module {1} in local session' -f $MyInvocation.MyCommand, $ModuleName)
        Import-Module -Name $RemoteModule -Global

        Write-Verbose -Message ('[{0}] Done' -f $MyInvocation.MyCommand)
    }
}