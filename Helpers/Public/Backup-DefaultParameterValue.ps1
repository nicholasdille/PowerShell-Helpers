function Backup-DefaultParameterValues {
    [CmdletBinding()]
    param()

    PROCESS {
        $Script:BackupOf_PSDefaultParameterValues = $PSDefaultParameterValues
    }
}