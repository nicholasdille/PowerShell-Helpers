function Clear-CimSession {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
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
        if ($Force -or $PSCmdlet.ShouldProcess("Remove CimSession parameter from cmdlets?")) {
            Get-Command -ParameterName CimSession | Select-Object -ExpandProperty Name | ForEach-Object {
                $PSDefaultParameterValues."$_:CimSession" = $null
            }
        }
    }
}