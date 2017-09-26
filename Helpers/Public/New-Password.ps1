Function New-Password() {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseDeclaredVarsMoreThanAssignments", 
        "Alphabet", 
        Justification = "Parsing error in script analyzer"
    )]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", 
        "", 
        Justification = "Object is only created in memory"
    )]
    <#
    .SYNOPSIS
    Generates a new password

    .DESCRIPTION
    The password is based on an alphabet

    .PARAMETER Length
    Length of the password

    .PARAMETER Alphabet
    Alphabet used for generating the password

    .EXAMPLE
    New-Password -Length 12

    .EXAMPLE
    New-Password -Length 12 -Alphabet "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray()
    #>
    [CmdletBinding()]
    [OutputType([string])]
    Param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]
        $Length=10
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Alphabet
    )

    if (-Not $Alphabet) {
        $Alphabet = $null
        40..126 + 33 + 35..38 | ForEach-Object {
            $Alphabet += ,[char][byte]$_
        }
    }

    $TempPassword = ''
    For ($i = 1; $i -le $Length; $i++) {
        $TempPassword += ($Alphabet | Get-Random)
    }

    return $TempPassword
}