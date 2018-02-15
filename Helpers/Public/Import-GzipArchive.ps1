function Import-GzipArchive {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    $InputStream  = New-Object -TypeName System.IO.FileStream -ArgumentList $Path, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
    $GzipStream   = New-Object -TypeName System.IO.Compression.GzipStream -ArgumentList $InputStream, ([IO.Compression.CompressionMode]::Decompress)

    $Content = ''

    $Buffer = New-Object -TypeName byte[] -ArgumentList 1024
    while ($true) {
        $BytesRead = $GzipStream.Read($Buffer, 0, 1024)
        if ($BytesRead -le 0) { break }
        $Content += [System.Text.Encoding]::ASCII.GetString($Buffer[0..($BytesRead - 1)])
        $Lines = $Content.Split("`n`r")
        $Lines[0..($Lines.Count - 2)]
        $Content = $Lines[$Lines.Count - 1]
    }

    $GzipStream.Close()
    $InputStream.Close()

    $Content.Split("`n`r")
}