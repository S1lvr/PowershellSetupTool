# ----------------------------------------------
#██╗░░░██╗██╗██████╗░███████╗  ░█████╗░██╗░░██╗███████╗░█████╗░██╗░░██╗
#██║░░░██║██║██╔══██╗██╔════╝  ██╔══██╗██║░░██║██╔════╝██╔══██╗██║░██╔╝
#╚██╗░██╔╝██║██████╦╝█████╗░░  ██║░░╚═╝███████║█████╗░░██║░░╚═╝█████═╝░
#░╚████╔╝░██║██╔══██╗██╔══╝░░  ██║░░██╗██╔══██║██╔══╝░░██║░░██╗██╔═██╗░
#░░╚██╔╝░░██║██████╦╝███████╗  ╚█████╔╝██║░░██║███████╗╚█████╔╝██║░╚██╗
#░░░╚═╝░░░╚═╝╚═════╝░╚══════╝  ░╚════╝░╚═╝░░╚═╝╚══════╝░╚════╝░╚═╝░░╚═╝
# ----------------------------------------------
# This makes sure your vibes (admin rights) are on point.
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
)
# New Client Process:
# Add Client name to the Array above, using underscores instead of spaces, this space is automatically sorted alphabetically, so don't worry about that.
# Create a function with the name scheme Get-<CLIENTNAME> where <CLIENTNAME> is
# What you placed in the array above.
# Next Add commands to the function, for extra help, Ware Butler's function is
# Completely Commented.
#-----------
#Todo:
# - Replace Chrome installer with Online Version, as the standalone is not longer needed. / Done
# - Set up a "run just this command" option so I can do this easier.
# - Finish Custom UI and functionality / Done
# - Set up Custom Client Import/Export / Done
# - Finish Custom Client UI ( Domain Settings )
# - See about pushing all Clients to Custom System, to allow making a proper progress bar.
# - See if change startup items script works.
# - Maybe we make it install gitcli, so it can upload custom client files, and download new ones. https://github.com/dahlbyk/posh-git
# - See about removing bloatware. maybe with https://github.com/Sycnex/Windows10Debloater
function Get-Mabel_Wadsworth
{
    Set-NewPCName
    Install-Atera 56
    Install-Webroot 0AF7-ATRA-16A5-FE4D-46F0
    Install-GChrome
    Set-ChromeDefault
    Install-Reader
    Install-OfficeInstaller
    Get-PowerSettingChanges
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
	Set-TSMPassword -password "RRworkstation!"
	Set-DNSAndDomain -DNSServer "10.146.72.211" -DomainServer "RR.local"
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
	Set-TSMPassword -password "C21workstation!"
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}
function Get-Campbells_True_Value
{
	Set-NewPCName
	Install-Atera 5
	Install-Webroot CDAB-ATRA-9D91-4CC3-4121
	Install-Epicor Campbells
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Set-TSMPassword -password "CTVworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.1.250" -DomainServer "Burger-Roy.local"
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Golden_Pond_Wealth_Management
{
	Set-NewPCName
	Install-Atera 31
	Install-Webroot 6F59-ATRA-6284-A3BA-4625
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Set-TSMPassword -password "GPworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.16.252" -DomainServer "GoldenPondWealth.local"
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Home_Hope_And_Healing
{
	Set-NewPCName
	Install-Atera 6
	Install-Webroot 0252-ATRA-5CEE-9DD5-4820
	Install-NetEx
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
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
	Set-TSMPassword -password "NOworkstation!"
	Add-OutputBoxLine "Setup Completed."
	Resolve-ProgressBar
}
function Get-Ray_Haskell_Ford
{
	Set-NewPCName
	Install-Atera 2
	Install-Webroot 8DF6-ATRA-720C-25F4-4595
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Set-TSMPassword -password "RHworkstation!"
	Set-DNSAndDomain -DNSServer "10.5.190.202" -DomainServer "haskell.local"
	Add-OutputBoxLine "Setup Complete."
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
	Set-TSMPassword -password "WBworkstation!" #Set the password to match standard convention for TSMAdmin
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
#Default Apps Settings
function Set-DefaultMail { # Thank you Mr. Random Czech Microsoft Dev for making this easy.
    Set-InstallStartupDirectory
    Start-Process SetUserFTA.exe -Wait -ArgumentList "mailto Outlook.URL.mailto.15"
	#If you want to use this for other things, you have to "SetUserFTA.exe get" first.
	#Grab the info you need from the associations, then use that.
}
function Set-DefaultPDF {
    Set-InstallStartupDirectory
    Start-Process SetUserFTA.exe -Wait -ArgumentList ".pdf AcroExch.Document.DC"
}
#Windows 10 Pin Removal
function Invoke-Win10PinRemoval #this was already a powershell script. Ctrl + C and Ctrl + V my guy.
{
	#Disable pin requirement
	$path = "HKLM:\SOFTWARE\Policies\Microsoft"
	$key = "PassportForWork"
	$name = "Enabled"
	$value = "0"
	
	New-Item -Path $path -Name $key -Force
	New-ItemProperty -Path $path\$key -Name $name -Value $value -PropertyType DWORD -Force
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
		[String]$password 
	)
	$tsmpass = ConvertTo-SecureString $password -AsPlainText -Force
	$UserAccount = Get-LocalUser -Name "TSMAdmin"
	$UserAccount | Set-LocalUser -Password $tsmpass
}
function Set-ChromeDefault
{
	Set-InstallStartupDirectory
	Start-Process SetDefaultBrowser.exe -Wait -ArgumentList "chrome"
	Add-OutputBoxLine -Message "Chrome has been set as Default Web Browser."
}
#░██████╗████████╗░█████╗░██████╗░████████╗██╗░░░██╗██████╗░  ██╗████████╗███████╗███╗░░░███╗░██████╗
#██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝██║░░░██║██╔══██╗  ██║╚══██╔══╝██╔════╝████╗░████║██╔════╝
#╚█████╗░░░░██║░░░███████║██████╔╝░░░██║░░░██║░░░██║██████╔╝  ██║░░░██║░░░█████╗░░██╔████╔██║╚█████╗░
#░╚═══██╗░░░██║░░░██╔══██║██╔══██╗░░░██║░░░██║░░░██║██╔═══╝░  ██║░░░██║░░░██╔══╝░░██║╚██╔╝██║░╚═══██╗
#██████╔╝░░░██║░░░██║░░██║██║░░██║░░░██║░░░╚██████╔╝██║░░░░░  ██║░░░██║░░░███████╗██║░╚═╝░██║██████╔╝
#╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░  ╚═╝░░░╚═╝░░░╚══════╝╚═╝░░░░░╚═╝╚═════╝░
function Disable-Startups #I took this entire function from StackOverflow with 0 shame.
#Jsc, et al. “Disabling Startup Programs.” Stack Overflow, 18 Oct, 2018, https://stackoverflow.com/questions/52692879/disabling-startup-programs. 
{
    [CmdletBinding()]

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
        New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS | 
        out-null
        $startups = Get-CimInstance Win32_StartupCommand | 
        Select-Object Name,Location
    }
    process 
    {
        Get-Item -path $32bit,$32bitRunOnce,$64bit,$64bitRunOnce,$currentLOU,$currentLOURunOnce |
        Where-Object {$_.ValueCount -ne 0} | 
        Select-Object  @{Name = 'Location';Expression = {$_.name -replace 'HKEY_LOCAL_MACHINE','HKLM' -replace 'HKEY_CURRENT_USER','HKCU'}},
        @{Name = 'Name';Expression = {$_.Property}} | 
        %{
            ForEach($disableListName in $disableList)
            {
                If($_.Name -contains $disableListName)
                { $_ | Select-Object -Property Location,Name }
                Else
                { Write-Warning -Message "$disableListName not found in registry" }
            }
        }
    }
    end {}
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
	Add-Computer -DomainName $DomainServer
	Add-OutputBoxLine "Resetting DNS Server config..."
	[System.Windows.MessageBox]::Show('Okay now close the tunnel.')
	foreach ($element in $array)
	{
		Set-DnsClientServerAddress -InterfaceIndex $($element).InterfaceIndex -ResetServerAddresses
	}
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
#░██╗░░░░░░░██╗███████╗██████╗░██████╗░░█████╗░░█████╗░████████╗
#░██║░░██╗░░██║██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝
#░╚██╗████╗██╔╝█████╗░░██████╦╝██████╔╝██║░░██║██║░░██║░░░██║░░░
#░░████╔═████║░██╔══╝░░██╔══██╗██╔══██╗██║░░██║██║░░██║░░░██║░░░
#░░╚██╔╝░╚██╔╝░███████╗██████╦╝██║░░██║╚█████╔╝╚█████╔╝░░░██║░░░
#░░░╚═╝░░░╚═╝░░╚══════╝╚═════╝░╚═╝░░╚═╝░╚════╝░░╚════╝░░░░╚═╝░░░
#Update Info:
#This install should not need to be updated, but if so, replace wsasme.msi
function Install-Webroot
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
}
#░█████╗░████████╗███████╗██████╗░░█████╗░
#██╔══██╗╚══██╔══╝██╔════╝██╔══██╗██╔══██╗
#███████║░░░██║░░░█████╗░░██████╔╝███████║
#██╔══██║░░░██║░░░██╔══╝░░██╔══██╗██╔══██║
#██║░░██║░░░██║░░░███████╗██║░░██║██║░░██║
#Update Info:
#This literally pulls a fresh installer every time.
#Updates not required.
function Install-Atera
{
	Param
	(
		[Parameter(Mandatory = $true, Position = 0)]
		[object]$ClientID
	)
	Add-OutputBoxLine "Creating Temp folder in C:\Temp"
	$Folder = "C:\Temp"
	if (Test-Path -Path $Folder)
	{
		Set-Location "C:\Temp"
	}
	else
	{
		New-Item "C:\Temp" -Type Directory
		Set-Location "C:\Temp"
	} #make a folder to work out of, if it doesn't exist
	Add-OutputBoxLine "Downloading Atera Installer..."
	$webrequest = -join ("http://servicedesk.techsolutionsme.com/GetAgent/Msi/?customerId=", $ClientID, "&integratorLogin=jbard%40techsolutionsme.com")
	#--------------------------------------
	# This link uses my login, so if I ever leave someone needs to change this to someone else's login.
	#--------------------------------------
	Invoke-WebRequest -Uri $webrequest -Outfile C:\Temp\Atera.msi
	Set-Location C:\Temp
	Add-OutputBoxLine "Atera Downloaded (If you have internet,) now installing, please select Yes"
	Start-Process msiexec -Wait -ArgumentList "/i Atera.msi"
	Add-OutputBoxLine "Atera Installed"
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
function Install-Epicor
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
		Start-Process "setup_31.exe" -wait -ArgumentList "/s"
		Add-OutputBoxLine "Epicor v31 Installed."
	}
	elseif ($epicor -eq "Campbells")
	{
		# If Campbells Install Epicor V30
		Add-OutputBoxLine "Installing Epicor v30 for Campbells..."
		Set-Location .\InstallData\Campbells
		Start-Process "setup.exe" -wait -ArgumentList "/s"
		Add-OutputBoxLine "Epicor v30 Installed."
	}
	else
	{
		# If anything else. Well, How did I get here?       
		#ℒℰ𝒯𝒯ℐ𝒩𝒢 𝒯ℋℰ 𝒟𝒜𝒴𝒮 𝒢𝒪 ℬ𝒴
		function popUp($text, $title)
		{
			$a = new-object -comobject wscript.shell
			$b = $a.popup($text, 0, $title, 0)
		}
		popUp "Epicor tried to install with no client name" "Error"
	}
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
#██╗░░██╗███████╗████████╗  ███████╗██╗░░██╗████████╗███████╗███╗░░██╗██████╗░███████╗██████╗░
#████╗░██║██╔════╝╚══██╔══╝  ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝████╗░██║██╔══██╗██╔════╝██╔══██╗
#██╔██╗██║█████╗░░░░░██║░░░  █████╗░░░╚███╔╝░░░░██║░░░█████╗░░██╔██╗██║██║░░██║█████╗░░██████╔╝
#██║╚████║██╔══╝░░░░░██║░░░  ██╔══╝░░░██╔██╗░░░░██║░░░██╔══╝░░██║╚████║██║░░██║██╔══╝░░██╔══██╗
#██║░╚███║███████╗░░░██║░░░  ███████╗██╔╝╚██╗░░░██║░░░███████╗██║░╚███║██████╔╝███████╗██║░░██║
#╚═╝░░╚══╝╚══════╝░░░╚═╝░░░  ╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚══╝╚═════╝░╚══════╝╚═╝░░╚═╝
#Update Info:
#Replace NetEx.msi with newer version.
function Install-NetEx
{
	Set-InstallStartupDirectory
	Add-OutputBoxLine "Installing NetExtender..."
	Start-Process msiexec -Wait -ArgumentList "/package NetEx.msi /qn /norestart"
	Add-OutputBoxLine "NetExtender Installed."
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
	$nameoutput = -join ("Renamed PC to ", $text, ", please restart to finalize change.")
	Add-OutputBoxLine $nameoutput
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
		$username = -join ($env:USERDOMAIN, "\", $env:USERNAME)
		Add-LocalGroupMember -Group "Administrators" -Member $username
		$message = -join("User ", $env:USERNAME, " added as local admin")
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