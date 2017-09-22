function Clear-PSSession {
    [CmdletBinding()]
    param()

    Get-Command -ParameterType PSSession -ParameterName Session | Select-Object -ExpandProperty Name | ForEach-Object {
        $PSDefaultParameterValues."$_:Session" = $null
    }
}