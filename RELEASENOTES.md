# Release Notes

## 0.4.0.22

- GitHub requires TLS 1.2 now
- Added `Get-BasicAuthentication` to enable authenticated web requests without WebRequest module

## 0.3.0.19

- Added `ConvertTo-UnixEpoch` to convert a `[datetime]` to a unix epoch in nanoseconds
- Added `Expand-GzipArchive` and `Import-GzipArchive` to write to a file and the pipeline, respectively
- Added `ConvertFrom-CommonLog` to parse web logs in common log format
- Added `ConvertFrom-CloudFrontExtendedLog` to parse [logs provided by AWS CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html#BasicDistributionFileFormat)

## 0.2.1.17

- Updated for new formt of release notes

## 0.2.0.16

- Migrated to centralized build tools
- Updated to three part version numbers
- Added cmdlets to analyze HTTP access logs

## 0.1.12

- Renamed ConvertTo-Bytes to ConvertTo-ByteArray
- Renamed ConvertFrom-Bytes to ConvertFrom-ByteArray
- Updated build tools
- Improved quality by using script analyzer

## 0.1.4

- Initial release