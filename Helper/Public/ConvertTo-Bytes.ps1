function ConvertTo-Bytes {
    [CmdletBinding()]
    [OutputType([byte[]])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Data
        ,
        [Parameter()]
        [ValidateSet('Unicode', 'ASCII')]
        [string]
        $Encoding = 'Unicode'
    )

    [System.Text.Encoding]::$Encoding.GetBytes($Data)
}