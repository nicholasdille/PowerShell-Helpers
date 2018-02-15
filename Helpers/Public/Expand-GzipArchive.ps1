function Expand-GzipArchive {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    $TargetFile = $Path -replace '\.gz$', ''

    $InputStream  = New-Object -TypeName System.IO.FileStream -ArgumentList $Path, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
    $OutputStream = New-Object -TypeName System.IO.FileStream -ArgumentList $TargetFile, ([IO.FileMode]::Create), ([IO.FileAccess]::Write), ([IO.FileShare]::None)
    $GzipStream   = New-Object -TypeName System.IO.Compression.GzipStream -ArgumentList $InputStream, ([IO.Compression.CompressionMode]::Decompress)

    $Buffer = New-Object -TypeName byte[] -ArgumentList 1024
    while ($true) {
        $BytesRead = $GzipStream.Read($Buffer, 0, 1024)
        if ($BytesRead -le 0) { break }
        $OutputStream.Write($Buffer, 0, $BytesRead)
    }

    $GzipStream.Close()
    $OutputStream.Close()
    $InputStream.Close()

    $TargetFile
}