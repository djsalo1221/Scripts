<#
 #
 # Per xxxxxxxxx sends email notifications to distribution gorups
 #    for each of the 10 data load error files containing any information (1 character or more)
 #    Runs every 15 minutes per Scheduled Tasks.  Only sends email when a change is detected in error file.
 #    Resends any remaining errors once per day until marked as resolved. 
#>
Start-Transcript -Path .\Logs\ErrorNotificationsLog.txt -Append -Force

#Get-Credential | Export-CliXml  -Path xxxxxxxxxxxCredentials.xml
$Cred = Import-CliXml -Path  xxxxxxxxxxxxxxxx.xml  #Runs with xxxxxxxxxxx\xxxxxxxxxxx 

$SMTPServer = "casarray.xxxxxxxxxxx.xxxxxxxxxxx"
$SMTPPort = "587"

$From = "xxxxxxxxxxx@xxxxxxxxxxxxxxxxxxxxxx.com"
$Message = "Errors have been identified during the data load procedure for this site.   Please review, correct and reload file. Please consider the below potential turn backs for further assistance if necessary:  `n`n    -> Ensure that statistical account information is loaded correctly.   `n    -> Load file is formatted correctly according to system specifications.  `n    -> All new accounts have been created in Hyperion prior to reloading.   `n`n Contact xxxxxxxxxxxxx if you are unsure how to resolve.`n`n`n`n"

$KBsize = 0
$Timeout = 15 #Workaround our Exchange MessageRateLimit 


if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{ 
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message  + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx2_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx2_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx2_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx2_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx2@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx2' -Body ($Message + (Get-Content .\Logs\xxx2_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx2_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx2_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
   Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
   Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    #Start-Sleep -Seconds 3
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

if(((Get-Item 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err').length/1KB -gt $KBsize) -and (((Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw) -ne (Get-Content .\Logs\COMPARE\xxx_DataLoad_Errors.err -Raw))))
{
    Get-Date | Out-File -FilePath 'D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err' -Append -Force
    Send-MailMessage -From $From -To '_Hyperion_xxx@xxxxxxxxxxxxxxxxxxxxxx.com' `
    -Subject 'Data Load Error(s):    xxx' -Body ($Message + (Get-Content .\Logs\xxx_DataLoad_Errors.err -Raw)) `
    -SmtpServer $SMTPServer -port $SMTPPort -Credential $cred -Prixxxty High
    Copy-Item "D:\Data\Hyperion Imports\Logs\xxx_DataLoad_Errors.err" -Destination "D:\Data\Hyperion Imports\Logs\COMPARE\xxx_DataLoad_Errors.err"
    Start-Sleep -Seconds $Timeout
}

Stop-Transcript
