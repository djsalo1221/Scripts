#Import-Module ActiveDirectory

Start-Transcript -Path \\SERVER\PATH\LOGS.TXT -Append
$users = Get-ADUser -Filter {HomeDirectory -like "\\SERVER\*" -And sAMAccountName -Like "D*"} -Properties sAMAccountName,HomeDirectory | Select HomeDirectory,sAMAccountName 
foreach ($user in $users)
{
    $SAM = $user.SamAccountName
    $oldDir = $user.HomeDirectory
    $oldDirRename = $oldDir + "_old"
    Write-Host "OLDDIR for $SAM IS $oldDir"

    robocopy $oldDir \\NEWSERVER\Users$\$SAM /COPYALL /XO /E /ZB /SEC /R:5 /W:5

    Rename-Item -Path $oldDir -NewName $OldDirRename -Force
    Set-ADUser -Identity $SAM -HomeDirectory "\\NEWSERVER\Users$\$SAM" 
    $newDir = Get-ADUser -Identity $SAM -Properties HomeDirectory | Select HomeDirectory
    Write-Output "NEWDIR FOR $SAM IS $newDIR"
}
Stop-Transcript