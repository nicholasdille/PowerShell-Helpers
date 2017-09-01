Import-Module -Name Helper -Force

Describe 'Unattended Password' {
    It 'Convert password to Base64 using parameter' {
        ConvertTo-UnattendXmlPassword -Password 'P@ssw0rd!' | Should Be (ConvertTo-Base64 -Data 'P@ssw0rd!')
    }
    It 'Convert password to Base64 using pipeline' {
        'P@ssw0rd!' | ConvertTo-UnattendXmlPassword | Should Be (ConvertTo-Base64 -Data 'P@ssw0rd!')
    }
    It 'Convert password from Base64 using parameter' {
        ConvertFrom-UnattendXmlPassword -Password (ConvertTo-Base64 -Data 'P@ssw0rd!') | Should Be 'P@ssw0rd!'
    }
    It 'Convert password from Base64 using pipeline' {
        ConvertTo-Base64 -Data 'P@ssw0rd!' | ConvertFrom-UnattendXmlPassword | Should Be 'P@ssw0rd!'
    }
}