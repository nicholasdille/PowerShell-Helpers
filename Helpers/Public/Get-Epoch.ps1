function Get-Epoch {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [datetime]
        $Timestamp = ([datetime]::UtcNow)
    )

    $unixEpochStart = New-Object -TypeName DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, ([DateTimeKind]::Utc)
    
    [long]($Timestamp - $unixEpochStart).TotalMilliseconds
}