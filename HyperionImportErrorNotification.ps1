<#
 #
 # Per xxxxxxxxxx, sends email notifications to distribution gorups
 #    for each of the 10 data load error files containing any information (1 character or more)
 #    Runs every 15 minutes per Scheduled Tasks.  Only sends email when a change is detected in error file.
 #    Resends any remaining errors once per day until marked as resolved. 
#>
Start-Transcript -Path .\Logs\ErrorNotificationsLog.txt -Append -Force

#Get-Credential | Export-CliXml  -Path HypserviceCredentials.xml
$Cred = Import-CliXml -Path  xxxxxxxxxx.xml  #Runs with xxxxxxxxxx\xxxxxxxxxx 

$SMTPServer = "xxxxxxxxxx.xxxxxxxxxx.local"
$SMTPPort = "587"

$From = "xxxxxxxxxx@XXXxxxxxxxxxx.com"
$Message = "Errors have been identified during the data load procedure for this site.   Please review, correct and reload file. Please consider the below potential turn backs for further assistance if necessary:  `n`n    -> Ensure that statistical account information is loaded correctly.   `n    -> Load file is formatted correctly according to system specifications.  `n    -> All new accounts have been created in Hyperion prior to reloading.   `n`n Contact xxxxxxxxxx if you are unsure how to resolve.`n`n`n`n"

$KBsize = 0
$Timeout = 15 #Workaround our Exchange MessageRateLimit 


if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{ 
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message  + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\XXX_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\XXX_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\XXX_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_XXX@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    XXX' -Body ($Message + (Get-Content .\Logs\XXX_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\XXX_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\XXX_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\XXX_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxxxxxxxxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxxxxxxxxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxxxxxxxxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
   Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
   Send-MailMessage -From $From -To '_Hyperion_xxxxxxxxxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxxxxxxxxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxxxxxxxxx@vxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    #Start-Sleep -Seconds 3
    Send-MailMessage -From $From -To '_Hyperion_xxxxxxxxxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxxxxxxxxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\Tempe_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\Tempe_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\Tempe_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\Tempe_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxxxxxxxxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\Tempe_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxxxxxxxxx@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\Corporate_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\Corporate_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxxxxxxxxxe@xxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\Corporate_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Priority High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

Stop-Transcript
