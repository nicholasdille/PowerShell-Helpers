function Clear-Credential {
    [CmdletBinding()]
    param()

    $PSDefaultParameterValues.'Invoke-Command:Credential'   = $null
    $PSDefaultParameterValues.'Enter-PSSession:Credential'  = $null
    $PSDefaultParameterValues.'New-PSSession:Credential'    = $null
    $PSDefaultParameterValues.'New-CimSession:Credential'   = $null
    $PSDefaultParameterValues.'Invoke-CimMethod:Credential' = $null
    $PSDefaultParameterValues.'New-CimInstance:Credential'  = $null
}