@echo off
powercfg /h off
echo hibernate disabled
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 238c9fa8-0aad-41ed-83f4-97be242c8f20 bd3b718a-0680z-4d9d-8ab2-e1d2 4ac806d 1
powercfg /SETACVALUEINDEX SCHEME_CURRENT 238c9fa8-0aad-41ad-83f4-97be242c8f20 bd3b718a-0680-4d9d-8ab2-e1d2b4ac806d 1
echo wake timers enabled
powercfg /SETDCVALUEINDEX SCHEME_CURRENT 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0
powercfg /SETACVALUEINDEX SCHEME_CURRENT 0012ee47-9041-4b5d-9b77-535fba8b1442 6738e2c4-e8a5-4a42-b16a-e040e769756e 0
echo disable hdd timer disabled
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
echo sleep disabled
exit