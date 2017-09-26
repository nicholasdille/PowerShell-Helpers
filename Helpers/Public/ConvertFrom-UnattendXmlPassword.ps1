function ConvertFrom-UnattendXmlPassword {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Hash
    )

    ConvertFrom-Base64 -Data $Hash
}