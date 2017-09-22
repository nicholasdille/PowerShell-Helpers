function Get-DefaultParameterValue {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [Alias('Name')]
        [ValidateNotNullOrEmpty()]
        [string]
        $CmdletName
        ,
        [Parameter(Mandatory)]
        [Alias('Parameter')]
        [ValidateNotNullOrEmpty()]
        [string]
        $ParameterName
    )

    PROCESS {
        $PSDefaultParameterValues."$($CmdletName):$ParameterName"
    }
}