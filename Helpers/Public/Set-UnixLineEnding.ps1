function Set-UnixLineEnding {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Path
    )
    
    begin {
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
    }
    
    process {
        foreach ($FilePath in $Path) {
            Write-Verbose ('Processing {0}' -f $FilePath)

            $OriginalContent = Get-Content -Raw -Path $FilePath
            $OriginalBytes = [System.Text.Encoding]::ASCII.GetBytes($OriginalContent)
            #$OriginalBytes -join ','
    
            $NormalizedBytes = $OriginalBytes | Where-Object { $_ -ne 13 }
            #$NormalizedBytes -join ','

            $NormalizedContent = [System.Text.Encoding]::ASCII.GetString($NormalizedBytes)
            #$NormalizedContent

            if ($Force -or $PSCmdlet.ShouldProcess("ShouldProcess?")) {
                Set-Content -Value $NormalizedContent -Path $FilePath
            }
        }
    }
}