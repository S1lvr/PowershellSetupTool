@echo off
rem powershell "set-executionpolicy remotesigned -scope localmachine"
powershell "set-executionpolicy remotesigned -scope currentuser"
Echo "Setting Execution Policy..."
cd .\SetupScript
Echo "Starting Update Process..."
Powershell -NoProfile -ExecutionPolicy Bypass -command "& '.\Update.ps1'"