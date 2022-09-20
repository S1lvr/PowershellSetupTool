@echo off
powershell "set-executionpolicy remotesigned -scope localmachine"
powershell "set-executionpolicy remotesigned -scope currentuser"