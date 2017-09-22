function Get-PlaintextFromSecureString {
    <#
    .SYNOPSIS
    Extract the plaintext content from a SecureString

    .PARAMETER SecureString
    Sensitive content

    .EXAMPLE
    Get-PlaintextFromSecureString -SecureString $Password
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [Security.SecureString]
        $SecureString
    )

    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
    [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
}