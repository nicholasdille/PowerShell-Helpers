function Export-XmlNode {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Xml.XmlElement]
        $Xml
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    $NewXml = New-Object -TypeName System.Xml.XmlDocument
    $null = $NewXml.AppendChild($NewXml.ImportNode($Xml, $true))
    $NewXml.Save($Path)
}