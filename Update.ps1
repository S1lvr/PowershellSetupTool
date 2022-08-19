$versioncheck = "https://github.com/S1lvr/PowershellSetupTool/raw/main/InstallData/version.ini"
$versionfile = ".\InstallData\version.ini"
$newversionfile = ".\version.ini"
$newscript = "https://github.com/S1lvr/PowershellSetupTool/raw/main/JAPANS.ps1"
Write-Host "Checking for new version..."
Invoke-WebRequest -Uri $versioncheck -OutFile .\version.ini
Get-Content $versionfile | ForEach-Object {
    $script:currentversion = $_.ToInt32($Null)
}
Get-Content $newversionfile | ForEach-Object {
    $script:newversion = $_.ToInt32($Null)
}
If ($newversionfile -gt $versionfile) {
    Write-Host "New version found, updating..."
    Remove-Item .\JAPANS.ps1
    Invoke-WebRequest -Uri $newscript -OutFile .\JAPANS.ps1
}
Write-Host "Using Git to grab any new custom clients..."
git fetch
git checkout origin/main -- CustomClients
Write-Host "Running Script Now..."
Remove-Item .\version.ini
start-process Powershell -ArgumentList "-f .\JAPANS.ps1"