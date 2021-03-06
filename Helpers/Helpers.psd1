@{
    RootModule = 'Helpers.psm1'
    ModuleVersion = '0.4.0'
    GUID = '85f1dce3-d325-4622-adf3-40888ddb6813'
    Author = 'Nicholas Dille'
    #CompanyName = ''
    Copyright = '(c) 2017 Nicholas Dille. All rights reserved.'
    Description = 'Helpers for my other modules'
    # PowerShellVersion = ''
    # RequiredModules = @()
    FunctionsToExport = @(
        # DefaultParameterValue
        'Backup-DefaultParameterValue'
        'Get-DefaultParameterValue'
        'Remove-DefaultParameterValue'
        'Restore-DefaultParameterValues'
        'Set-DefaultParameterValue'

        # CIM
        'Clear-CimSession'
        'New-SimpleCimSession'
        'Set-CimSession'

        # Credential
        'Clear-Credential'
        'Get-CredentialFromStore'
        'New-CredentialInStore'
        'New-Password'
        'Set-Credential'
        'Test-Credential'
        'Get-BasicAuthentication'

        # Encryption
        'ConvertFrom-EncryptedString'
        'ConvertFrom-UnattendedXmlPassword'
        'Get-PlaintextFromSecureString'

        # PSSession
        'Clear-PSSession'
        'Enter-PsRemoteSession'
        'New-PsRemoteSession'
        'Set-PSSession'

        # Conversion
        'ConvertFrom-Base64'
        'ConvertFrom-ByteArray'
        'ConvertFrom-Bytes'
        'ConvertTo-Base64'
        'ConvertTo-ByteArray'
        'ConvertTo-Bytes'

        # XML
        'Export-XmlNode'

        # Docker
        'Find-DockerImageTag'

        # Date/time
        'Get-Epoch'

        # Encoding
        'Set-UnixLineEnding'
    )
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            # Tags = @()
            # LicenseUri = ''
            # ProjectUri = ''
            # ReleaseNotes = ''
        }
    }
}

