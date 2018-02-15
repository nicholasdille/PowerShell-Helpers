function ConvertTo-UnixEpoch {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [datetime]
        $Timestamp
    )

    [int64]($Timestamp - (Get-Date "1/1/1970")).TotalMilliseconds * 1000000
}