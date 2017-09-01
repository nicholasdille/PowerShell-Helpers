function Test-Credential {
    <#
    .SYNOPSIS
    Takes a PSCredential object and validates it against the domain (or local machine, or ADAM instance).

    .PARAMETER Credential
    A PSCredential object with the username/password you wish to test. Typically this is generated using the Get-Credential cmdlet. Accepts pipeline input.

    .PARAMETER Context
    An optional parameter specifying what type of Credential this is. Possible values are 'Domain','Machine',and 'ApplicationDirectory.' The default is 'Domain.'

    .OUTPUTS
    A boolean, indicating whether the Credentials were successfully validated.
    #>

    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [pscredential]
        $Credential
        ,
        [Parameter()]
        [ValidateSet('Domain', 'Machine', 'ApplicationDirectory')]
        [string]
        $Context = 'Domain'
    )

    Begin {
        Add-Type -AssemblyName System.DirectoryServices.AccountManagement
        $DS = New-Object -TypeName System.DirectoryServices.AccountManagement.PrincipalContext -ArgmentList [System.DirectoryServices.AccountManagement.ContextType]::$Context
    }

    Process {
        $DS.ValidateCredentials($Credential.UserName, $Credential.GetNetworkCredential().Password)
    }
}