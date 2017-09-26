function Backup-DefaultParameterValues {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseSingularNouns", 
        "", 
        Justification = "The variable PSDefaultParameterValues is backed up"
    )]
    [CmdletBinding()]
    param()

    PROCESS {
        $Script:BackupOf_PSDefaultParameterValues = $PSDefaultParameterValues
    }
}