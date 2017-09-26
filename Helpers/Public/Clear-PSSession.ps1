function Clear-PSSession {
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
        if ($Force -or $PSCmdlet.ShouldProcess("Remove PSSession parameter from cmdlets?")) {
            Get-Command -ParameterType PSSession -ParameterName Session | Select-Object -ExpandProperty Name | ForEach-Object {
                $PSDefaultParameterValues."$_:Session" = $null
            }
        }
    }
}