function ConvertTo-Base64 {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Data
        ,
        [Parameter()]
        [ValidateSet('Unicode', 'ASCII')]
        [string]
        $Encoding = 'Unicode'
    )

    Process {
        foreach ($Item in $Data) {
            $bytes = ConvertTo-ByteArray -Data $Item -Encoding $Encoding
            [System.Convert]::ToBase64String($bytes)
        }
    }
}