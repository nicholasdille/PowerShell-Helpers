function ConvertFrom-ByteArray {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [byte[]]
        $Data
        ,
        [Parameter()]
        [ValidateSet('Unicode', 'ASCII')]
        [string]
        $Encoding = 'Unicode'
    )

    [System.Text.Encoding]::$Encoding.GetString($Data)
}