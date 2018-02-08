function Get-HttpAccessLogStats {
    [Cmdletbinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Path
    )

    process {
        foreach ($File in $Path) {
            Get-Content -Path "$File" | ConvertFrom-HttpAccessLog | Group-Object -Property SourceName | Select-Object -Property Count, Name | Sort-Object -Property Count -Descending
        }
    }
}