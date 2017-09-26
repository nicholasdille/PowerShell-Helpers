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

function ConvertFrom-Bytes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseSingularNouns", 
        "", 
        Justification = "Deprecated. Will be removed soon."
    )]
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

    ConvertFrom-ByteArray @PSBoundParameters
}