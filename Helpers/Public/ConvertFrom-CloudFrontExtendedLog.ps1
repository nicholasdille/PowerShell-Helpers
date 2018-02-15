function ConvertFrom-CloudFrontExtendedLog {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $InputObject
    )

    process {
        # Documentation of format: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html#BasicDistributionFileFormat
        $InputObject | ForEach-Object {
            if ($_ -match
                    '(?x)
                    ^
                    (?<Date>\S+)\s
                    (?<Time>\S+)\s
                    (?<EdgeLocation>\S+)\s
                    (?<Size>\S+)\s
                    (?<SourceIp>\S+)\s
                    (?<Method>\S+)\s
                    (?<CloudFrontHost>\S+)\s
                    (?<Path>\S+)\s
                    (?<Code>\S+)\s
                    (?<Referrer>\S+)\s
                    (?<UserAgent>\S+)\s
                    (?<Query>\S+)\s
                    (?<Cookie>\S+)\s
                    (?<EndResult>\S+)\s
                    (?<CacheId>\S+)\s
                    (?<Host>\S+)\s
                    (?<Protocol>\S+)\s
                    (?<RequestSize>\S+)\s
                    (?<Duration>\S+)\s
                    (?<ForwardedFor>\S+)\s
                    (?<SslProcotol>\S+)\s
                    (?<SslCipher>\S+)\s
                    (?<BeginResult>\S+)\s
                    (?<ProtocolVersion>\S+)\s
                    (?<FleStatus>\S+)\s
                    (?<FleEncryptedFields>\S+)
                    $
                    '
                ) {
                [pscustomobject]@{
                    Timestamp    = [datetime]"$($Matches['Date']) $($Matches['Time'])"
                    Size         = $Matches['Size']
                    SourceIp     = $Matches['SourceIp']
                    ForwardedFor = $Matches['ForwardedFor']
                    Method       = $Matches['Method']
                    Path         = $Matches['Path']
                    Code         = $Matches['Code']
                    BeginResult  = $Matches['BeginResult']
                    EndResult    = $Matches['EndResult']
                    Duration     = $Matches['Duration']
                    Protocol     = $Matches['Protocol']
                }
            }
        }
    }
}