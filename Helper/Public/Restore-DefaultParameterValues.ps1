function Restore-DefaultParameterValues {
    [CmdletBinding()]
    param()

    PROCESS {
        $PSDefaultParameterValues = $Script:BackupOf_PSDefaultParameterValues
    }
}