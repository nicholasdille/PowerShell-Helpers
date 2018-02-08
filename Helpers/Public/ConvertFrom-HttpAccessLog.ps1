function ConvertFrom-HttpAccessLog {
    [Cmdletbinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $InputObject
    )

    begin {
        # Initialize DNS cache
        $DnsCache = @{}
    }

    process {
        # Enumerate $InputObject (necessary for pipeline processing)
        foreach ($Line in $InputObject) {

            # Check if a single line matches the follow regex
            if ($Line -match 
                        '(?x)
                        ^                                                  # Beginning of the line
                        (?<SourceIp>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})    # IP address
                        \s                                                 # field separator
                        \S+                                                # username provided by identd (deprecated)
                        \s                                                 # field separator
                        (?<User>\S+)                                       # username provided by HTTP authentication
                        \s                                                 # field separator
                        \[(?<Timestamp>[^]]+)\]                            # date enclosed in brackets
                        \s                                                 # field separator
                        (?<Request>".+")                                   # request enclosed in quotation marks
                        \s                                                 # field separator
                        (?<Code>\d+)                                       # HTTP return code
                        \s                                                 # field separator
                        (?<Size>\d+|-)                                     # Size of response
                        $                                                  # End of the line
                        '
                    ) {

                # Creating a hashtable with a basic set of fields
                $LogObject = @{
                    SourceIp     = $Matches[1]
                    Timestamp    = [datetime]::ParseExact($Matches[4], 'dd/MMM/yyyy:HH:mm:ss zz00', [System.Globalization.CultureInfo]::InvariantCulture)
                    Request      = $Matches[5]
                    Code         = $Matches[6]
                }

                # Checking if a user was authenticated using HTTP
                if ($Matches[3] -ne '-') {
                    $LogObject.Add('User', $Matches[3])
                }

                # Checking of the response has a size
                if ($Matches[7] -ne '-') {
                    $LogObject.Add('Size', $Matches[7])
                }

                # Checking if the source IP was already resolved to a name
                if ($DnsCache.ContainsKey($LogObject['SourceIp'])) {

                    # Retrieve name from cache
                    $SourceName = $DnsCache[$LogObject['SourceIp']]

                } else {
                    # If not, resolve IP to name
                    $SourceName = Resolve-DnsName -Name $LogObject['SourceIp'] -QuickTimeout -ErrorAction SilentlyContinue | Select-Object -ExpandProperty NameHost

                    # If no name is registered, use source IP
                    If (-Not $SourceName) {
                        $SourceName = $LogObject['SourceIp']
                    }

                    # Add name to cache
                    $DnsCache.Add($LogObject['SourceIp'], $SourceName)
                }
                # Add name to hashtable
                $LogObject.Add('SourceName', $SourceName)

                # Convert hashtable to object and output to pipeline
                [pscustomobject]$LogObject

            } else {
                # If matching fails, output a warning
                Write-Warning "Unable to parse line <$Line>"
            }
        }
    }
}