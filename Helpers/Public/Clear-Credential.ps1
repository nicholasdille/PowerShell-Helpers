function Clear-Credential {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    param()
    
    begin {
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
    }

    process {
        if ($Force -or $PSCmdlet.ShouldProcess("Remove Credential parameter from cmdlets?")) {
            $PSDefaultParameterValues.'Invoke-Command:Credential'   = $null
            $PSDefaultParameterValues.'Enter-PSSession:Credential'  = $null
            $PSDefaultParameterValues.'New-PSSession:Credential'    = $null
            $PSDefaultParameterValues.'New-CimSession:Credential'   = $null
            $PSDefaultParameterValues.'Invoke-CimMethod:Credential' = $null
            $PSDefaultParameterValues.'New-CimInstance:Credential'  = $null
        }
    }
}