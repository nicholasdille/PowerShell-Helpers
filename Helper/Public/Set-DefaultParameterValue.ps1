function Set-DefaultParameterValue {
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
        ,
        [Parameter(Mandatory)]
        [Alias('Value')]
        $ParameterValue
    )

    PROCESS {
        $PSDefaultParameterValues."$($CmdletName):$ParameterName" = $ParameterValue
    }
}