
#Auto-program YubiKey for Slot 1 = YubiKey AES, Slot 2 = OATH-HOTP 6, output and copy to clipboard both config strings

Import-Module Duo

$ErrorActionPreference= "silentlycontinue"

#Set alias for .exes
set-alias ykman "C:\Program Files\Yubico\YubiKey Manager\ykman.exe"
set-alias ykpersonalize "C:\Program Files\Yubico\ykpers-1.19.0-win64\bin\ykpersonalize.exe"

#Program Slot 1 for Yubico AES OTP and format string
$YubiKeyAESString = (ykman otp yubiotp 1 --serial-public-id --generate-private-id --generate-key --force | Out-String)
$YubiKeyAESString = $YubiKeyAESString -replace 'Using YubiKey serial as public ID: ',''
$YubiKeyAESString = $YubiKeyAESString -replace 'Using a randomly generated private ID: ',','
$YubiKeyAESString = $YubiKeyAESString -replace 'Using a randomly generated secret key: ',','
$YubiKeyAESString = $YubiKeyAESString -replace "`t|`n|`r","" 
$YubiKeySplit = $YubiKeyAESString -split ','
$YubiKeyAESSerial = $YubiKeySplit[0]
$YubiKeyAESPrivate_ID = $YubiKeySplit[1]
$YubiKeyAESKey = $YubiKeySplit[2]

#Program Slot 2 for standard 6-digit OATH-HOTP OTP and format string
$HOTPKey=(((40)|%{((1..$_)|%{('{0:X}' -f (random(16)))})}) -Join "").ToLower()
ykpersonalize -y -2 -o oath-hotp -o append-cr -a"$HOTPKey"
$HOTPSerial = (ykman list --serials | Out-String)
$HOTPKey = $HOTPKey -replace "`t|`n|`r",""
$HOTPString = $HOTPSerial + "," + $HOTPKey
$HOTPString = $HOTPString -replace "`t|`n|`r",""

#Create configuration strings for paste into Duo Admin portal
Write-Host "`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`nYubiKey AES config string for this YubiKey's Slot 1 (short push):"
Write-Host $YubiKeyAESString -ForegroundColor Yellow
Write-Host "<serial>,<random private id>,<random secret key>"
Write-Host "`n`n"
Write-Host "HOTP 6-digit config string for this YubiKey's Slot 2 (long push):"
Write-Host $HOTPString -ForegroundColor Yellow
Write-Host "<serial>,<random secret key>`n`n`n`n`n`n`n`n`n`n"

#Before creating/recreating new token_id, delete tokens of serial numbers to be recreated
$token_id_yk = (duoGetToken -type yk -serial $YubiKeyAESSerial | Out-String).trim()
$token_id_yk = $token_id_yk -replace "`t|`n|`r|\s",""
$token_id_yk = $token_id_yk.Substring(($token_id_yk.IndexOf('token_id:') + 9), ($token_id_yk.IndexOf('totp_step:') - $token_id_yk.IndexOf('token_id:') -9))
$HOTPSerial = $HOTPSerial -replace "`t|`n|`r",""
$token_id_h6 = (duogettoken | select serial, token_id | Where-Object serial -eq $HOTPSerial | Format-Table -HideTableHeaders | Out-String).Trim()
$token_id_h6 = $token_id_h6 -replace "`t|`n|`r|\s|$HOTPSerial",""
duoDeleteToken -token_id $token_id_yk -ErrorAction SilentlyContinue
duoDeleteToken -token_id $token_id_h6 -ErrorAction SilentlyContinue
$ErrorActionPreference= "continue"

#API POST call to Duo Admin - register token slots 1 and 2
$token_id_yk = (duoCreateToken -type yk -serial $YubiKeyAESSerial  -private_id $YubiKeyAESPrivate_ID -aes_key $YubiKeyAESKey | Out-String).trim()
$token_id_h6 = (duoCreateToken -Type h6 -Serial $HOTPSerial -Secret $HOTPKey | Out-String).trim() 
$token_id_yk = $token_id_yk -replace "`t|`n|`r|\s",""
$token_id_h6 = $token_id_h6 -replace "`t|`n|`r|\s",""
$token_id_yk = $token_id_yk.Substring(($token_id_yk.IndexOf('token_id:') + 9), ($token_id_yk.IndexOf('totp_step:') - $token_id_yk.IndexOf('token_id:') -9))
$token_id_h6 = $token_id_h6.Substring(($token_id_h6.IndexOf('token_id:') + 9), ($token_id_h6.IndexOf('totp_step:') - $token_id_h6.IndexOf('token_id:') -9))

#Prompt for assignee's UPN and calls API to associate user with both tokens
$username = Read-Host -Prompt "Enter the UPN of the user being assigned this YubiKey: " 
$user_id = (duoGetUser -username $username | select user_id | Format-Table -HideTableHeaders | Out-String).trim()
duoAssocUserToToken -token_id $token_id_yk -user_id $user_id
duoAssocUserToToken -token_id $token_id_h6 -user_id $user_id

#Change summary:
write-host "Script execution complete, confirmation of changes:" -ForegroundColor Green
write-host "Duo's JSON object data for this YubiKey's slot 1:" -ForegroundColor Green
duoGetToken -token_id $token_id_yk 
write-host "`n`nDuo's JSON object data for this YubiKey's slot 2:" -ForegroundColor Green
duoGetToken -token_id $token_id_h6 
write-host "`n`nDuo username $username sync status:" -ForegroundColor Green
duoSyncUser -username $username
write-host "`n`nIf this was to replace a user's lost, broken or fix out-of-sync HOTP, please make sure to repeat the offline access configuration wizard at the user's PC." -ForegroundColor Yellow


