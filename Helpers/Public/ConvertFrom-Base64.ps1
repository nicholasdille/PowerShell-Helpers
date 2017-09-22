function ConvertFrom-Base64 {
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
            $bytes = [System.Convert]::FromBase64String($Item)
            ConvertFrom-Bytes -Data $bytes -Encoding $Encoding
        }
    }
}