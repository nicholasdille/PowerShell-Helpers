function ConvertFrom-UnattendXmlPassword {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Password
    )

    return ConvertFrom-Base64 -Data $Password
}