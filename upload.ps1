#Download curl.exe to Downloads 
#Note can change the download location if needed
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

catch { Write-Host "File already exists"}
Set-Location -Path $DownloadLoc\curl\curl-7.78.0-win64-mingw\bin

#upload your apk to browserstack
$user = "khalidshaikh_Cc8Pao:hxV3ZVmYkXGJXRbiyrvW"
$filePath = "D:\Khalid\Downloads\WikipediaSample.apk"
$URL = "https://api-cloud.browserstack.com/app-automate/upload"

curl.exe -u "$user" -X POST "$URL" -F "file=@$filePath"
