$versioncheck = "https://raw.githubusercontent.com/S1lvr/PowershellSetupTool/main/InstallData/version.ini"
$script = "https://raw.githubusercontent.com/S1lvr/PowershellSetupTool/main/JAPANS.ps1"
$versionfile = ".\InstallData\version.ini"
$newversionfile = ".\version.ini"
$newfilelist = "https://raw.githubusercontent.com/S1lvr/PowershellSetupTool/main/InstallData/newfilelist.ini"
#Sets some variables
Write-Host "Checking for new version..."
Invoke-WebRequest -Uri $versioncheck -OutFile .\version.ini #Download the version.ini from github and compare with local.
Get-Content $versionfile | ForEach-Object {
    $script:currentversion = $_.ToInt32($Null)
}
Get-Content $newversionfile | ForEach-Object { #These two grab the number in the ini to know if the local or github is larger
    $script:newversion = $_.ToInt32($Null)
}
If ($newversionfile -gt $versionfile) { #If it's larger, remove old script and download a new one
    Write-Host "New version found, updating..."
    Remove-Item -Path .\JAPANS.ps1
    Write-Host "Deleted Old Script..."
    Invoke-WebRequest $script -OutFile .\JAPANS.ps1
    Write-Host "Downloaded New Script..."
    Remove-Item .\InstallData\version.ini
    Invoke-WebRequest $versioncheck -OutFile .\InstallData\version.ini
    Write-Host "Grabbing new content..."
    Invoke-WebRequest $newfilelist -OutFile .\newfilelist.ini
    foreach($line in Get-Content .\newfilelist.ini) {
        $file = -join(".\InstallData\" + $line)
        If (-not(Test-Path -Path $file )) {
            write-host "Program $line does not exist, downloading..."
            $download = -join("https://raw.githubusercontent.com/S1lvr/PowershellSetupTool/main/InstallData/" + $line)
            Invoke-WebRequest $download -OutFile ".\InstallData\$line"
        } else {
            write-host "Program $line installed, skipping..."
        }
    }
}

Remove-Item .\version.ini
Write-Host "Running Script Now..."
start-process Powershell -ArgumentList "-f .\JAPANS.ps1"