function ConvertTo-EncryptedString {
    <#
    .SYNOPSIS
    Encrypts the contents of a secure string to make it usable on another system

    .DESCRIPTION
    A SecureString cannot be used on a different system than the one it was created on. This function encrypts the password using a custom encryption key to make the contents portable

    .PARAMETER SecureString
    Sensitive content

    .PARAMETER Key
    Custom encryption key

    .EXAMPLE
    ConvertTo-EncryptedString -SecureString $SecureString -Key 'key012345678'
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [Security.SecureString]
        $SecureString
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Key
    )

    $ByteData = [System.Text.Encoding]::ASCII.GetBytes($Key)
    ConvertFrom-SecureString -SecureString $SecureString -Key $ByteData
}