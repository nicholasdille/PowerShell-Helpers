Import-Module -Name Helper -Force

Describe 'EncryptedString' {
    It 'Works for both piped' {
        $input = ConvertTo-SecureString -String 'test' -AsPlainText -Force
        $input | ConvertTo-EncryptedString -Key '0123456789abcedf' | ConvertFrom-EncryptedString -Key '0123456789abcedf' | Get-PlaintextFromSecureString | Should Be (Get-PlaintextFromSecureString -SecureString $input)
    }
    It 'Works for parameter and pipe (in that order)' {
        $input = ConvertTo-SecureString -String 'test' -AsPlainText -Force
        ConvertTo-EncryptedString -SecureString $input -Key '0123456789abcedf' | ConvertFrom-EncryptedString -Key '0123456789abcedf' | Get-PlaintextFromSecureString | Should Be (Get-PlaintextFromSecureString -SecureString $input)
    }
    It 'Works for pipe and parameter (in that order)' {
        $input = ConvertTo-SecureString -String 'test' -AsPlainText -Force
        $encrypted = $input | ConvertTo-EncryptedString -Key '0123456789abcedf'
        ConvertFrom-EncryptedString -EncryptedString $encrypted -Key '0123456789abcedf' | Get-PlaintextFromSecureString | Should Be (Get-PlaintextFromSecureString -SecureString $input)
    }
}