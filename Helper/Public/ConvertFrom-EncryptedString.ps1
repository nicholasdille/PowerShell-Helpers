function ConvertFrom-EncryptedString {
    <#
    .SYNOPSIS
    Decrypts a string to a secure string to use it for credentials on the current system

    .DESCRIPTION
    Many cmdlets for handling credentials rely on a SecureString. This function decrypts the sensitive data and converts it to a SecureString

    .PARAMETER EncryptedString
    Encrypted content

    .PARAMETER Key
    Custom encryption key

    .EXAMPLE
    ConvertFrom-EncryptedString -EncryptedString $SecureString -Key 'key012345678'
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $EncryptedString
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Key
    )

    $ByteData = [System.Text.Encoding]::ASCII.GetBytes($Key)
    ConvertTo-SecureString -String $EncryptedString -Key $ByteData
}