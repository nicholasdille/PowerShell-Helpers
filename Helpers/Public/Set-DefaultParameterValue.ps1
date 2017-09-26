function Set-DefaultParameterValue {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseShouldProcessForStateChangingFunctions", 
        "", 
        Justification = "Only default parameters are changed"
    )]
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