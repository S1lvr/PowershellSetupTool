$versioncheck = "https://github.com/S1lvr/PowershellSetupTool/raw/main/InstallData/version.ini"
$versionfile = ".\InstallData\version.ini"
$newversionfile = ".\version.ini"
#Sets some variables
Write-Host "Checking for new version..."
Invoke-WebRequest -Uri $versioncheck -OutFile .\version.ini #Download the version.ini from github and compare with local.
Get-Content $versionfile | ForEach-Object {
    $script:currentversion = $_.ToInt32($Null)
}
Get-Content $newversionfile | ForEach-Object {
    $script:newversion = $_.ToInt32($Null)
}
If ($newversionfile -gt $versionfile) {
    Write-Host "New version found, updating..."
    Write-Host "Using Git to grab any new custom clients..."
    .\git-cmd.exe fetch
    .\git-cmd.exe pull
}

Write-Host "Running Script Now..."
Remove-Item .\version.ini
start-process Powershell -ArgumentList "-f .\JAPANS.ps1"