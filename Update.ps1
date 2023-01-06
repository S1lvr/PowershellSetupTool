$versioncheck = "https://raw.githubusercontent.com/S1lvr/PowershellSetupTool/main/InstallData/version.ini"
$versionfile = ".\InstallData\version.ini"
#Sets some variables, who we are and where we're going
Write-Host "Checking for new version"
Write-Host "If this hangs, ensure you're connected to the internet..."
$newversionfile = Invoke-WebRequest -uri $versioncheck -UseBasicParsing
Get-Content $versionfile | ForEach-Object { #Pull the local version.ini and check the contents
    $currentversion = $_.ToInt32($Null)
    Write-Host "You are running v$currentversion"
}
$newversion = $newversionfile.content.ToInt32($null) #Convert the online one into an Int32
Write-Host "Newest is v$newversion"
If ($currentversion -lt $newversion){ #Compare!
    Write-Host "New version found, updating..."
    $download = "https://github.com/S1lvr/PowershellSetupTool/archive/refs/heads/main.zip"
    Invoke-WebRequest $download -outfile .\newversion.zip
    Write-Host "Script downloaded..."
    Unblock-File -path .\newversion.zip
    Expand-Archive -path .\newversion.zip -DestinationPath .\ -Force
    Write-Host "Extracting Zip..."
    Get-ChildItem .\*.ps1 -Recurse | Unblock-File
    Write-Host "Trying to ensure powershell scripts downloaded work..."
    Copy-Item -Path .\PowershellSetupTool-main\*.* -Destination .\ -Recurse -Force
    Write-Host "Replacing Files..."
    Remove-Item -LiteralPath ".\PowershellSetupTool-main" -Force -Recurse
    Remove-Item -Path .\newversion.zip -force
    Write-Host "Cleaning Up..."
    Set-Location .\InstallData
    Invoke-WebRequest -uri $versioncheck -UseBasicParsing -OutFile .\version.ini
} else {
    Write-Host "You are already running the newest version."
}

Write-Host "Running Script Now..."
Start-Sleep 2
start-process Powershell -ArgumentList "-f .\JAPANS.ps1"