function Clear-CimSession {
    [CmdletBinding()]
    param()

    Get-Command -ParameterName CimSession | Select-Object -ExpandProperty Name | ForEach-Object {
        $PSDefaultParameterValues."$_:CimSession" = $null
    }
}