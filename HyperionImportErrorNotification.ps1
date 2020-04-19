<#
 #
 # Per Sysaid # 144812, sends email notifications to distribution gorups
 #    for each of the 10 data load error files containing any information (1 character or more)
 #    Runs every 15 minutes per Scheduled Tasks.  Only sends email when a change is detected in error file.
 #    Resends any remaining errors once per day until marked as resolved. 
#>
Start-Transcript -Path .\Logs\ErrorNotificationsLog.txt -Append -Force

#Get-Credential | Export-CliXml  -Path HypserviceCredentials.xml
$Cred = Import-CliXml -Path  HypserviceCredentials.xml  #Runs with palmermfgco\HypService 

$SMTPServer = "casarray.palmermfgco.local"
$SMTPPort = "587"

$From = "hypservice@paradigmprecision.com"
$Message = "Errors have been identified during the data load procedure for this site.   Please review, correct and reload file. Please consider the below potential turn backs for further assistance if necessary:  `n`n    -> Ensure that statistical account information is loaded correctly.   `n    -> Load file is formatted correctly according to system specifications.  `n    -> All new accounts have been created in Hyperion prior to reloading.   `n`n Contact Group FP&A if you are unsure how to resolve.`n`n`n`n"

$KBsize = 0
$Timeout = 15 #Workaround our Exchange MessageRateLimit 


if(((Get-Item 'D:\Data\Hyperion Imports\Logs\BOS_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\BOS_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\BOS_DataLoad_Errors.err -Raw))))
{ 
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\BOS_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_BOS@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    BOS' -Body ($Message  + (Get-Content .\Logs\BOS_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\BOS_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\BOS_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\BER_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\BER_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\BER_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\BER_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_BER@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    BER' -Body ($Message + (Get-Content .\Logs\BER_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\BER_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\BER_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\BUR_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\BUR_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\BUR_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\BUR_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_BUR@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    BUR' -Body ($Message + (Get-Content .\Logs\BUR_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\BUR_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\BUR_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\DPG_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\DPG_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\DPG_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\DPG_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_DPG@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    DPG' -Body ($Message + (Get-Content .\Logs\DPG_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\DPG_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\DPG_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\EUR2_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\EUR2_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\EUR2_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\EUR2_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_EUR2@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    EUR2' -Body ($Message + (Get-Content .\Logs\EUR2_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\EUR2_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\EUR2_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\HUN_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\HUN_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\HUN_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\HUN_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_HUN@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    HUN' -Body ($Message + (Get-Content .\Logs\HUN_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\HUN_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\HUN_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\MAN_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\MAN_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\MAN_DataLoad_Errors.err -Raw))))
{
   Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\MAN_DataLoad_Errors.err' -Append -Force
   Send-MailMessage -From $From -To '_Hyperion_MAN@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    MAN' -Body ($Message + (Get-Content .\Logs\MAN_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\MAN_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\MAN_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\ORI_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\ORI_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\ORI_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\ORI_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_ORI@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    ORI' -Body ($Message + (Get-Content .\Logs\ORI_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\ORI_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\ORI_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\POL_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\POL_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\POL_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\POL_DataLoad_Errors.err' -Append -Force
    #Start-Sleep -Seconds 3
    Send-MailMessage -From $From -To '_Hyperion_POL@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    POL' -Body ($Message + (Get-Content .\Logs\POL_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\POL_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\POL_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\STU_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\STU_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\STU_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\STU_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_STU@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    STU' -Body ($Message + (Get-Content .\Logs\STU_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\STU_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\STU_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\Tempe_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\Tempe_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\Tempe_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\Tempe_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_Tempe@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    Tempe' -Body ($Message + (Get-Content .\Logs\Tempe_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\Tempe_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\Tempe_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\GCUM_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\GCUM_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\GCUM_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\GCUM_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_GCUM@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    GCUM' -Body ($Message + (Get-Content .\Logs\GCUM_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\GCUM_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\GCUM_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\Corporate_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\Corporate_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\Corporate_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\Corporate_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_Corporate@paradigmprecision.com' `
    -Subject 'Data Load Error(s):    Corporate' -Body ($Message + (Get-Content .\Logs\Corporate_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\Corporate_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\Corporate_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

Stop-Transcript
