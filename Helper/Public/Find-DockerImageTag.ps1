function Find-DockerImageTag {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Image
        ,
        [Parameter(Mandatory)]
        [switch]
        $Raw
    )

    begin {
        if ($Image -notlike '*/*') {
            $Image = "library/$Image"
        }

        $Tags = @()
    }

    process {
        $NextPage = "https://registry.hub.docker.com/v2/repositories/$Image/tags"
        while ($NextPage) {
            $Result = Invoke-RestMethod -UseBasicParsing -Uri "$NextPage"
    
            $Tags += $Result.results

            $NextPage = $Result.next
        }
    }

    end {
        if ($Raw) {
            $Tags | Sort-Object -Property name

        } else {
            $Tags.name | Sort-Object
        }
    }
}