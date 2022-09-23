function Get-GitHubLatestRelease {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $GitHubRepo,
        [Parameter(Mandatory=$true)]
        [string]
        $TargetFile,
        [Parameter(Mandatory=$false)]
        [ValidateSet("zip","exe")]
        [string]
        $FileType = "zip",
        [Parameter(Mandatory=$false)]
        [bool]
        $PreRelease = $false,
        [Parameter(Mandatory=$false)]
        [string]
        $TagName


    )
    if ($PreRelease) {
        $releaseUrl = "https://api.github.com/repos/$GitHubRepo/releases/latest"
        $downloadUrl = (Invoke-RestMethod -Uri $releaseUrl).assets.browser_download_url | Where-Object { $_ -like "*$FileType" }
    } 
    elseif ($TagName) {
        $releaseUrl = "https://api.github.com/repos/$GitHubRepo/releases"
        $downloadUrl = (Invoke-RestMethod -Uri $releaseUrl | Where-Object { $_.tag_name -eq $TagName }).assets.browser_download_url | Where-Object { $_ -like "*$FileType" }
    }
    else {
        $releaseUrl = "https://api.github.com/repos/$GitHubRepo/releases"
        $downloadUrl = (Invoke-RestMethod -Uri $releaseUrl | Where-Object { $_.prerelease -eq $false })[0].assets.browser_download_url | Where-Object { $_ -like "*$FileType" }
    }

    #Download the file to a temporary location
    $TempZipFile = ([System.IO.Path]::GetTempFileName())

    #Download the release
    Write-Output "Downloading $GitHubRepo release from $downloadUrl"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $TempZipFile

    #Extract the release to a temporary location
    $guid = (New-Guid).Guid
    $TempExtractLocation = Join-Path $env:TEMP $guid
    New-Item -ItemType Directory -Path $TempExtractLocation -Force
    Expand-Archive -Path $TempZipFile -DestinationPath $TempExtractLocation -Force

    #If the expanded archive has a single folder and no files, move the contents of the folder up one level
    $extractedFiles = Get-ChildItem -Path $TempExtractLocation -Recurse
    if ($extractedFiles.Count -eq 1 -and $extractedFiles[0].PSIsContainer) {
        $extractedFiles[0].MoveTo($TempExtractLocation)
        Remove-Item -Path $extractedFiles[0].FullName -Recurse
    }

    #Copy the child items of the extracted folder to the target location
    $extractedFiles = Get-ChildItem -Path $TempExtractLocation -Recurse
    $extractedFiles | ForEach-Object { Copy-Item -Path $_.FullName -Destination (Join-Path $TargetFile $_.Name) }

    #Copy-Item -Path $TempExtractLocation -Destination $TargetFile -Recurse -Force

    #Remove the temporary files
    Remove-Item -Path $TempExtractLocation -Recurse -Force

    #Remove the temporary zip file
    Remove-Item -Path $TempZipFile -Force
}
