function Set-UnixLineEnding {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Path
    )

    PROCESS {
        foreach ($FilePath in $Path) {
            Write-Verbose ('Processing {0}' -f $FilePath)

            $OriginalContent = Get-Content -Raw -Path $FilePath
            $OriginalBytes = [System.Text.Encoding]::ASCII.GetBytes($OriginalContent)
            #$OriginalBytes -join ','
    
            $NormalizedBytes = $OriginalBytes | Where-Object { $_ -ne 13 }
            #$NormalizedBytes -join ','

            $NormalizedContent = [System.Text.Encoding]::ASCII.GetString($NormalizedBytes)
            #$NormalizedContent

            Set-Content -Value $NormalizedContent -Path $FilePath
        }
    }
}