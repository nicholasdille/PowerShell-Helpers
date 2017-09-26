function Restore-DefaultParameterValues {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseSingularNouns", 
        "", 
        Justification = "The variable PSDefaultParameterValues is restored"
    )]
    [CmdletBinding()]
    param()

    PROCESS {
        $PSDefaultParameterValues = $Script:BackupOf_PSDefaultParameterValues
    }
}