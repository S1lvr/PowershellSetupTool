# ----------------------------------------------
#██╗░░░██╗██╗██████╗░███████╗  ░█████╗░██╗░░██╗███████╗░█████╗░██╗░░██╗
#██║░░░██║██║██╔══██╗██╔════╝  ██╔══██╗██║░░██║██╔════╝██╔══██╗██║░██╔╝
#╚██╗░██╔╝██║██████╦╝█████╗░░  ██║░░╚═╝███████║█████╗░░██║░░╚═╝█████═╝░
#░╚████╔╝░██║██╔══██╗██╔══╝░░  ██║░░██╗██╔══██║██╔══╝░░██║░░██╗██╔═██╗░
#░░╚██╔╝░░██║██████╦╝███████╗  ╚█████╔╝██║░░██║███████╗╚█████╔╝██║░╚██╗
#░░░╚═╝░░░╚═╝╚═════╝░╚══════╝  ░╚════╝░╚═╝░░╚═╝╚══════╝░╚════╝░╚═╝░░╚═╝
# ----------------------------------------------
# This makes sure your Vibes (admin rights) are on point.
param ([switch]$Elevated)

function Test-Admin
{
	$currentuser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
	$currentuser.isinrole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-admin) -eq $false)
{
	if ($elevated)
	{
		#Not a vibe.
		#tried to elevate, did not work, aborting
	}
	else
	{
		#Vibe check passed.
		Start-Process powershell.exe -Verb Runas -Argumentlist ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
	}
	exit
}
$workfolder = $MyInvocation.MyCommand.Path
$myname = $MyInvocation.MyCommand.Name
$pos = $workfolder.IndexOf($myname)
$working = $workfolder.Substring(0, $pos)
Set-Location $working
unblock-file -path .\InstallData\SFTA.ps1
import-module .\InstallData\SFTA.ps1 -disablenamechecking -scope local
#Install PSWindows Update and start grabbing updates
if ($null -eq `
	(Get-InstalledModule `
    -Name "AzureRm.Profile" `
    -ErrorAction SilentlyContinue)) {
		Write-Host "Installing PSWindows Update..."
		Install-Module -Name PSWindowsUpdate -Force
		Write-Host "Starting Windows Update in Background..."
		Start-Sleep 1
		Get-WindowsUpdate -AcceptAll
		Start-Job -Name "WUpdate" -ScriptBlock {Install-WindowsUpdate -AcceptAll}
} else {
	Write-Host "Starting Windows Update in Background..."
	Get-WindowsUpdate -AcceptAll
	Start-Job -Name "WUpdate" -ScriptBlock {Install-WindowsUpdate -AcceptAll}
}
# --------------------------------------------------------------------------------------------------
#░█████╗░██╗░░░░░██╗███████╗███╗░░██╗████████╗░██████╗
#██╔══██╗██║░░░░░██║██╔════╝████╗░██║╚══██╔══╝██╔════╝
#██║░░╚═╝██║░░░░░██║█████╗░░██╔██╗██║░░░██║░░░╚█████╗░
#██║░░██╗██║░░░░░██║██╔══╝░░██║╚████║░░░██║░░░░╚═══██╗
#╚█████╔╝███████╗██║███████╗██║░╚███║░░░██║░░░██████╔╝
#░╚════╝░╚══════╝╚═╝╚══════╝╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░
# --------------------------------------------------------------------------------------------------
#█▀▀ █░░ █ █▀▀ █▄░█ ▀█▀   █░░ █ █▀ ▀█▀
#█▄▄ █▄▄ █ ██▄ █░▀█ ░█░   █▄▄ █ ▄█ ░█░
# --------------------------------------------------------------------------------------------------
$clientarray = @(
	"Campbells True Value"
	"Golden Pond Wealth Management"
	"Home Hope And Healing"
	"Northern Outdoors"
	"Ray Haskell Ford"
	"Ware Butler"
	"Century 21 SRE"
	"Rockland Realty"
    "Mabel Wadsworth"
	"United Way TVA"
	"Harris Lumber"
	"CB Mattson"
	"Maine Center for Dental Medicine"
	"Granite Corp"
	"Hawks Nest Lodge"
	"Hometown Heat Pumps"
	"Kennebec Eye Care"
	"Maine Coalition to End Domestic Violence"
	"Carey Land Surveys"
	"Valley Beverage"
	"Maine Vocational Rehab Associates"
	"Family Violence Project"
	"Maine Forest Products Council"
	"Sexual Assault Center"
	"Snow Pond"
	"Combined Benefits United"
)
# New Client Process:
# Add Client name to the Array above, using spaces instead of underscores, this list is automatically sorted alphabetically, so don't worry about that.
# Create a function with the name scheme Get-<CLIENTNAME> where <CLIENTNAME> is
# What you placed in the array above, but with underscores instead of spaces.
# Next Add commands to the function, for extra help, Ware Butler's function is
# Completely Commented.
#-----------
#*Feature Additions/Changes:
#---
#Todo: Finish Custom Client UI ( Domain Settings )
#! or
#Todo: Remove Custom Client Code since we never use it
#---
#Todo: See if change in startup items script work. # It doesn't
<# Try this:
# Stop Microsoft Teams from launching on startup
$TeamsService = Get-Service -Name "Teams"
$TeamsService.StartType = "Disabled"
$TeamsService.Stop()

# Stop Microsoft Edge from launching on startup
$EdgeStartupTask = Get-ScheduledTask -TaskName "MicrosoftEdgeUpdateTaskMachineCore"
$EdgeStartupTask.State = "Disabled"
$EdgeStartupTask.Stop()
#>
#Todo: Fix Loading Bar
<#
function Get-FunctionLineCount
{
	param
	(
		[parameter(Mandatory = $true, Position = 0)]
		[String]$FunctionName
	)
	# Get the function definition
	$functionDefinition = Get-Content function:$FunctionName

	# Split the function definition into lines
	$lines = $functionDefinition -split "`n"

	# Return the number of lines minus 2
	return $lines.Count - 2
}
This function will return the number of lines in a function, telling us the number of steps in our setup process.
#>
#Todo: See about replacing included installers with pulling a new one every time to lower size of initial update/download
#Todo: See about adding new scheduled task that runs on user login within the next day that does per-user settings.
#Todo: REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\AteraAgent" /VE /T REG_SZ /F /D "Service"
	# Do that ^ To add Atera as able to be ran in safe mode with networking.
	# It didn't work that well, hold off.
#*Config Changes:
#Todo: Set up a "run just this command" option so I can do this easier.
#Todo: Run This Options:
#Todo:	Install Chrome/Reader / Done
#Todo:	Install Atera / Done
#Todo:	Install WebRoot
#Todo:	Install Office / Done
#Todo:	Add to Domain
#Todo:	Rename PC / Done
#Todo:	Add to AzureAD
#Todo:  NetEx Installer
#Client Changes:
#*Ware Butler / Harris:
#Todo: Use that screenshot I took to do a second run for the epicor installer.
#*Hometown Heat Pumps:
#Todo: Add Avast to Installed Programs
#Todo: Add Firefox to Installed Programs
#Todo: Add Trello to Installed Programs
#Todo: Add Classic Shell to Installed Programs
#* As Seperate Script for HHP:
#Todo: Use https://stackoverflow.com/questions/31720595/pin-program-to-taskbar-using-ps-in-windows-10 or http://www.technosys.net/products/utils/pintotaskbar to auto-pin
#Todo: Use https://stackoverflow.com/questions/68503485/how-to-sync-a-sharepoint-365-folder-using-a-bat-or-powershell to sync sharepoint
#*Ray Haskell Ford:
#Todo: Install TightVNC Server
function Get-Combined_Benefits_United {
	Set-NewPCName
	Install-Atera 65
	Install-Webroot 608E-ATRA-35EF-1799-4431
	Install-GChrome
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "CBUworkstation!"
	Set-AzureADAccount
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Snow_Pond {
	Install-Atera 92
	Install-Webroot CFAC-ATRA-27D0-1B0C-42DA
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "SPworkstation!"
	Set-DNSAndDomain -DNSServer "10.1.10.3" -DomainServer "ad.snowpond.org"
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Sexual_Assault_Center {
	Set-NewPCName
	Install-Atera 61
	Install-Webroot BB25-ATRA-FE8D-60CE-4F87
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "SACSCworkstation!"
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Maine_Forest_Products_Council {
	Set-NewPCName
	Install-Atera 76
	Install-Webroot 7DD7-ATRA-BDCF-F188-4925
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "MFPCworkstation!"
	Set-AzureADAccount
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Family_Violence_Project {
	Install-Atera 101
	Install-Webroot 32E3-ATRA-3229-C0FC-4970
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "FVPworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.25.92" -DomainServer "FVP.local"
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Maine_Vocational_Rehab_Associates {
	Install-Atera 78
	Install-Webroot 635F-ATRA-8D21-17F3-4143
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "MVRAworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.5.15" -DomainServer "MVRA.local"
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Valley_Beverage {
	Install-Atera 58
	Install-Webroot EA4A-ATRA-A9A6-8EDA-4FEF
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "VBworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.100.12" -DomainServer "valley.local"
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Carey_Land_Surveys {
	Set-NewPCName
	Install-Atera 95
	Install-Webroot A008-ATRA-508A-310F-41FA
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "CLSworkstation!"
	#Set-TSMPassword $TSMPass
	#Set-AzureADAccount
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Kennebec_Eye_Care {
	Install-Atera 37
	Install-Webroot 062A-ATRA-708E-C101-4284
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "KECworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.0.5" -DomainServer "kennebeceye.local"
	Install-OfficeMate
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Hometown_Heat_Pumps {
	Set-NewPCName
	Install-Atera 28
	Install-Webroot C88B-ATRA-9B3C-BAA8-4772
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "HHPworkstation!"
	Set-AzureADAccount
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Maine_Coalition_to_End_Domestic_Violence {
	#Invoke-SetupStep Set-NewPCName
	Set-NewPCName
	Install-Atera 84
	Install-Webroot C327-ATRA-F230-F57B-4204
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "MCEDVworkstation!"
	Set-AzureADAccount
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Hawks_Nest_Lodge {
	Set-NewPCName
	Install-Atera 40
	Install-Webroot 532B-ATRA-B237-320F-41B6
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword "HNworkstation!"
	Set-AzureADAccount
	Install-OfficeInstaller
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Granite_Corp
{
	Install-Atera 3
	Install-Webroot 5477-ATRA-AAEC-93E6-450E
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "GCworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.16.3" -DomainServer "Granite-Corp.com"
	Install-OfficeInstaller
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}
function Get-Maine_Center_for_Dental_Medicine
{
	Install-Atera 11
	Install-Webroot A17D-ATRA-C256-BC28-4CA2
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "MCDMworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.2.53" -DomainServer "MCDM.local"
	Install-EagleSoft
	Install-OfficeInstaller
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}
function Get-CB_Mattson
{
	Install-Atera 38
	Install-Webroot 5A76-ATRA-04A6-8F94-425E
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Install-NetEx
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "CBMworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.1.15" -DomainServer "CB-Mattson.loc"
	Install-OfficeInstaller
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}
function Get-United_Way_TVA
{
	Set-NewPCName
	Install-Atera 24
	Install-Webroot B471-ATRA-B1A3-003E-4713
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "UWTVAworkstation!"
	Set-AzureADAccount
	Install-OfficeInstaller
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}
function Get-Mabel_Wadsworth
{
    Install-Atera 56
    Install-Webroot 0AF7-ATRA-16A5-FE4D-46F0
    Install-GChrome
    Set-ChromeDefault
    Install-Reader
    Install-OfficeInstaller
    Get-PowerSettingChanges
	Install-Shared
    Set-TSMPassword -password "MWworkstation!"
    Set-DNSAndDomain -DNSServer "192.168.1.9" -DomainServer "mwadsworth.local"
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}
function Get-Rockland_Realty
{
	Set-NewPCName
	Install-Atera 42
	Install-Webroot 0D2E-ATRA-129F-8320-4CBA
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "RRworkstation!"
	[System.Windows.MessageBox]::Show("Rockland Realty has a weird system, you can't add to their domain unless you on-site so. Good Luck.")
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}
function Get-Century_21_SRE
{
	Set-NewPCName
	Install-Atera 5
	Install-Webroot 985C-ATRA-FA09-ED7C-4F98
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "C21workstation!"
	Set-AzureADAccount
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}
function Get-Campbells_True_Value
{
	Install-Atera 5
	Install-Webroot CDAB-ATRA-9D91-4CC3-4121
	Install-Epicor Campbells
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "CTVworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.1.250" -DomainServer "Burger-Roy.local"
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Golden_Pond_Wealth_Management
{
	Install-Atera 31
	Install-Webroot 6F59-ATRA-6284-A3BA-4625
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "GPworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.16.252" -DomainServer "GoldenPondWealth.local"
	import-module bitlocker
	$BitLocker = Get-BitLockerVolume -MountPoint $env:SystemDrive 
	$RecoveryProtector = $BitLocker.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' }
	   
	foreach ($Key in $RecoveryProtector.KeyProtectorID) {
				try {
					BackupToAAD-BitLockerKeyProtector -MountPoint $env:SystemDrive -KeyProtectorId $Key
				}
				catch {
					Write-Output "Could not back up to Azure AD. Error: "
					Write-Output $_
				}
	}
	Get-BitLockerVolume | Enable-Bitlocker -MountPoint $env:SystemDrive -UsedSpaceOnly -SkipHardwareTest -TpmProtector
	Add-OutputBoxLine "Bitlocker Enabled."
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Home_Hope_And_Healing
{
	Install-Atera 6
	Install-Webroot 0252-ATRA-5CEE-9DD5-4820
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "HHHworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.1.6" -DomainServer "hhh.lan"
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Northern_Outdoors
{
	Set-NewPCName
	Install-Atera 8
	Install-Webroot E47E-ATRA-9B40-6CB7-4656
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "NOworkstation!"
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Ray_Haskell_Ford
{
	Install-Atera 2
	Install-Webroot 8DF6-ATRA-720C-25F4-4595
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	#Install-CDK
	Install-OfficeInstaller
	Get-PowerSettingChanges
	Install-Shared
	Set-TSMPassword -password "RHworkstation!"
	Set-DNSAndDomain -DNSServer "10.5.190.202" -DomainServer "haskell.local"
	Add-OutputBoxLine "Setup Complete."
	Resolve-ProgressBar
}
function Get-Harris_Lumber
{
	Set-NewPCName
	Install-Atera 98
	Install-Webroot 21DA-ATRA-CC82-EC91-4DF6
	Install-Epicor WB
	Install-Compass
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
	Get-PowerSettingChanges
	Install-Shared
	Install-OfficeInstaller
	Set-TSMPassword -password "HLworkstation!"
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Ware_Butler #Name of function, if you check the list near the bottom, the list entry is Ware_Butler, so this is Get-Ware_Butler
{
	Set-NewPCName #Prompt the tech for a new PC name
	Install-Atera 29 #Install Atera with ClientID 29 (Ware Butler) You can find this in the URL of the customer page
	Install-Webroot 86C2-ATRA-5003-6C03-4077 #Install Webroot with this key found in the Endpoint Protection section
	Install-Epicor WB #Install Ware Butler's Epicor
	Install-NetEx #Install Net Extender
	Install-GChrome #Install Chrome
	Set-ChromeDefault #Sets Chrome as default web browser, mostly so Reader doesn't open edge after it's install.
	Install-OfficeInstaller #Install Office
	Install-Reader #Install Reader
	Get-PowerSettingChanges #This will open a batch file to set power settings
	Install-Shared #I added this to just run things that should be ran on all PCs
	Set-TSMPassword -password "WBworkstation!" #Set the password to match standard convention for TSMAdmin
	Set-AzureADAccount #I just made this one, it just opens the settings window to add a computer to a domain.
	Add-OutputBoxLine "Setup Completed." #Say it's done in the output box
	Resolve-ProgressBar #Make sure the progress bar doesn't make us a liar.
}
function Get-Custom
{
	#Custom Plan:
	#Use Radios and Checkboxes to select these options
	#From there, use that to decide what to install
	#Next, attempt to save completed script as a function in a .ps1
	#That way I can 
	# foreach ($file in $directory) { import-module $file }
	#from there, I'll need a way to add each imported file to the array.
	#perhaps save the .ps1 names as the client name?
	# If Foreach doesn't work, might have to repurpose
	# the Foreach-object loop there.
	# foreach ($file in $directory) {
	#		import-module $file
	# 		Set-InstallStartupDirectory
	# 		cd ..\ClientData
	# 		Get-ChildItem .\ -Filter *.ps1 |
	#		Foreach-Object { 
	#             $filename = Get-Content $_.FullName
	#             $clientarray.add($filename)
	#		}
	# }
	# That should add all .ps1 files in ScriptDir\ClientData
	# as clients via the script names.
	# all commands can be placed in an array, as exporting an array will make each entry a new line.
	# create array then just
	# $customarray | Out-File $exportfilename
	# it will also 100% be easiest to always make the array
	# then just save it if they want to.
	
	#Create Main Window
	$formcustom = New-Object System.Windows.Forms.Form
	$formcustom.Text = 'Custom Client Setup'
	$formcustom.Size = New-Object System.Drawing.Size(540, 300)
	$formcustom.StartPosition = 'CenterScreen'
	
	$okButtonCustom = New-Object System.Windows.Forms.Button
	$okButtonCustom.Location = New-Object System.Drawing.Point(75, 240)
	$okButtonCustom.Size = New-Object System.Drawing.Size(75, 23)
	$okButtonCustom.Text = 'OK'
	$okButtonCustom.DialogResult = [System.Windows.Forms.DialogResult]::OK
	$formcustom.AcceptButton = $okButtoncustom
	$formcustom.Controls.Add($okButtoncustom)
	
	$cancelButtoncustom = New-Object System.Windows.Forms.Button
	$cancelButtoncustom.Location = New-Object System.Drawing.Point(150, 240)
	$cancelButtoncustom.Size = New-Object System.Drawing.Size(75, 23)
	$cancelButtoncustom.Text = 'Cancel'
	$cancelButtoncustom.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
	$formcustom.CancelButton = $cancelButtoncustom
	$formcustom.Controls.Add($cancelButtoncustom)
	
	$label1 = New-Object System.Windows.Forms.Label
	$label1.Location = New-Object System.Drawing.Point(10, 20)
	$label1.Size = New-Object System.Drawing.Size(180, 20)
	$label1.Text = 'Atera ClientID'
	$formcustom.Controls.Add($label1)
	
	$label2 = New-Object System.Windows.Forms.Label
	$label2.Location = New-Object System.Drawing.Point(10, 80)
	$label2.Size = New-Object System.Drawing.Size(180, 20)
	$label2.Text = 'Webroot Key'
	$formcustom.Controls.Add($label2)
	
	$AteraKey = New-Object System.Windows.Forms.TextBox
	$AteraKey.Location = New-Object System.Drawing.Point(10, 40)
	$AteraKey.Size = New-Object System.Drawing.Size(160, 20)
	$formcustom.Controls.Add($AteraKey)
	
	$WebrootKey = New-Object System.Windows.Forms.TextBox
	$WebrootKey.Location = New-Object System.Drawing.Point(10, 100)
	$WebrootKey.Size = New-Object System.Drawing.Size(160, 20)
	$formcustom.Controls.Add($WebrootKey)
	
	$label3 = New-Object system.windows.forms.Label
	$label3.location = New-Object system.drawing.point (200, 20)
	$label3.size = New-Object system.drawing.size(280, 20)
	$label3.text = 'Client Name'
	$formcustom.controls.add($label3)
	
	$newclientname = New-Object system.windows.forms.TextBox
	$newclientname.location = New-Object System.Drawing.Point(200, 40)
	$newclientname.size = New-Object system.drawing.size(260, 20)
	$formcustom.Controls.add($newclientname)
	
	$checkbox1 = new-object System.Windows.Forms.checkbox
	$checkbox1.Location = new-object System.Drawing.Point(10, 120)
	$checkbox1.Size = new-object System.Drawing.Size(150, 50)
	$checkbox1.Text = "Install Net Extender"
	$Formcustom.Controls.Add($checkbox1)
	
	$checkbox2 = new-object System.Windows.Forms.checkbox
	$checkbox2.Location = new-object System.Drawing.Point(10, 160)
	$checkbox2.Size = new-object System.Drawing.Size(250, 50)
	$checkbox2.Text = "Install Chrome"
	$checkbox2.Checked = $true
	$Formcustom.Controls.Add($checkbox2)
	
	$checkbox3 = New-Object System.Windows.Forms.checkbox
	$checkbox3.location = New-Object system.drawing.point(10, 200)
	$checkbox3.size = New-Object system.drawing.size(250, 50)
	$checkbox3.text = "Install Office"
	$formcustom.Controls.Add($checkbox3)
	
	$checkbox4 = New-Object System.Windows.Forms.checkbox
	$checkbox4.location = New-Object system.drawing.point(170, 120)
	$checkbox4.size = New-Object system.drawing.size(250, 50)
	$checkbox4.text = "Install Adobe Reader"
	$checkbox4.Checked = $true
	$formcustom.Controls.Add($checkbox4)
	
	$formcustom.Topmost = $true
	
	$formcustom.Add_Shown({ $AteraKey.Select() })
	$result = $formcustom.ShowDialog()
	
	#Now put it all together
	if (($result -eq [System.Windows.Forms.DialogResult]::OK))
	{
		$clienttest = -join (".\CustomClients\", $newclientname, ".ps1")
		if (Test-Path -Path $clienttest) #this IF check if the custom client already exists.
		{
			[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
			[System.Windows.MessageBox]::Show('Hey that client name already exists. Either try another one or double check it is not already there. Attempting to restart setup.')
			break; Get-Custom # Does this restart the custom install? does this just explode your PC? who knows.
		}
		else
		{
			#if it doesn't let's go
			$newnewclientname = $newclientname.replace(' ', '_')
			$firstline = -join ("function Get-", "$($newnewclientname.Text)")
			$newclientarray = @(
				"<#"
				".Synopsis"
				"Set up a client."
				".Description"
				"Custom Setup to set up a Client's new PC"
				".Example"
				"Get-Client runs as itself"
				"#>"#this is so stupid but it's how we're going to export our custom client
				$firstline #just write the new function line by line
				"{" #then import all .ps1s in the custom client folder.
				"Set-NewPCName" #and run this since all of them should have this.
				"Invoke-Win10PinRemoval"
			)
			$newclientarray += -join ("Install-Atera -ClientID ", "$($AteraKey.Text)")
			$newclientarray += -join ("Install-Webroot -key ", "$($WebrootKey.Text)")
			if ($checkbox1.Checked -eq $true)
			{
				Install-NetEx
				$newclientarray += "Install-NetEx"
			}
			if ($checkbox2.Checked -eq $true)
			{
				Install-GChrome
				$newclientarray += "Install-GChrome"
				Set-ChromeDefault
				$newclientarray += "Set-ChromeDefault"
			}
			if ($checkbox3.Checked -eq $true)
			{
				Install-OfficeInstaller
				$newclientarray += "Install-OfficeInstaller"
			}
			if ($checkbox4.checked -eq $true)
			{
				Install-Reader
				$newclientarray += "Install-Reader"
			}
			Get-PowerSettingChanges
			$newclientarray += "Get-PowerSettingChanges"
			Add-OutputBoxLine "Setup Completed."
			$newclientarray += "Add-OutputBoxLine 'Setup Completed.'"
			Resolve-ProgressBar
			$newclientarray += "Resolve-ProgressBar"
			$newclientarray += "}"
			$savenewclient = $true
			if ($savenewclient -eq $true)
			{
				$newfilename = -join ("$($newclientname.Text)", ".ps1")
				if (Test-Path -Path $Folder)
				{
					$folder = ".\CustomClients"
					Set-Location $folder
					foreach ($line in $newclientarray)
					{
						Add-Content $newfilename $line
					}
				}
				else
				{
					New-Item ".\CustomClients" -Type Directory
					$folder = ".\CustomClients"
					Set-Location $folder
				}
				foreach ($line in $newclientarray)
				{
					Add-Content $newfilename $line
				}
			}
		}
	}
}

# --------------------------------------------------------------------------------------------------
#░██████╗███████╗████████╗██╗░░░██╗██████╗░
#██╔════╝██╔════╝╚══██╔══╝██║░░░██║██╔══██╗
#╚█████╗░█████╗░░░░░██║░░░██║░░░██║██████╔╝
#░╚═══██╗██╔══╝░░░░░██║░░░██║░░░██║██╔═══╝░
#██████╔╝███████╗░░░██║░░░╚██████╔╝██║░░░░░
#╚═════╝░╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░
# --------------------------------------------------------------------------------------------------
function Get-PopUp {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true,
					Position = 0)]
		[string]
		$PMSG
	)
	[System.Windows.MessageBox]::Show($PMSG)
}
function Install-Shared {
	#- Support Assist
	$manf = Get-WMIObject -class Win32_ComputerSystem
	if($manf.Manufacturer -like "Dell*"){ 
		Add-OutputBoxLine "This PC is 100% a certified DELL."
		Add-OutputBoxLine "Installing Support Assist for Drivers..."
		Set-InstallStartupDirectory
		Start-Process ".\SupportAssistInstaller.exe" -Wait
		Get-PopUp "Ok so next you WILL need to launch Support Assist after this, and have it run 'Update.' to grab drivers."
	}
	#- Splashtop SOS
	Add-OutputBoxLine "Installing Splashtop SOS..."
	New-Item "C:\Splashtop" -Type Directory 
	Set-InstallStartupDirectory
	copy-item -Path .\SplashtopSOS.exe -Destination "C:\Splashtop\SplashtopSOS.exe"
	 	$SourceFilePath = "C:\Splashtop\SplashtopSOS.exe"
		$ShortcutPath = "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\SplashtopSOS.lnk"
		$WScriptObj = New-Object -ComObject ("WScript.Shell")
		$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
		$shortcut.TargetPath = $SourceFilePath
	$shortcut.Save()
}
#Default Apps Settings
function Set-DefaultMail { # Thank you Mr. Random Czech Microsoft Dev for making this easy.
    Set-InstallStartupDirectory
    #Start-Process SetUserFTA.exe -Wait -ArgumentList "mailto Outlook.URL.mailto.15"
	Set-FTA Outlook.URL.mailto.15 mailto
	# * Set-FTA Outlook.URL.mailto.15 mailto # This is for integration of the SFTA.ps1 script
	#If you want to use this for other things, you have to "SetUserFTA.exe get" first.
	#Grab the info you need from the associations, then use that.
}
function Set-DefaultPDF {
    Set-InstallStartupDirectory
    # * Start-Process SetUserFTA.exe -Wait -ArgumentList ".pdf AcroExch.Document.DC"
	Set-FTA AcroExch.Document.DC .pdf
}
function Set-ChromeDefault
{
	# * Set-InstallStartupDirectory
	# * Start-Process SetDefaultBrowser.exe -Wait -ArgumentList "chrome"
	Set-FTA ChromeHTML http
	Set-FTA ChromeHTML https
	Set-FTA ChromeHTML .html
	Set-FTA ChromeHTML .htm
	Add-OutputBoxLine -Message "Chrome has been set as Default Web Browser."
}
#Windows 10 Pin Removal
function Invoke-Win10PinRemoval #this was already a powershell script. Ctrl + C and Ctrl + V my guy.
{
	#Disable pin requirement
	$path = "HKLM:\SOFTWARE\Policies\Microsoft"
	$key = "PassportForWork"
	$TSMName = "Enabled"
	$value = "0"
	
	New-Item -Path $path -Name $key -Force
	New-ItemProperty -Path $path\$key -Name $TSMName -Value $value -PropertyType DWORD -Force
	#Delete existing pins
	$passportFolder = "C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc"
	if (Test-Path -Path $passportFolder)
	{
		Takeown /f $passportFolder /r /d "Y"
		ICACLS $passportFolder /reset /T /C /L /Q
		Remove-Item -path $passportFolder -recurse -force
	}
	Add-OutputBoxLine "Ran Windows 10 Pin Removal Script."
}
#--------------------------
#█▀█ █▀█ █▀█ █▀▀ █▀█ █▀▀ █▀ █▀   █▄▄ ▄▀█ █▀█
#█▀▀ █▀▄ █▄█ █▄█ █▀▄ ██▄ ▄█ ▄█   █▄█ █▀█ █▀▄
#--------------------------
function Get-SetupSteps { #This will once i make it work grab the script (itself) and then find the # of lines in the function requested, as to make the progress bar work.
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true,
					Position = 0)]
		[string]
		$functionname
	)
	Get-Content $me
	$thefunction = Splitfrom("$functionname {").Splitfrom('}')
	$i = 0
	foreach ($element in $thefunction) {$i++}
	$progressbar1.maximum = $i
}
function Invoke-SetupStep
{
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]
		$command
	)
	Start-Job -name "SetupStep" -ScriptBlock $command
	Wait-Job -Name "SetupStep"
}
function Get-SuperInput #I made this for the old custom system but I like it too much to get rid of it
{
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]$title,
		[Parameter(Mandatory = $true,
				   Position = 1)]
		[string]$msg
		
	)
	$winstate = $form.WindowState
	$form.WindowState = "Minimized"
	[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
	
	
	$script:text = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
	$form.WindowState = $winstate
}
function Resolve-ProgressBar
{
	$progressbar1.style = "blocks"
	$progressbar1.maximum = 1
	$progressbar1.step = 1
	$progressbar1.value = 0
	$progressbar1.Increment(1)
}

function Set-InstallStartupDirectory
{
	Set-Location $working
	Set-Location .\InstallData
}
#Set password for TSMAdmin
function Set-TSMPassword
{
	param
	(
		[parameter(Mandatory = $true, Position = 0)]
		[String]$thepass
	)
	$tsmpass = $thepass | ConvertTo-SecureString -AsPlainText -Force
	#$TSMUser = Get-LocalUser -Name "TSMAdmin"
<#	if ($null -eq $TSMUser) {
		Add-OutputBoxLine "TSMAdmin account not found, creating..."
		New-LocalUser -Name "TSMAdmin" -NoPassword
	} else {
		Add-OutputBoxLine "TSMAdmin account found,"
	}#>
	Add-OutputBoxLine "Setting TSMAdmin Password to $thepass..."
	#$TSMName = $TSMUser.name
	Set-LocalUser -Name "TSMAdmin" -Password $tsmpass -PasswordNeverExpires 1
}
<#function Get-TemperFolder {
    $Folder = "C:\Temp"
    if(-not (Test-Path -Path $Folder) {
        New-Item "C:\Temp" -Type Directory
    }
    Set-Location "C:\Temp"
}#>
function Get-TempFolder {
	$Folder = "C:\Temp"
	if (-not (Test-Path -Path $Folder))
	{
		New-Item "C:\Temp" -Type Directory
	}
	Set-Location "C:\Temp"
	#make a folder to work out of, if it doesn't exist
}
function Set-StaticIP {
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]$IP,
		[Parameter(Mandatory = $true,
				   Position = 1)]
		[string]$Gateway
		
	)
	#$IP = $ipaddr
	$MaskBits = 24 # This means subnet mask = 255.255.255.0
	#$Gateway = $gatewayaddr
	$Dns = "1.1.1.1"
	$IPType = "IPv4"
	# Retrieve the network adapter that you want to configure
	$adapter = Get-NetAdapter | Where-Object {$_.Status -eq "up"}
	# Remove any existing IP, gateway from our ipv4 adapter
	If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 		$adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
	}
	If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 		$adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
	}
 	# Configure the IP address and default gateway
	$adapter | New-NetIPAddress `
 	-AddressFamily $IPType `
 	-IPAddress $IP `
 	-PrefixLength $MaskBits `
 	-DefaultGateway $Gateway
	# Configure the DNS client server IP addresses
	$adapter | Set-DnsClientServerAddress -ServerAddresses $DNS
}
#░█████╗░███████╗███████╗██╗░█████╗░███████╗  ███╗░░░███╗░█████╗░████████╗███████╗
#██╔══██╗██╔════╝██╔════╝██║██╔══██╗██╔════╝  ████╗░████║██╔══██╗╚══██╔══╝██╔════╝
#██║░░██║█████╗░░█████╗░░██║██║░░╚═╝█████╗░░  ██╔████╔██║███████║░░░██║░░░█████╗░░
#██║░░██║██╔══╝░░██╔══╝░░██║██║░░██╗██╔══╝░░  ██║╚██╔╝██║██╔══██║░░░██║░░░██╔══╝░░
#╚█████╔╝██║░░░░░██║░░░░░██║╚█████╔╝███████╗  ██║░╚═╝░██║██║░░██║░░░██║░░░███████╗
#░╚════╝░╚═╝░░░░░╚═╝░░░░░╚═╝░╚════╝░╚══════╝  ╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝
function Install-OfficeMate {
	$PreInstall = "https://officemate-prod.s3.amazonaws.com/AutoUpdate/omsuite/release/downloads/VB2NetServerSuiteInstallers/OM.PreInstallCheck.Installer.exe"
	Get-TempFolder
	Invoke-WebRequest -Uri $PreInstall -Outfile C:\Temp\PreInstaller.exe
	[System.Windows.MessageBox]::Show('Ok so this will install and run the Pre Installer, you have to go their site to download actual Office Mate, which this script will open for you, as well as give you instructions in a text file.')
	Start-Process PreInstaller.exe -wait
	Add-OutputBoxLine "Mapping O Drive for Officemate..."
	New-PSDrive -Name "O" -PSProvider FileSystem -Root "\\kec-server\DATA" -Persist
	$instructions = @(
		"Ok so the officemate page is going to open."
		"You have to:"
		"- Scroll down to the contact section"
		"- Input a name and email"
		"The Phone of the Practice, 207-872-2797"
		"The Name: Kennebec Eye Care"
		"Check that you run the preinstall checker"
		'Select "No" for MIPS'
		"Submit, then select OfficeMate Suite"
		"Run the installer as admin,"
		"And point it to the O: drive for data."
	)
	Write-Output $instructions > instructions.text
	Start-Process notepad.exe -ArgumentList "C:\Temp\instructions.txt"
	Start-Process "http://www.eyefinity.com/practice-management/officemate/om15.html"
}
#░██████╗████████╗░█████╗░██████╗░████████╗██╗░░░██╗██████╗░  ██╗████████╗███████╗███╗░░░███╗░██████╗
#██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝██║░░░██║██╔══██╗  ██║╚══██╔══╝██╔════╝████╗░████║██╔════╝
#╚█████╗░░░░██║░░░███████║██████╔╝░░░██║░░░██║░░░██║██████╔╝  ██║░░░██║░░░█████╗░░██╔████╔██║╚█████╗░
#░╚═══██╗░░░██║░░░██╔══██║██╔══██╗░░░██║░░░██║░░░██║██╔═══╝░  ██║░░░██║░░░██╔══╝░░██║╚██╔╝██║░╚═══██╗
#██████╔╝░░░██║░░░██║░░██║██║░░██║░░░██║░░░╚██████╔╝██║░░░░░  ██║░░░██║░░░███████╗██║░╚═╝░██║██████╔╝
#╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░  ╚═╝░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝╚═════╝░
function Disable-Startups {#I took this entire function from StackOverflow with 0 shame.
#Jsc, et al. “Disabling Startup Programs.” Stack Overflow, 18 Oct, 2018, https://stackoverflow.com/questions/52692879/disabling-startup-programs. 
    Param
    (
        [parameter(DontShow = $true)]
        $32bit = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
        [parameter(DontShow = $true)]
        $32bitRunOnce = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce",
        [parameter(DontShow = $true)]
        $64bit = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run",
        [parameter(DontShow = $true)]
        $64bitRunOnce = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\RunOnce",
        [parameter(DontShow = $true)]
        $currentLOU = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
        [parameter(DontShow = $true)]
        $currentLOURunOnce = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"
    )

    begin 
    {
        $disableList = @(
		'Cortana'
		'Microsoft Edge'
		'Microsoft Teams'
		'Skype'
		'Send to OneNote Tool'
        )
        New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS | out-null
        $startups = Get-CimInstance Win32_StartupCommand | Select-Object Name,Location
    }
    process 
    {
		foreach ($startUp in $startUps){
            if ($startUp.Name -in $disableList){
                $number = ($startUp.Location).IndexOf("\")
                $location = ($startUp.Location).Insert("$number",":")
                Write-Output "Disabling $($startUp.Name) from $location)"
                #Remove-ItemProperty -Path "$location" -Name "$($startUp.name)" 
            }
        }
        $regStartList = Get-Item -path $32bit,$32bitRunOnce,$64bit,$64bitRunOnce,$currentLOU,$currentLOURunOnce |
		Where-Object {$_.ValueCount -ne 0} | Select-Object  property,name

		foreach ($regName in $regStartList.name) {
   		$regNumber = ($regName).IndexOf("\")
   		$regLocation = ($regName).Insert("$regNumber",":")
   		if ($regLocation -like "*HKEY_LOCAL_MACHINE*"){
    	$regLocation = $regLocation.Replace("HKEY_LOCAL_MACHINE","HKLM")
    	write-host $regLocation
   		}
   		if ($regLocation -like "*HKEY_CURRENT_USER*"){
    	$regLocation = $regLocation.Replace("HKEY_CURRENT_USER","HKCU")
    	write-host $regLocation
   }
    foreach($disable in $disableList) {
       if (Get-ItemProperty -Path "$reglocation" -name "$Disable"-ErrorAction SilentlyContinue) {
            Write-host "yeah i exist"
            #Remove-ItemProperty -Path "$location" -Name "$($startUp.name)" -whatif
       }else {write-host "no exist"}
    }   

}
    }
    end {}
}

#░█████╗░███████╗██╗░░░██╗██████╗░███████╗ ░█████╗░██████╗░
#██╔══██╗╚════██║██║░░░██║██╔══██╗██╔════╝ ██╔══██╗██╔══██╗
#███████║░░███╔═╝██║░░░██║██████╔╝█████╗░░ ███████║██║░░██║
#██╔══██║██╔══╝░░██║░░░██║██╔══██╗██╔══╝░░ ██╔══██║██║░░██║
#██║░░██║███████╗╚██████╔╝██║░░██║███████╗ ██║░░██║██████╔╝
#╚═╝░░╚═╝╚══════╝░╚═════╝░╚═╝░░╚═╝╚══════╝ ╚═╝░░╚═╝╚═════╝░
function Set-AzureADAccount {
	Add-OutputBoxLine "Opening Place to add to AzureAD"
	Start-Process ms-settings:workplace
}
#██████╗░███╗░░██╗░██████╗  ░░░░██╗  ██████╗░░█████╗░███╗░░░███╗░█████╗░██╗███╗░░██╗
#██╔══██╗████╗░██║██╔════╝  ░░░██╔╝  ██╔══██╗██╔══██╗████╗░████║██╔══██╗██║████╗░██║
#██║░░██║██╔██╗██║╚█████╗░  ░░██╔╝░  ██║░░██║██║░░██║██╔████╔██║███████║██║██╔██╗██║
#██║░░██║██║╚████║░╚═══██╗  ░██╔╝░░  ██║░░██║██║░░██║██║╚██╔╝██║██╔══██║██║██║╚████║
#██████╔╝██║░╚███║██████╔╝  ██╔╝░░░  ██████╔╝╚█████╔╝██║░╚═╝░██║██║░░██║██║██║░╚███║
#╚═════╝░╚═╝░░╚══╝╚═════╝░  ╚═╝░░░░  ╚═════╝░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝
function Set-DNSAndDomain
{
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]$DNSServer,
		[Parameter(Mandatory = $true,
				   Position = 1)]
		[string]$DomainServer
	)
	
	$array = Get-DnsClientServerAddress
	Add-OutputBoxLine "Changing DNS Server to saved Server IP..."
	foreach ($element in $array)
	{
		Set-DnsClientServerAddress -InterfaceIndex $($element).InterfaceIndex -ServerAddresses $DNSServer
	}
	[System.Windows.MessageBox]::Show('Be aware to open the tunnel and be on TSMLab before the next step')
	Add-OutputBoxLine "Attempting to add to domain, please add credentials..."
	$adminuser = Get-Credential
	Add-Computer -Credential $adminuser -DomainName $DomainServer
	Add-OutputBoxLine "Resetting DNS Server config..."
	[System.Windows.MessageBox]::Show('Okay now close the tunnel.')
	foreach ($element in $array)
	{
		Set-DnsClientServerAddress -InterfaceIndex $($element).InterfaceIndex -ResetServerAddresses
	}
	#Now Change PC name
	[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
	$title = 'New PC Name'
	$msg = 'Enter new PC Name:'
	$text = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
	Rename-Computer -NewName $text -DomainCredential $adminuser
}
#██████╗░██╗░░░░░░█████╗░░█████╗░████████╗░██╗░░░░░░░██╗░█████╗░██████╗░███████╗
#██╔══██╗██║░░░░░██╔══██╗██╔══██╗╚══██╔══╝░██║░░██╗░░██║██╔══██╗██╔══██╗██╔════╝
#██████╦╝██║░░░░░██║░░██║███████║░░░██║░░░░╚██╗████╗██╔╝███████║██████╔╝█████╗░░
#██╔══██╗██║░░░░░██║░░██║██╔══██║░░░██║░░░░░████╔═████║░██╔══██║██╔══██╗██╔══╝░░
#██████╦╝███████╗╚█████╔╝██║░░██║░░░██║░░░░░╚██╔╝░╚██╔╝░██║░░██║██║░░██║███████╗
#╚═════╝░╚══════╝░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

Set-InstallStartupDirectory
Import-Module -DisableNameChecking .\"remove-uwp-appx.psm1"
Import-Module -DisableNameChecking .\"title-templates.psm1"
Set-Location ..\

function Remove-BloatwareAppsList() { # yoink'd outta https://github.com/LeDragoX/Win-Debloat-Tools
    $Apps = @(
        # Default Windows 10+ apps
        #"Microsoft.3DBuilder"                    # 3D Builder
        "Microsoft.549981C3F5F10"                # Cortana
        #"Microsoft.Appconnector"
        #"Microsoft.BingFinance"                  # Finance
        #"Microsoft.BingFoodAndDrink"             # Food And Drink
        #"Microsoft.BingHealthAndFitness"         # Health And Fitness
        #"Microsoft.BingNews"                     # News
        #"Microsoft.BingSports"                   # Sports
        #"Microsoft.BingTranslator"               # Translator
        #"Microsoft.BingTravel"                   # Travel
        #"Microsoft.BingWeather"                  # Weather
        #"Microsoft.CommsPhone"
        "Microsoft.ConnectivityStore"
        #"Microsoft.GetHelp"
        #"Microsoft.Getstarted"
        #"Microsoft.Messaging"
        #"Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftPowerBIForWindows"
        #"Microsoft.MicrosoftSolitaireCollection" # MS Solitaire
        "Microsoft.MixedReality.Portal"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.Office.OneNote"               # MS Office One Note
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.People"                       # People
        #"Microsoft.MSPaint"                      # Paint 3D
        #"Microsoft.Print3D"                      # Print 3D
        "Microsoft.SkypeApp"                     # Skype (Who still uses Skype? Use Discord)
        "Microsoft.Todos"                        # Microsoft To Do
        #"Microsoft.Wallet"
        #"Microsoft.Whiteboard"                   # Microsoft Whiteboard
        #"Microsoft.WindowsAlarms"                # Alarms
        #"microsoft.windowscommunicationsapps"
        #"Microsoft.WindowsMaps"                  # Maps
        #"Microsoft.WindowsPhone"
        #"Microsoft.WindowsReadingList"
        #"Microsoft.WindowsSoundRecorder"         # Windows Sound Recorder
        "Microsoft.XboxApp"                      # Xbox Console Companion (Replaced by new App)
        #"Microsoft.YourPhone"                    # Your Phone
        "Microsoft.ZuneMusic"                    # Groove Music / (New) Windows Media Player
        "Microsoft.ZuneVideo"                    # Movies & TV

        # Default Windows 11 apps
        #"MicrosoftWindows.Client.WebExperience"  # Taskbar Widgets
        #"MicrosoftTeams"                         # Microsoft Teams / Preview

        # 3rd party Apps
        "*ACGMediaPlayer*"
        "*ActiproSoftwareLLC*"
        "*AdobePhotoshopExpress*"                # Adobe Photoshop Express
        "*Amazon.com.Amazon*"                    # Amazon Shop
        "*Asphalt8Airborne*"                     # Asphalt 8 Airbone
        "*AutodeskSketchBook*"
        "*BubbleWitch3Saga*"                     # Bubble Witch 3 Saga
        "*CaesarsSlotsFreeCasino*"
        "*CandyCrush*"                           # Candy Crush
        "*COOKINGFEVER*"
        "*CyberLinkMediaSuiteEssentials*"
        "*DisneyMagicKingdoms*"
        "*Dolby*"                                # Dolby Products (Like Atmos)
        "*DrawboardPDF*"
        "*Duolingo-LearnLanguagesforFree*"       # Duolingo
        "*EclipseManager*"
        "*Facebook*"                             # Facebook
        "*FarmVille2CountryEscape*"
        "*FitbitCoach*"
        "*Flipboard*"                            # Flipboard
        "*HiddenCity*"
        "*Hulu*"
        "*iHeartRadio*"
        "*Keeper*"
        "*LinkedInforWindows*"
        "*MarchofEmpires*"
        "*NYTCrossword*"
        "*OneCalendar*"
        "*PandoraMediaInc*"
        "*PhototasticCollage*"
        "*PicsArt-PhotoStudio*"
        "*Plex*"                                 # Plex
        "*PolarrPhotoEditorAcademicEdition*"
        "*RoyalRevolt*"                          # Royal Revolt
        "*Shazam*"
        "*Sidia.LiveWallpaper*"                  # Live Wallpaper
        "*SlingTV*"
        "*Speed Test*"
        "*Sway*"
        "*TuneInRadio*"
        "*Twitter*"                              # Twitter
        "*Viber*"
        "*WinZipUniversal*"
        "*Wunderlist*"
        "*XING*"

        # Apps which other apps depend on
        #"Microsoft.Advertising.Xaml"

        # SAMSUNG Bloat
        #"SAMSUNGELECTRONICSCO.LTD.SamsungSettings1.2"          # Allow user to Tweak some hardware settings
        "SAMSUNGELECTRONICSCO.LTD.1412377A9806A"
        "SAMSUNGELECTRONICSCO.LTD.NewVoiceNote"
        "SAMSUNGELECTRONICSCoLtd.SamsungNotes"
        "SAMSUNGELECTRONICSCoLtd.SamsungFlux"
        "SAMSUNGELECTRONICSCO.LTD.StudioPlus"
        "SAMSUNGELECTRONICSCO.LTD.SamsungWelcome"
        "SAMSUNGELECTRONICSCO.LTD.SamsungUpdate"
        "SAMSUNGELECTRONICSCO.LTD.SamsungSecurity1.2"
        "SAMSUNGELECTRONICSCO.LTD.SamsungScreenRecording"
        #"SAMSUNGELECTRONICSCO.LTD.SamsungRecovery"             # Used to Factory Reset
        "SAMSUNGELECTRONICSCO.LTD.SamsungQuickSearch"
        "SAMSUNGELECTRONICSCO.LTD.SamsungPCCleaner"
        "SAMSUNGELECTRONICSCO.LTD.SamsungCloudBluetoothSync"
        "SAMSUNGELECTRONICSCO.LTD.PCGallery"
        "SAMSUNGELECTRONICSCO.LTD.OnlineSupportSService"
        "4AE8B7C2.BOOKING.COMPARTNERAPPSAMSUNGEDITION"

        # <==========[ DIY ]==========> (Remove the # to Uninstall)

        # [DIY] Default apps i'll keep

        #"Microsoft.FreshPaint"             # Paint
        #"Microsoft.MicrosoftEdge"          # Microsoft Edge
        #"Microsoft.MicrosoftStickyNotes"   # Sticky Notes
        #"Microsoft.WindowsCalculator"      # Calculator
        #"Microsoft.WindowsCamera"          # Camera
        #"Microsoft.ScreenSketch"           # Snip and Sketch (now called Snipping tool, replaces the Win32 version in clean installs)
        #"Microsoft.WindowsFeedbackHub"     # Feedback Hub
        #"Microsoft.Windows.Photos"         # Photos

        # [DIY] Common Streaming services

        "*Netflix*"                        # Netflix
        "*SpotifyMusic*"                   # Spotify

        # [DIY] Can't be reinstalled

        #"Microsoft.WindowsStore"           # Windows Store

        # Apps which cannot be removed using Remove-AppxPackage
        #"Microsoft.BioEnrollment"
        #"Microsoft.WindowsFeedback"        # Feedback Module
        #"Windows.ContactSupport"
    )

    # Write-Title -Text "Remove Bloatware Apps"
    # Write-Section -Text "Removing Windows unneeded Apps"
    Remove-UWPAppx -AppxPackages $Apps
}


#██████╗░██████╗░██╗██╗░░░██╗░█████╗░░█████╗░██╗░░░██╗░░░
#██╔══██╗██╔══██╗██║██║░░░██║██╔══██╗██╔══██╗╚██╗░██╔╝░░░
#██████╔╝██████╔╝██║╚██╗░██╔╝███████║██║░░╚═╝░╚████╔╝░░░░
#██╔═══╝░██╔══██╗██║░╚████╔╝░██╔══██║██║░░██╗░░╚██╔╝░░░░░
#██║░░░░░██║░░██║██║░░╚██╔╝░░██║░░██║╚█████╔╝░░░██║░░░██╗
#╚═╝░░░░░╚═╝░░╚═╝╚═╝░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝
#This uses a script from the powershell gallery to set privacy settings.
function Set-PrivacySettings {
	Set-InstallStartupDirectory
	Set-Location ..\
	Start-Process powershell -ArgumentList "-f .\Set-Privacy.ps1 -Balanced"
	Start-Process powershell -ArgumentList "-f .\Set-Privacy.ps1 -enable -features Location,Radios,PhishingFilter"
	[System.Windows.MessageBox]::Show('Privacy Settings Set.')
}
#███████╗░█████╗░░██████╗░██╗░░░░░███████╗░██████╗░█████╗░███████╗████████╗
#██╔════╝██╔══██╗██╔════╝░██║░░░░░██╔════╝██╔════╝██╔══██╗██╔════╝╚══██╔══╝
#█████╗░░███████║██║░░██╗░██║░░░░░█████╗░░╚█████╗░██║░░██║█████╗░░░░░██║░░░
#██╔══╝░░██╔══██║██║░░╚██╗██║░░░░░██╔══╝░░░╚═══██╗██║░░██║██╔══╝░░░░░██║░░░
#███████╗██║░░██║╚██████╔╝███████╗███████╗██████╔╝╚█████╔╝██║░░░░░░░░██║░░░
#╚══════╝╚═╝░░╚═╝░╚═════╝░╚══════╝╚══════╝╚═════╝░░╚════╝░╚═╝░░░░░░░░╚═╝░░░
function Install-EagleSoft {
	Get-TempFolder
	Add-OutputBoxLine "Installing Eaglesoft..."
	$EaglesoftLocation = "\\mcfdm-file\Eaglesoft\ESInstall\Media"
	$EaglesoftTest = Test-Path -Path $EaglesoftLocation
	Do { #This is just a loop to keep going as long as it can't see the eaglesoft folder, in case someone forgot the tunnel so you don't just have it fail.
		Add-OutputBoxLine "Trying to connect to Eaglesoft folder, please make sure the tunnel is open..."
		Start-Sleep 3
	} while (-not $EaglesoftTest)
	Set-Location $EaglesoftLocation
	Add-OutputBoxLine "YOU WILL NEED THE EAGLESOFT LICENSE KEY!"
	Add-OutputBoxLine "THIS IS IN ITPORTAL."
	Start-Process essetup.exe -verb runas -wait
}
#░█████╗░██████╗░██╗░░██╗
#██╔══██╗██╔══██╗██║░██╔╝
#██║░░╚═╝██║░░██║█████═╝░
#██║░░██╗██║░░██║██╔═██╗░
#╚█████╔╝██████╔╝██║░╚██╗
#░╚════╝░╚═════╝░╚═╝░░╚═╝
function Install-CDK {
	Get-TempFolder
	Add-OutputBoxLine "Installing .NET 3.5 so CDK won't complain..."
	Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3"
	Add-OutputBoxLine "Attempting to Static this PC for CDK install."
	Do { #This loop will continuously make up Lab-usable IPs until it can't find anything on that IP.
		#Once it can't find anything on that IP, we can static with it.
		$Octet4 = Get-Random -Minimum 200 -Maximum 240 #choose a random number between 200 and 240
		$script:testip = -join("10.120.3.", $Octet4) #create an IP with this following the lab's convention
		Add-OutputBoxLine "Testing Static IP:"
		Start-Sleep 5 #Wait a few seconds to identify the network.
		Add-OutputBoxLine $script:testip
		Set-StaticIP -ip $script:testip -gateway "10.5.190.127" # Set IP to pre-created IP, set gateway to the gateway at RHF
		if (Test-NetConnection 1.1.1.1 -eq true) { #If the computer can still access the internet,
			Add-OutputBoxLine "Test successful, IP address set and connectivity confirmed."
			$iptest = $false #Mark this as false so we can stop the loop
		} else { #If it can't access the internet,
			Add-OutputBoxLine "Test unsuccessful, IP Address set incorrectly, or computer has no internet otherwise."
			$iptest = $true #Keep it true so we can try a new IP.
		}
	} While ($iptest -eq $true)
	$output = "PC has been static'd to " + $script:testip
	Add-OutputBoxLine $output
	Add-OutputBoxLine "Trying to install CDK, no idea if this works"
	# ok let's try it
	Set-InstallStartupDirectory
	Get-TempFolder #This makes sure our custom Temp folder exists
	Set-Location ".\RayHaskell" #Go into the RHF folder
	Copy-Item ".\CDK_INSTALLER.zip" "C:\Temp\CDK_INSTALLER.zip" #Copy CDK to the temp folder
	Set-Location "C:\Temp"
	Expand-Archive -Path ".\CDK_INSTALLER.zip" -DestinationPath "C:\Temp" #Open the CDK .zip folder
	Remove-Item "C:\Temp\CDK_INSTALLER.zip" #Remove the .zip when we're done
	Set-Location ".\WSPCP_EXP" #Go into the folder that was in the .zip
	Start-Process ".\StartInstaller.exe" -wait #Start the CDK installer.
}
#░██╗░░░░░░░██╗███████╗██████╗░██████╗░░█████╗░░█████╗░████████╗
#░██║░░██╗░░██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
#░╚██╗████╗██╔╝█████╗░░██████╦╝██████╔╝██║░░██║██║░░██║░░░██║░░░
#░░████╔═████║░██╔══╝░░██╔══██╗██╔══██╗██║░░██║██║░░██║░░░██║░░░
#░░╚██╔╝░╚██╔╝░███████╗██████╦╝██║░░██║╚█████╔╝╚█████╔╝░░░██║░░░
#░░░╚═╝░░░╚═╝░░╚══════╝╚═════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░░░░╚═╝░░░
#Update Info:
#This install should not need to be updated, but if so, replace wsasme.msi
<#function Install-Webroot
{
	Param
	(
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$key
	)
	Set-InstallStartupDirectory
	$WRArguments = -join ("/package wsasme.msi GUILIC=", $Key, " /qn")
	$outputwr1 = -join ("Starting Webroot Install for client:", $x, "...")
	Add-OutputBoxLine $outputwr1
	Start-Process msiexec -Wait -ArgumentList $WRArguments
	Add-OutputBoxLine "Webroot install completed."
	
	# echo msiexec /i wsasme.msi GUILIC=$key CMDLINE=SME,quiet /qn /l*v install.log
	# echo Install Webroot with Key $key
}#>
function Install-Webroot
{
	# Define the function parameters
	Param
	(
		# The Webroot license key
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$key
	)
	
	# Set the installation directory
	Set-InstallStartupDirectory
	
	# Create the argument string for the msiexec program
	$WRArguments = "/package wsasme.msi GUILIC=$key /qn"
	
	# Display a message indicating that the installation is starting
	$outputwr1 = "Starting Webroot Install for client: $x..."
	Add-OutputBoxLine $outputwr1
	
	# Launch the msiexec program and wait for it to complete
	try
	{
		Start-Process msiexec -Wait -ArgumentList $WRArguments
		
		# Display a message indicating that the installation has completed
		Add-OutputBoxLine "Webroot install completed."
	}
	catch
	{
		# Display an error message if the installation fails
		Add-OutputBoxLine "Webroot installation failed. Error: $($_.Exception.Message)"
	}
}

<# Here is the "atera check" system
#░█████╗░████████╗███████╗██████╗░░█████╗░  ░█████╗░██╗░░██╗███████╗░█████╗░██╗░░██╗░░░
#██╔══██╗╚══██╔══╝██╔════╝██╔══██╗██╔══██╗  ██╔══██╗██║░░██║██╔════╝██╔══██╗██║░██╔╝░░░
#███████║░░░██║░░░█████╗░░██████╔╝███████║  ██║░░╚═╝███████║█████╗░░██║░░╚═╝█████═╝░░░░
#██╔══██║░░░██║░░░██╔══╝░░██╔══██╗██╔══██║  ██║░░██╗██╔══██║██╔══╝░░██║░░██╗██╔═██╗░░░░
#██║░░██║░░░██║░░░███████╗██║░░██║██║░░██║  ╚█████╔╝██║░░██║███████╗╚█████╔╝██║░╚██╗██╗
#╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝  ░╚════╝░╚═╝░░╚═╝╚══════╝░╚════╝░╚═╝░░╚═╝╚═╝
#>
function Get-AteraCheck {
	[CmdletBinding()]
	param (
		[Parameter()]
		[String]
		$Client
	)
	$isit = Get-SerialStatus $Client
	if ($true -eq $isit) {
		$serial = Get-WMIObject win32_bios | Select-Object serialnumber
		[string[]] $serialkey = ($serial | Out-String -Stream) -ne '' | Select-Object -Skip 2 #For some reason this is also a hash table so you know the drill.
		[System.Windows.MessageBox]::Show("This PC already exists in Atera, please remove it before continuing, search $serialkey")
	} else {
		Write-Host "Machine does not exist in Atera."
	}
}
function Get-SerialStatus {
	Param 
	(
		[Parameter(Mandatory = $true,
				   Position = 0)]
		[string]$API
	)
	$CurPC = Get-WMIObject win32_bios | Select-Object serialnumber #Grab Current Serial
	[string[]] $RealCurPC = ($CurPC | Out-String -Stream) -ne '' | Select-Object -Skip 2 #For some reason this is also a hash table so you know the drill.
	$script:thejson = "https://app.atera.com/api/v3/agents/customer/$API" #Set our Atera JSON Link
	$AteraAPI = Invoke-RestMethod -Uri $thejson -Headers @{'X-API-KEY' = '7d4f2a9bb8dd4bf8bd28bd59f3f2e0bd'} -Method GET #Grab Atera JSON for X customer
	Write-Host "Setting Json"
	While($AteraAPI.page -le $AteraAPI.totalPages) {
		Write-Host "Loop Started"
		Write-Host "Grabbing Json"
    	$AteraAPI = Invoke-RestMethod -Uri $thejson -Headers @{'X-API-KEY' = '7d4f2a9bb8dd4bf8bd28bd59f3f2e0bd'} -Method GET
		Write-Host "Creating hash table"
  		$SerialKeyHash = $AteraAPI.items | Select-Object 'VendorSerialNumber' #Grab the table for Serial Keys as a Hash Table
		write-host "converting hash table"
  		[string[]] $AteraSK = ($SerialKeyHash | Out-String -Stream) -ne '' | Select-Object -Skip 2 #Convert Hash Table to Array
		write-host "starting for each loop"
  		foreach ($element in $AteraSK) { #Sift through each entry in the array
			write-host "looking at $element"
			write-host $element
			write-host $RealCurPC
			$deviceexists = $false
	    	if ($element -eq $RealCurPC) {
				Write-Warning "Device exists in Atera."
				$Script:DeviceExists = $true
    		}
			if ($true -eq $deviceexists) {
				return $true
			}
  		}
		$page = [int]$AteraAPI.page
		Write-host "Reading page $page"
		$totalpage = [int]$AteraAPI.totalpages
		write-host "of $totalpage"
  		if ($page -eq $totalpage) {
		    Write-Host "End of Devices."
	    	Return
  		} elseif ($null -eq $AteraAPI.nextLink) {
			Write-Host "End of Devices."
			Return
		}
	    Write-Host "Grabbing Next Page of Devices..."
	    $global:thejson = $AteraAPI.nextLink
	}
}
#░█████╗░████████╗███████╗██████╗░░█████╗░
#██╔══██╗╚══██╔══╝██╔════╝██╔══██╗██╔══██╗
#███████║░░░██║░░░█████╗░░██████╔╝███████║
#██╔══██║░░░██║░░░██╔══╝░░██╔══██╗██╔══██║
#██║░░██║░░░██║░░░███████╗██║░░██║██║░░██║
#Update Info:
#This literally pulls a fresh installer every time.
#Updates not required.
<#function Install-Atera
{
	Param
	(
		[Parameter(Mandatory = $true, Position = 0)]
		[object]$ClientID
	)
	#Get-AteraCheck $ClientID
	Add-OutputBoxLine "Creating Temp folder in C:\Temp"
	Get-TempFolder
	Add-OutputBoxLine "Downloading Atera Installer..."
	$webrequest = -join ("https://tsmaine.servicedesk.atera.com/GetAgent/Msi/?customerId=", $ClientID, "&integratorLogin=jbard%40techsolutionsme.com")
	#--------------------------------------
	# This link uses my login, so if I ever leave someone needs to change this to someone else's login.
	#--------------------------------------
	Invoke-WebRequest -Uri $webrequest -Outfile C:\Temp\Atera.msi
	Set-Location C:\Temp
	Add-OutputBoxLine "Atera Downloaded (If you have internet,) now installing, please select Yes"
	Start-Process msiexec -Wait -ArgumentList "/i Atera.msi"
	Add-OutputBoxLine "Atera Installed"
}#>
function Install-Atera
{
	# Define the function parameters
	Param
	(
		# The ID of the client for whom Atera is being installed
		[Parameter(Mandatory = $true, Position = 0)]
		[object]$ClientID
	)
	
	if($null -eq $ClientID){
		[System.Windows.MessageBox]::Show("Hey there's no ClientID in this Atera install which means I did an uh oh whoopsie. Tell me who I whoopsie'd on.")
		break
	}

	# Create the temporary folder for the Atera installer
	Add-OutputBoxLine "Creating Temp folder in C:\Temp"
	Get-TempFolder
	
	# Download the Atera installer from the specified URL
	Add-OutputBoxLine "Downloading Atera Installer..."
	$ateraDownloadUrl = "https://tsmaine.servicedesk.atera.com/GetAgent/Msi/?customerId=$ClientID&integratorLogin=jbard%40techsolutionsme.com"
	Invoke-WebRequest -Uri $ateraDownloadUrl -Outfile C:\Temp\Atera.msi
	
	# Change the current directory to the temporary folder
	Set-Location C:\Temp
	
	# Install Atera using the downloaded installer
	try
	{
		Add-OutputBoxLine "Atera Downloaded (If you have internet,) now installing, please select Yes"
		Start-Process msiexec -Wait -ArgumentList "/i Atera.msi"
		Add-OutputBoxLine "Atera Installed"
	}
	catch
	{
		# Display an error message if the installation fails
		Add-OutputBoxLine "Atera installation failed. Error: $($_.Exception.Message)"
	}
}
#███████╗██████╗░██╗░█████╗░░█████╗░██████╗░
#██╔════╝██╔══██╗██║██╔══██╗██╔══██╗██╔══██╗
#█████╗░░██████╔╝██║██║░░╚═╝██║░░██║██████╔╝
#██╔══╝░░██╔═══╝░██║██║░░██╗██║░░██║██╔══██╗
#███████╗██║░░░░░██║╚█████╔╝╚█████╔╝██║░░██║
#╚══════╝╚═╝░░░░░╚═╝░╚════╝░░╚════╝░╚═╝░░╚═╝
#Update Info:
#I did name these off their versions didn't I.
#If you feel lazy just replace the correct setup executables.
<#function Install-Epicor
{
	Param
	(
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$epicor
	)
	Set-Location $working
	if ($epicor -eq "WB")
	{
		# If WB Install Epicor v31
		Add-OutputBoxLine "Installing Epicor v31 for Ware Butler..."
		Set-Location .\InstallData\WareButler
		Start-Process "setup_31.exe" -wait
		Add-OutputBoxLine "Epicor v31 Installed."
	}
	elseif ($epicor -eq "Campbells")
	{
		# If Campbells Install Epicor V30
		Add-OutputBoxLine "Installing Epicor v30 for Campbells..."
		Set-Location .\InstallData\Campbells
		Start-Process "setup_30.exe" -wait
		Add-OutputBoxLine "Epicor v30 Installed."
	}
	else
	{
		# If anything else. Well, How did I get here?       
		#ℒℰ𝒯𝒯ℐ𝒩𝒢 𝒯ℋℰ 𝒟𝒜𝒴𝒮 𝒢𝒪 ℬ𝒴
		function popUp($text, $title)
		{
			$a = new-object -comobject wscript.shell
			_$b = $a.popup($text, 0, $title, 0)
		}
		popUp "Epicor tried to install with unrecognised client" "Error"
	}
}#>
function Install-Epicor
{
	# Define the function parameters
	Param
	(
		# The client for whom Epicor is being installed
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$epicor
	)
	
	# Change the current directory to the installation folder
	Set-Location $working
	
	# Check the value of the $epicor variable and install the appropriate version of Epicor
	switch ($epicor)
	{
		"WB"
		{
			# If WB Install Epicor v31
			Add-OutputBoxLine "Installing Epicor v31 for either Ware Butler or Harris Lumber..."
			Set-Location .\InstallData\WareButler
			Start-Process "setup_31.exe" -wait
			Add-OutputBoxLine "Epicor v31 Installed."
		}
		"Campbells"
		{
			# If Campbells Install Epicor V30
			Add-OutputBoxLine "Installing Epicor v30 for Campbells..."
			Set-Location .\InstallData\Campbells
			Start-Process "setup_30.exe" -wait
			Add-OutputBoxLine "Epicor v30 Installed."
		}
		default
		{
			# If anything else, display an error message
			Write-Error "Epicor tried to install with unrecognized client"
		}
	}
	<#
	if ($epicor -eq ("WB" -or "Campbells")) {
		if (test-path("where the installer ends up on a fuckup")) { # Here: C:\3apps\software\cursoft\eagleclient-31.0247.039\fsetup.exe
			run that installer
		}
	}
	#>
}

#░█████╗░░█████╗░███╗░░░███╗██████╗░░█████╗░░██████╗░██████╗
#██╔══██╗██╔══██╗████╗░████║██╔══██╗██╔══██╗██╔════╝██╔════╝
#██║░░╚═╝██║░░██║██╔████╔██║██████╔╝███████║╚█████╗░╚█████╗░
#██║░░██╗██║░░██║██║╚██╔╝██║██╔═══╝░██╔══██║░╚═══██╗░╚═══██╗
#╚█████╔╝╚█████╔╝██║░╚═╝░██║██║░░░░░██║░░██║██████╔╝██████╔╝
#░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░░░░╚═╝░░╚═╝╚═════╝░╚═════╝░
function Install-Compass {
	Add-OutputBoxLine "Installing Compass for Epicor..."
	Set-Location $working
	Set-Location .\InstallData\Harris
	Add-OutputBoxLine "Defaults are fine, just make sure to set all 3 IPs to the Epicor Server."
	Start-Process "CompassInstaller.exe" -Wait
	Add-OutputBoxLine "Compass for Epicor installed."
}
#██████╗░░█████╗░░██╗░░░░░░░██╗███████╗██████╗░  ░██████╗███████╗████████╗████████╗██╗███╗░░██╗░██████╗░░██████╗
#██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝██╔══██╗  ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗░██║██╔════╝░██╔════╝
#██████╔╝██║░░██║░╚██╗████╗██╔╝█████╗░░██████╔╝  ╚█████╗░█████╗░░░░░██║░░░░░░██║░░░██║██╔██╗██║██║░░██╗░╚█████╗░
#██╔═══╝░██║░░██║░░████╔═████║░██╔══╝░░██╔══██╗  ░╚═══██╗██╔══╝░░░░░██║░░░░░░██║░░░██║██║╚████║██║░░╚██╗░╚═══██╗
#██║░░░░░╚█████╔╝░░╚██╔╝░╚██╔╝░███████╗██║░░██║  ██████╔╝███████╗░░░██║░░░░░░██║░░░██║██║░╚███║╚██████╔╝██████╔╝
#╚═╝░░░░░░╚════╝░░░░╚═╝░░░╚═╝░░╚══════╝╚═╝░░╚═╝  ╚═════╝░╚══════╝░░░╚═╝░░░░░░╚═╝░░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═════╝░
function Get-PowerSettingChanges
{
	Set-InstallStartupDirectory
	Add-OutputBoxLine "Changing Power Settings Via Batch Script..."
	powershell -command "Start-Process PowerSettings.bat -Verb runas"
}
#███╗░░██╗███████╗████████╗  ███████╗██╗░░██╗████████╗███████╗███╗░░██╗██████╗░███████╗██████╗░
#████╗░██║██╔════╝╚══██╔══╝  ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝████╗░██║██╔══██╗██╔════╝██╔══██╗
#██╔██╗██║█████╗░░░░░██║░░░  █████╗░░░╚███╔╝░░░░██║░░░█████╗░░██╔██╗██║██║░░██║█████╗░░██████╔╝
#██║╚████║██╔══╝░░░░░██║░░░  ██╔══╝░░░██╔██╗░░░░██║░░░██╔══╝░░██║╚████║██║░░██║██╔══╝░░██╔══██╗
#██║░╚███║███████╗░░░██║░░░  ███████╗██╔╝╚██╗░░░██║░░░███████╗██║░╚███║██████╔╝███████╗██║░░██║
#╚═╝░░╚══╝╚══════╝░░░╚═╝░░░  ╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚══╝╚═════╝░╚══════╝╚═╝░░╚═╝
#Update Info:
#This will pull a NetExtender .msi from the script's github page.
function Install-NetEx
{
	Add-OutputBoxLine "Checking if Temp Folder exists in C:\Temp"
	Get-TempFolder
	Add-OutputBoxLine "Downloading Net Extender Installer..."
	$webrequest = "https://github.com/S1lvr/PowershellSetupTool/raw/main/InstallData/NetEx.MSI"
	#--------------------------------------
	# This link uses my login, so if I ever leave someone needs to change this to someone else's login.
	#--------------------------------------
	Invoke-WebRequest -Uri $webrequest -Outfile C:\Temp\NetEx.msi
	Add-OutputBoxLine "Net Extender downloaded, now installing"
	Start-Process msiexec -Wait -ArgumentList "/package NetEx.msi /qn /norestart"
	Add-OutputBoxLine "Net Extender Installed."
}
#░█████╗░██╗░░██╗██████╗░░█████╗░███╗░░░███╗███████╗
#██╔══██╗██║░░██║██╔══██╗██╔══██╗████╗░████║██╔════╝
#██║░░╚═╝███████║██████╔╝██║░░██║██╔████╔██║█████╗░░
#██║░░██╗██╔══██║██╔══██╗██║░░██║██║╚██╔╝██║██╔══╝░░
#╚█████╔╝██║░░██║██║░░██║╚█████╔╝██║░╚═╝░██║███████╗
#░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚═╝╚══════╝
#Update Info:
#Chrome will auto update, this is not necessary.
function Install-GChrome
{
	Set-InstallStartupDirectory
	Add-OutputBoxLine "Installing Chrome..."
	$chromeargs = @(
		"/silent"
		"/install"
	)
	Start-Process chromestandalonesetup64.exe -Wait -Argumentlist $chromeargs
	Add-OutputBoxLine "Chrome Installed."
	Set-InstallStartupDirectory
	Start-Process SetDefaultBrowser -Wait -ArgumentList "chrome"
}
#███████╗██╗██████╗░███████╗███████╗░█████╗░██╗░░██╗
#██╔════╝██║██╔══██╗██╔════╝██╔════╝██╔══██╗╚██╗██╔╝
#█████╗░░██║██████╔╝█████╗░░█████╗░░██║░░██║░╚███╔╝░
#██╔══╝░░██║██╔══██╗██╔══╝░░██╔══╝░░██║░░██║░██╔██╗░
#██║░░░░░██║██║░░██║███████╗██║░░░░░╚█████╔╝██╔╝╚██╗
#╚═╝░░░░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝
#Here's a download link https://download-installer.cdn.mozilla.net/pub/firefox/releases/107.0.1/win64/en-US/Firefox%20Setup%20107.0.1.msi
#░█████╗░███████╗███████╗██╗░█████╗░███████╗
#██╔══██╗██╔════╝██╔════╝██║██╔══██╗██╔════╝
#██║░░██║█████╗░░█████╗░░██║██║░░╚═╝█████╗░░
#██║░░██║██╔══╝░░██╔══╝░░██║██║░░██╗██╔══╝░░
#╚█████╔╝██║░░░░░██║░░░░░██║╚█████╔╝███████╗
#░╚════╝░╚═╝░░░░░╚═╝░░░░░╚═╝░╚════╝░╚══════╝
#Update Info:
#Office grabs it's files over the internet, no update needed
function Install-OfficeInstaller
{
	Set-InstallStartupDirectory
	Add-OutputBoxLine "Installing Office, please follow the prompts."
	Start-Process OfficeSetup.exe -Wait
	Add-OutputBoxLine "Office Installed, Probably."
}
#██████╗░███████╗░█████╗░██████╗░███████╗██████╗░
#██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
#██████╔╝█████╗░░███████║██║░░██║█████╗░░██████╔╝
#██╔══██╗██╔══╝░░██╔══██║██║░░██║██╔══╝░░██╔══██╗
#██║░░██║███████╗██║░░██║██████╔╝███████╗██║░░██║
#╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░╚══════╝╚═╝░░╚═╝
#Update Info:
#Downloads an installer every time, no need to udpate.
function Install-Reader
{
	Set-InstallStartupDirectory
	Copy-Item .\Reader.exe -Destination .\ReaderCopy.exe
	Add-OutputBoxLine "Installing Reader, please follow the prompts."
	Start-Process ReaderCopy.exe -Wait
	Add-OutputBoxLine "Reader Installed."
}
#██████╗░███████╗███╗░░██╗░█████╗░███╗░░░███╗███████╗
#██╔══██╗██╔════╝████╗░██║██╔══██╗████╗░████║██╔════╝
#██████╔╝█████╗░░██╔██╗██║███████║██╔████╔██║█████╗░░
#██╔══██╗██╔══╝░░██║╚████║██╔══██║██║╚██╔╝██║██╔══╝░░
#██║░░██║███████╗██║░╚███║██║░░██║██║░╚═╝░██║███████╗
#╚═╝░░╚═╝╚══════╝╚═╝░░╚══╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝
function Set-NewPCName
{
	[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
	$title = 'New PC Name'
	$msg = 'Enter new PC Name:'
	$text = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
	Rename-Computer -NewName $text
	Add-OutputBoxLine "Renamed PC to $text, please restart to finalize change."
	Add-OutputBoxLine "Be aware once Atera installs splashtop will have the old name."
	Add-OutputBoxLine "Please launch splashtop as admin and change the PC name to the correct name."
}
# --------------------------------------------------------------------------------------------------
#░██████╗░██╗░░░██╗██╗  ░█████╗░░█████╗░██████╗░███████╗
#██╔════╝░██║░░░██║██║  ██╔══██╗██╔══██╗██╔══██╗██╔════╝
#██║░░██╗░██║░░░██║██║  ██║░░╚═╝██║░░██║██║░░██║█████╗░░
#██║░░╚██╗██║░░░██║██║  ██║░░██╗██║░░██║██║░░██║██╔══╝░░
#╚██████╔╝╚██████╔╝██║  ╚█████╔╝╚█████╔╝██████╔╝███████╗
#░╚═════╝░░╚═════╝░╚═╝  ░╚════╝░░╚════╝░╚═════╝░╚══════╝
# --------------------------------------------------------------------------------------------------
# First section makes the script make a variable for the folder it's in.
# All code for configuration of the machine needs to be above this.
$workfolder = $MyInvocation.MyCommand.Path
$myname = $MyInvocation.MyCommand.Name
$pos = $workfolder.IndexOf($myname)
$working = $workfolder.Substring(0, $pos)
#Justin's Automatic Provisioning An N-setup script
#This is all the UI code I stole from Microsoft.
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationFramework
[System.Windows.Forms.Application]::EnableVisualStyles()
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

#Create Main Window
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select a Client'
$form.Size = New-Object System.Drawing.Size(595, 430)
$form.StartPosition = 'CenterScreen'

#Create Tabs
$FormTabControl = New-object System.Windows.Forms.TabControl
$FormTabControl.Size = "540,300"
$FormTabControl.Location = "25,75"
$Form.Controls.Add($FormTabControl)

#Configure Tab1/Setup
$Tab1 = New-object System.Windows.Forms.Tabpage
$Tab1.DataBindings.DefaultDataSourceUpdateMode = 0
$Tab1.UseVisualStyleBackColor = $True
$Tab1.Name = "Tab1"
$Tab1.Text = "Setup"
$FormTabControl.Controls.Add($Tab1)

#Create Ok Button
$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(30, 210)
$okButton.Size = New-Object System.Drawing.Size(75, 23)
$okButton.Text = 'Start'
# $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
# $form.AcceptButton = $okButton
# replace the existing OK button code with this, so the form doesn't close
$okbutton.Add_Click({
	$x = $listBox.SelectedItem.replace(' ', '_')
	$run = -join ("Get-", $x)
	$progressbar1 = New-Object System.Windows.Forms.ProgressBar
	$progressbar1.maximum = 2
	$progressbar1.step = 1
	$progressbar1.value = 1
	$progressbar1.style = "marquee"
	$progressbar1.MarqueeAnimationSpeed = 20
	$progressbar1.location = New-Object System.Drawing.Point(250, 210)
	$progressbar1.size = New-Object System.Drawing.Size(175, 23)
	$Tab1.controls.Add($progressbar1)
	$script:isinstallrunning = $true
	Set-TimeZone -Id "Eastern Standard Time"
	Invoke-Expression $run
}) # Prepends the chosen option with "Get-" so it works as a function name
$okbutton.Cursor = [System.Windows.Forms.Cursors]::Hand
$Tab1.Controls.Add($okButton)

# Create Cancel Button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(105, 210)
$cancelButton.Size = New-Object System.Drawing.Size(75, 23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$tab1.Controls.Add($cancelButton)

# Create Label
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10, 20)
$label.Size = New-Object System.Drawing.Size(280, 20)
$label.Text = 'Please select a Client:'
$tab1.Controls.Add($label)

# Create List Box
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10, 40)
$listBox.Size = New-Object System.Drawing.Size(180, 20)
$listBox.Height = 160

#Create Output Box next
$TextBox = New-Object System.Windows.Forms.TextBox
$TextBox.Multiline = $True;
$TextBox.Location = New-Object System.Drawing.Size(200, 40)
$TextBox.Size = New-Object System.Drawing.Size(310, 160)
$TextBox.Scrollbars = "Vertical"
$TextBox.ReadOnly = $True
$tab1.Controls.Add($TextBox)

#Create method to put text in output box
Function Add-OutputBoxLine
{
	Param ($Message)
	$TextBox.AppendText("`r`n$Message")
	$TextBox.Refresh()
	$TextBox.ScrollToCaret()
}

$directory = Get-ChildItem ".\CustomClients"
foreach ($f in $directory)
{
	Write-Host $f
	$f2 = -join (".\CustomClients\", $f)
	Write-Host $f2
	import-module $f2
	$newfilename = $f -replace ".{4}$"
	$script:clientarray += $newfilename
}

[array]::sort($clientarray) # Sort our Client List, default is alphabetical
$clientarray += "Custom" # Add the Custom Option, as I want it at the bottom.
$TextBox.Text = "Select an option from the left and click Start."
foreach ($element in $clientarray)
{
	[void]$listBox.Items.Add($element)
}
$listBox.add_SelectedIndexChanged(# This whole section here just makes it so you see something in the text box on the right when you click an option
	{
		if ($isinstallrunning -eq $true)
		{
			Write-Host "Install in progress, not changing text box."
		}
		else
		{
			if ($listBox.SelectedItem -eq "Custom") # Hey i also need to nest an "if" to check if an install is active.
			{
				$TextBox.Text = "Starts an install that prompts for each option, for clients that aren't listed. Very WIP."
			}
			else
			{
				$clientname1 = $listBox.SelectedItem.replace('_', ' ')
				$TextBox.Text = -join ("Starts Installation For ", $clientname1)
			}
		}
	}
)
$tab1.Controls.Add($listBox)

#logo :D
$file = (get-item '.\logo.png')
$img = [System.Drawing.Image]::Fromfile($file)
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Image = $img
$pictureBox.SizeMode = "stretch"
$pictureBox.Location = New-Object System.Drawing.Size(20, 10)
$pictureBox.Size = New-Object System.Drawing.Size(60, 60)
$pictureBox.Anchor = "Bottom, left"
$Form.controls.add($pictureBox)

#title!
$file2 = (Get-Item '.\title.png')
$img2 = [System.Drawing.Image]::Fromfile($file2)
$Titlebox = New-Object Windows.Forms.Picturebox
$titlebox.Image = $img2
$titleBox.SizeMode = "stretch"
$Titlebox.Location = New-Object System.Drawing.Point(160, 10)
$Titlebox.Size = New-Object System.Drawing.Size (280, 60)
$Titlebox.Anchor = "Bottom, Left"
$form.Controls.add($Titlebox)

#Create Config Tab
$Tab2 = New-object System.Windows.Forms.Tabpage
$Tab2.DataBindings.DefaultDataSourceUpdateMode = 0
$Tab2.UseVisualStyleBackColor = $True
$Tab2.Name = "Tab2"
$Tab2.Text = "Config"
$FormTabControl.Controls.Add($Tab2)

# Create Label
$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.Point(10, 20)
$label2.Size = New-Object System.Drawing.Size(280, 20)
$label2.Text = 'Run these after logging in as User'
$tab2.Controls.Add($label2)

# Create Defaults Button
$defaultsbutton = New-Object System.Windows.Forms.Button
$defaultsbutton.Location = New-Object System.Drawing.Point(20, 50)
$defaultsbutton.Size = New-Object System.Drawing.Size(175, 23)
$defaultsbutton.Text = 'Set Default Apps'
$tab2.Controls.Add($defaultsbutton)
$defaultsbutton.Add_Click({
	Set-DefaultMail
	Set-DefaultPDF
	Set-ChromeDefault
	[System.Windows.MessageBox]::Show('Default Programs set for Outlook, Adobe Reader, and Chrome')
})

# Create Make Local Admin Button
$LocalAdminButton = New-Object System.Windows.Forms.Button
$LocalAdminButton.Location = New-Object System.Drawing.Point(20, 75)
$LocalAdminButton.Size = New-Object System.Drawing.Size(175, 23)
$LocalAdminButton.Text = 'Make Local Admin'
$tab2.Controls.Add($LocalAdminButton)
$LocalAdminButton.Add_Click({
	$computer = $env:COMPUTERNAME
	$username = (Get-WmiObject -Class win32_process -ComputerName $computer | Where-Object name -Match explorer).getowner().user
	#$username = -join ($env:USERDOMAIN, "\", $env:USERNAME)
	#$username = Get-ChildItem "\\$computer\c$\Users" | Sort-Object LastWriteTime -Descending | Select-Object Name, LastWriteTime -first 1
	# Try the second one if this new one doesn't work
	Add-LocalGroupMember -Group "Administrators" -Member $username
	$message = -join("User ", $username, " added as local admin")
	[System.Windows.MessageBox]::Show($message)
})

# Create Change Privacy Settings Button
$PrivacyButton = New-Object System.Windows.Forms.Button
$PrivacyButton.Location = New-Object System.Drawing.Point(20, 100)
$PrivacyButton.Size = New-Object System.Drawing.Size(175, 23)
$PrivacyButton.Text = 'Set Privacy Settings'
$tab2.Controls.Add($PrivacyButton)
$PrivacyButton.Add_Click({
	Set-PrivacySettings
	[System.Windows.MessageBox]::Show('Privacy Settings have been changed.')
})

#Disable Startups
$StartupsButton = New-Object System.Windows.Forms.Button
$StartupsButton.Location = New-Object System.Drawing.Point(20, 125)
$StartupsButton.Size = New-Object System.Drawing.Size(175, 23)
$StartupsButton.Text = 'Disable Unwanted Startup Items'
$tab2.Controls.Add($StartupsButton)
$StartupsButton.Add_Click({
	Disable-Startups
	[System.Windows.MessageBox]::Show('Startup items have been changed.')
})

#Remove Bloatware
$BloatwareButton = New-Object System.Windows.Forms.Button
$BloatwareButton.Location = New-Object System.Drawing.Point(20, 150)
$BloatwareButton.Size = New-Object System.Drawing.Size(175, 23)
$BloatwareButton.Text = 'Remove Bloatware'
$tab2.Controls.Add($BloatwareButton)
$BloatwareButton.Add_Click({
	Remove-BloatwareAppsList
	[System.Windows.MessageBox]::Show('Bloatware From List Removed.')
})

#Create Manual Tab
$Tab3 = New-object System.Windows.Forms.Tabpage
$Tab3.DataBindings.DefaultDataSourceUpdateMode = 0
$Tab3.UseVisualStyleBackColor = $True
$Tab3.Name = "Tab3"
$Tab3.Text = "Manual"
$FormTabControl.Controls.Add($Tab3)

# Create Atera Button
$Aterabutton = New-Object System.Windows.Forms.Button
$Aterabutton.Location = New-Object System.Drawing.Point(20, 25)
$Aterabutton.Size = New-Object System.Drawing.Size(175, 23)
$Aterabutton.Text = 'Install Atera from box'
$tab3.Controls.Add($Aterabutton)
$Aterabutton.Add_Click({
	Install-Atera $Aterabox.Text
})
# Create Atera Text Box
$Aterabox = New-Object System.Windows.Forms.TextBox
$AteraBox.Location = New-Object System.Drawing.Point(20, 50)
$Aterabox.Size = New-Object System.Drawing.Size(175, 23)
$tab3.Controls.Add($Aterabox)

# Create Chrome/Adobe Button
$ChradobeButton = New-Object System.Windows.Forms.Button
$ChradobeButton.Location = New-Object System.Drawing.Point(20, 75)
$ChradobeButton.Size = New-Object System.Drawing.Size(175, 23)
$ChradobeButton.Text = 'Install Chrome/Adobe'
$tab3.Controls.Add($ChradobeButton)
$ChradobeButton.Add_click({
	Install-GChrome
	Set-ChromeDefault
	Install-Reader
})

# Install Office Button
$OfficeButton = New-Object System.Windows.Forms.Button
$OfficeButton.Location = New-Object System.Drawing.Point(20, 100)
$OfficeButton.Size = New-Object System.Drawing.Size(175, 23)
$OfficeButton.Text = 'Install Office'
$tab3.Controls.Add($OfficeButton)
$OfficeButton.Add_Click({
	Install-OfficeInstaller
})

#Rename PC Button
$RenameButton = New-Object System.Windows.Forms.Button
$RenameButton.Location = New-Object System.Drawing.Point (20, 125)
$RenameButton.Size = New-Object System.Drawing.Size(175, 23)
$RenameButton.Text = 'Rename this PC'
$tab3.Controls.Add($RenameButton)
$RenameButton.Add_Click({
	$newname = $Renamebox.text
	$adminuser = Get-Credential
	Rename-Computer -NewName $newname -DomainCredential $adminuser
})

#Rename Box
$Renamebox = New-Object System.Windows.Forms.TextBox
$RenameBox.Location = New-Object System.Drawing.Point(200, 126)
$Renamebox.Size = New-Object System.Drawing.Size(175, 23)
$tab3.Controls.Add($Renamebox)

#
# This whole part just hides the console window
#
# .Net methods for hiding/showing the console in the background
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'

function Show-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()

    # Hide = 0,
    # ShowNormal = 1,
    # ShowMinimized = 2,
    # ShowMaximized = 3,
    # Maximize = 3,
    # ShowNormalNoActivate = 4,
    # Show = 5,
    # Minimize = 6,
    # ShowMinNoActivate = 7,
    # ShowNoActivate = 8,
    # Restore = 9,
    # ShowDefault = 10,
    # ForceMinimized = 11

    [Console.Window]::ShowWindow($consolePtr, 4)
}

function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}

Hide-Console

$form.Topmost = $false

$result = $form.ShowDialog()