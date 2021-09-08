#This script downloads curl and uploads the given apk to browserstack app automate
#HOW TO RUN
#AppUpload2.ps1 -BROWSERSTACK_USERNAME YOUR_USERNAME_HERE -BROWSERSTACK_ACCESS_KEY YOUR_KEY_HERE
#or 
#AppUpload2.ps1 (it will ask for BROWSERSTACK_USERNAME and BROWSERSTACK_ACCESS_KEY if not provided)

param(
    [Parameter(Mandatory=$True, Position=0, ValueFromPipeline=$false)]
    [System.String]
    $BROWSERSTACK_USERNAME,

    [Parameter(Mandatory=$True, Position=1, ValueFromPipeline=$false)]
    [System.String]
    $BROWSERSTACK_ACCESS_KEY
)

#Download curl.exe to Downloads 
#Note can change the download location of curl if needed
$DownloadLoc = "$HOME\Downloads\"
$FileName = "curl.zip"
$uncompressed = "curl"
Invoke-WebRequest https://curl.se/windows/dl-7.78.0_4/curl-7.78.0_4-win64-mingw.zip -OutFile "$DownloadLoc$FileName"

#Unzip the curl exe
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}
try {
    Unzip $DownloadLoc$FileName $DownloadLoc$uncompressed
}
#If the curl file already exists
catch { Write-Host "Curl already exists"}
Set-Location -Path $DownloadLoc\curl\curl-7.78.0-win64-mingw\bin

#upload your App to browserstack

$user = $BROWSERSTACK_USERNAME+":"+$BROWSERSTACK_ACCESS_KEY
#Path to your apk/ipa
$filePath = "Path/To/Your/App"
$URL = "https://api-cloud.browserstack.com/app-automate/upload"

Write-Host "Uploading..."
curl.exe -u "$user" -X POST "$URL" -F "file=@$filePath"
