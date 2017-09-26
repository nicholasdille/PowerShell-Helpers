function ConvertTo-UnattendXmlPassword {
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [securestring]
        $Password
    )

    ConvertTo-Base64 -Data (Get-PlaintextFromSecureString -SecureString $Password)
}