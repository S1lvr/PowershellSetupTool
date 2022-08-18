<#
 .Synopsis
  Set up a client
 .Description
  Custom setup to set up a client's new PC
 .Example
   # Get-Client runs as itself.
#>
function Get-Maine_Center_for_Dental_Medicine
{
    Set-NewPCName
	Install-Atera 11
	Install-Webroot A17D-ATRA-C256-BC28-4CA2
	Install-GChrome
	Set-ChromeDefault
	Install-OfficeInstaller
	Install-Reader
	Get-PowerSettingChanges
	Set-TSMPassword -password "MCDMworkstation!"
	Set-DNSAndDomain -DNSServer "192.168.2.53" -DomainServer "MCDM.local"
	Add-OutputBoxLine -Message "Setup Completed."
	Resolve-ProgressBar
}