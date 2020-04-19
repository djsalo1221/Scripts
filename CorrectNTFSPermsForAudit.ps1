Install-Module -Name NTFSSecurity -RequiredVersion 4.2.3 
Import-module NTFSSecurity -verbose

$folderArray = get-Content -Path 'C:\PATH'

$count = 0
foreach ($folder in $folderArray)
{
  Write-Host $folder
  cd $folder
  cd ..
  Disable-NTFSAccessInheritance $folder
  remove-ntfsaccess -path $folder -Account DOMAIN\GROUP -AccessRights Delete
  $count = $count + 1
}
write-host $count