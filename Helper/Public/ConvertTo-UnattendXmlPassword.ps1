function ConvertTo-UnattendXmlPassword {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Password
    )

    return ConvertTo-Base64 -Data $Password
}