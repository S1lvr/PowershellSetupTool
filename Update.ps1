$versioncheck = "https://raw.githubusercontent.com/S1lvr/PowershellSetupTool/main/InstallData/version.ini"
$versionfile = ".\InstallData\version.ini"
#Sets some variables
Write-Host "Checking for new version..."
Invoke-WebRequest -Uri $versioncheck -OutFile .\version.ini #Download the version.ini from github and compare with local.
$newversionfile = ".\version.ini"
Get-Content $versionfile | ForEach-Object {
    $script:currentversion = $_.ToInt32($Null)
    Write-Host "You are running v$script:currentversion"
}
Get-Content $newversionfile | ForEach-Object { #These two grab the number in the ini to know if the local or github is larger
    $script:newversion = $_.ToInt32($Null)
    Write-Host "Newest is v$script:newversion"
}
If ($script:currentversion -lt $script:newversion){
    Write-Host "New version found, updating..."
    $download = "https://github.com/S1lvr/PowershellSetupTool/archive/refs/heads/main.zip"
    Invoke-WebRequest $download -outfile .\newversion.zip
    Write-Host "Script downloaded..."
    Expand-Archive -path .\newversion.zip -DestinationPath .\ -Force
    Write-Host "Extracting Zip..."
    Copy-Item -Path .\PowershellSetupTool-main\*.* -Destination .\ -Recurse -Force
    Write-Host "Replacing Files..."
    Remove-Item -LiteralPath ".\PowershellSetupTool-main" -Force -Recurse
    Remove-Item -Path .\newversion.zip -force
    Write-Host "Cleaning Up..."
} else {
    Write-Host "You are already running the newest version."
}

Remove-Item .\version.ini
Write-Host "Running Script Now..."
Start-Sleep 2
start-process Powershell -ArgumentList "-f .\JAPANS.ps1"