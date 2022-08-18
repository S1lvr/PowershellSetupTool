Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()
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
			$firstline = -join ("function Get-", "$($newclientname.Text)")
			$newclientarray = @(#this is so stupid but it's how we're going to export our custom client
				$firstline #just write the new function line by line
				"{" #then import all .ps1s in the custom client folder.
				"Set-NewPCName" #and run this since all of them should have this.
			)
			$newclientarray += -join ("Install-Atera -ClientID ", "$($AteraKey.Text)")
			$newclientarray += -join ("Install-Webroot -key ", "$($WebrootKey.Text)")
			if ($checkbox1.Checked -eq $true)
			{
				$newclientarray += "Install-NetEx"
			}
			if ($checkbox2.Checked -eq $true)
			{
				$newclientarray += "Install-GChrome"
				$newclientarray += "Set-ChromeDefault"
			}
			if ($checkbox3.Checked -eq $true)
			{
				$newclientarray += "Install-OfficeInstaller"
			}
			if ($checkbox4.checked -eq $true)
			{
				$newclientarray += "Install-Reader"
			}
			$newclientarray += "Get-PowerSettingChanges"
			$newclientarray += "Add-OutputBoxLine 'Setup Completed.'"
			$newclientarray += "Resolve-ProgressBar"
			$newclientarray += "}"
			$savenewclient = $true
			if ($savenewclient -eq $true)
			{
				$folder = ".\CustomClients"
				Set-Location $folder
				$newfilename = -join ("$($newclientname.Text)", ".ps1")
				if (Test-Path -Path $Folder)
				{
					foreach ($line in $newclientarray)
					{
						Add-Content $newfilename $line
					}
				}
				else
				{
					New-Item ".\CustomClients" -Type Directory
					$outfilename = -join ($newclientname, ".ps1")
					Set-Location -Path ".\CustomClients"
					$newclientarray | Out-File -FilePath $outfilename
				}
				
			}
		}
	}
}
Get-Custom