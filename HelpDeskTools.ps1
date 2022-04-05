###############################################################
#This section adds the Assemblies for drawing the grphical UI.#
###############################################################
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationCore,PresentationFramework

####################################################
#Prompts to connected to Microsoft Services.#
####################################################
Import-Module ActiveDirectory
Install-Module -Name ExchangeOnlineManagement
Connect-MsolService
Connect-ExchangeOnline -ExchangeEnvironmentName xxxxxxxxx

########################################
#Prompts the employee to select a task.#
########################################
Do{
    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Select a Task'
    $form.Size = New-Object System.Drawing.Size(300,300)
    $form.StartPosition = 'CenterScreen'
    
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Location = New-Object System.Drawing.Point(70,225)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.Text = 'OK'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $okButton
    $form.Controls.Add($okButton)
    
    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(150,225)
    $cancelButton.Size = New-Object System.Drawing.Size(75,23)
    $cancelButton.Text = 'Cancel'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $cancelButton
    $form.Controls.Add($cancelButton)
    
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(100,20)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Select a Task'
    $form.Controls.Add($label)
    
    $listBox = New-Object System.Windows.Forms.ListBox
    $listBox.Location = New-Object System.Drawing.Point(10,40)
    $listBox.Size = New-Object System.Drawing.Size(260,100)
    $listBox.Height = 180
    
    #[void] $listBox.Items.Add('Onboard an Employee')
    [void] $listBox.Items.Add('Onboard Employee from Ticket Info')
    [void] $listBox.Items.Add('Terminate an Employee')
    [void] $listBox.Items.Add('License an Employee with Office 365')
    [void] $listBox.Items.Add('Remove an Employees Office 365 Licenses')
    [void] $listBox.Items.Add('Put an Employee Email on Litigation Hold')
    [void] $listBox.Items.Add('Generate a random password')
    [void] $listBox.Items.Add('Reset an Employee Password')
    [void] $listBox.Items.Add('Unlock an Employees account')
    
    $form.Controls.Add($listBox)
    
    $form.Topmost = $true
    
    $result = $form.ShowDialog()
    
    if ($result -eq [System.Windows.Forms.DialogResult]::OK){
        $x = $listBox.SelectedItem
        $x
    }
    #############################################################################
    #If the employee selects the Onboard an Employee task this code will execute# 
    ############################################################################# 
    if($x -eq "Create new employee AD account"){
        param(
    [Parameter(Mandatory, HelpMessage = "Enter a ticket number")][string]$XXXXXXTicket,
    [Parameter(Mandatory, HelpMessage = "Select a Login Script")][string]$loginScript,
    [Parameter(Mandatory, HelpMessage = "Select a Login Script")][string]$XXXXXXTechName    
    )
      
        if ($XXXXXXTicket -ne $null -or $XXXXXXTicket -ne ""){
            #Write-Host "Ticket number is $XXXXXXTicket" -ForegroundColor Yellow
            #############################################################
            #Reaches out to XXXXXX and retrieves the ticket information#
            #############################################################
            $User = "XXXXXX"
            $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
            $link = "https://xxxxxxxxx.cloud.XXXXXX.net/api/v1/incident"
            $callBod = @{
                id = $XXXXXXTicket
            }
            
            ##############################################
            #Converts the data in the ticket to variables#
            ##############################################
            $incidentResults = Invoke-WebRequest $link -Credential $Credential -SessionVariable 'Session' -body $callBod -Method 'Get' -UseBasicParsing | ConvertFrom-Json
            $incidentResults.custom_fields
            $Site = $incidentResults.custom_fields.1341
            $Site = $Site.psobject.Properties.value
            $firstName = $incidentResults.custom_fields.1396
            $lastName = $incidentResults.custom_fields.1398
            $displayName = $firstName + " " + $lastName
            $userName = $firstName + "." + $lastName
            $email = $userName + "@xxxxxxxxxxxxxxxxxx.com"
            $Department = $incidentResults.custom_fields.1351
            $jobTitle = $incidentResults.custom_fields.1392
            $employeeType = $incidentResults.custom_fields.1357
            $employeeType = $employeeType.psobject.Properties.value
            $Manager = $incidentResults.custom_fields.1340 | Write-Output
            
            #####################################################################
            #Sets the Manager based on the XXXXXX New Hire Ticket Manager Field#
            #####################################################################
            $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
            $link = "https://xxxxxxxxxxxxx.cloud.XXXXXX.net/api/v1/user"
            $callBod = @{
                    id = $Manager
            }
            
            $userResults = Invoke-WebRequest $link -Credential $Credential -SessionVariable 'Session' -body $callBod -Method 'Get' | ConvertFrom-Json
            $Manager = $userResults.username.Split("\")
            $Manager = $Manager[1]
            $Manager = Get-ADUser -Identity $Manager | Select-Object -ExpandProperty DistinguishedName
            
            ##############################################################################################################################
            #Creates an Array of xxxxxxxxx's Sites and Home Directorys. Sets the Site and  Home Directory variables based on Site variable#
            ##############################################################################################################################
            $siteVariables = @(
                    [pscustomobject]@{Site = "xxxxx, xx"; Path = "\\XXX-xxxxx\Users\$userName"; Drive = "J:"; Street = "xxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xxxxx"; OrgUnit = "xxxxx"}
                    [pscustomobject]@{Site = "xxxxx"; Path = "\\XXX-xxxxx-xxxxx01\users\$userName"; Drive = "J:"; Street = "xxxxx `nBxxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xxxxx"; OrgUnit = "xxxxx"}
                    [pscustomobject]@{Site = "xxxxx, xx"; Path = "\\XXX-xxx01\users\$userName"; Drive = "J:"; Street = "xxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xxxxx"; OrgUnit = "xxxxx"},
                    [pscustomobject]@{Site = "xxxxx, xx"; Path = "\\XXX-xxxxx-MNCH01\Users$\$userName"; Drive = "U:"; Street = "xxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xxxxx"; OrgUnit = "xxxxx"},
                    [pscustomobject]@{Site = "xxxxx"; Path = "\\ORL-DEPOT\USERS$\$userName"; Drive = "U:"; Street = "xxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xxxxx"; OrgUnit = "xxxxx"},
                    [pscustomobject]@{Site = "xxxxx, xx"; Path = "\\XXX-xxx01\Users\$userName"; Drive = "J:"; Street = "xxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xxxxx"; OrgUnit = "xxxxx"},
                    [pscustomobject]@{Site = "xxxxx, xx"; Path = "\\XXX-xxxxx-strt01\Users$\$userName"; Drive = "J:"; Street = "xxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xx"; OrgUnit = "Oxxxxx"},
                    [pscustomobject]@{Site = "xxxxx"; Path = "\\XXX-xxx-xxx\users\$userName"; Drive = "J:"; Street = "xxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xx"; OrgUnit = "xxxxx"},
                    [pscustomobject]@{Site = "xxxxx"; Path = "\\XXX-xxx-xxx\USERS$\$userName"; Drive = "H:"; Street = "xxxxx"; City = "xxxxx"; State = "xxxxx"; Zip = "xxxxx"; Country = "xxxxx"; OrgUnit = "xxxxx"}
            )
            $Site = $siteVariables -match $Site | Select-Object -ExpandProperty Site
            $homeDirectory = $siteVariables -match $Site | Select-Object -ExpandProperty Path
            $Drive = $siteVariables -match $Site | Select-Object -ExpandProperty Drive
            $Street = $siteVariables -match $Site | Select-Object -ExpandProperty Street
            $City = $siteVariables -match $Site | Select-Object -ExpandProperty City
            $State = $siteVariables -match $Site | Select-Object -ExpandProperty State
            $Zip = $siteVariables -match $Site | Select-Object -ExpandProperty Zip
            $Country = $siteVariables -match $Site | Select-Object -ExpandProperty Country
            $orgUnit = $siteVariables -match $Site | Select-Object -ExpandProperty OrgUnit
            
            #############################################################
            #Generates a random password and sets it as a secure string.#
            #############################################################
            $Chars1 = [Char[]]"BDFGHKLMNPRSTVWZ"
            $Chars21 = [Char[]]"aeiou"
            $Chars22 = [Char[]]"bdfghkmnprstvwz"
            $Chars3 = [Char[]]"2345679"
            $Chars4 = [Char[]]"!@#$%"
            $P1 = ($Chars1 | Get-Random -Count 1) -join ""
            $P2 = ($Chars21 | Get-Random -Count 1) -join ""
            $P3 = ($Chars22 | Get-Random -Count 1) -join ""
            $P4 = ($Chars21 | Get-Random -Count 1) -join ""
            $P5 = ($Chars22 | Get-Random -Count 1) -join ""
            $P6 = ($Chars21 | Get-Random -Count 1) -join ""
            $P7 = ($Chars3 | Get-Random -Count 4) -join ""
            $P8 = ($Chars4 | Get-Random -Count 2) -join ""
            $Password = $P1 + $P2 + $P3 + $P4 + $P5 + $P6 + $P7 + $P8
            $Password = ConvertTo-SecureString -String $Password -AsPlainText -Force
                         
                $Params = @{
                    Name = $displayName
                    AccountPassword = $Password
                    Path = $orgUnit
                    UserPrincipalName = $email
                    GivenName = $firstName
                    Surname = $lastName
                    DisplayName = $displayName
                    SamAccountName = $userName
                    Description = $jobTitle
                    EmailAddress = $email
                    HomeDirectory = $homeDirectory
                    HomeDrive = $Drive
                    ScriptPath = $loginScript
                    Department = $Department
                    Title = $jobTitle
                    Manager = $Manager
                    Office = $Site
                    Company = $Site
                    StreetAddress = $Street
                    City = $City
                    State = $State
                    PostalCode = $Zip
                    Country = $Country
                    Enabled = $false
                }
                New-ADUser @Params
    
                $XXXXXXTechnician = @(
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "21"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "2200"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "22"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "4"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "5"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "27"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "2192"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "6"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "28"}
                        [pscustomobject]@{Technician = "xxxxxx.xxxxxxx"; ID = "2097"}
                )
                $authorID = $XXXXXXTechnician -match $XXXXXXTechName | Select-Object -ExpandProperty "ID"
                
                $User = "XXXXXX.automation"
                $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
                $link = "https://xxxxxxxxxxxxx.cloud.XXXXXX.net/api/v1/incident.comment"
                $callBod = @{
                    comment = "The Emplyee's account has been created.<br>Site: $Site<br>First Name: $firstName<br>Last Name: $lastName<br>Display Name: $displayName<br>UserName: $userName<br>Email: $email<br>Department: $Department<br>Job Title: $jobTitle<br>Manager: $Manager<br>Home Directory: $homeDirectory<br>Employee Type: $employeeType<br>Address: <br>$Street<br>$City, $State $Zip<br>Country: $Country<br>OU: $orgUnit"
                    author_id = $authorID
                    request_id = $XXXXXXTicket
                }
            
                Invoke-WebRequest $link -Credential $Credential -SessionVariable 'Session' -body $callBod -Method 'Post'                
        }
    }



    ###############################################################################
    #If the employee selects the Terminate an Employee task this code will execute#
    ###############################################################################
    if($x -eq "Terminate an Employee"){
        Copy-Item "\\xxxxxxxxx\xxxxxxxxx\xxxxxxxxx.pdf" -Destination "C:\"
    
    ##################################################
    #Prompts the employee to enter the ticket number.#
    ##################################################
        $form = New-Object System.Windows.Forms.Form
        $form.Text = 'Data Entry Form'
        $form.Size = New-Object System.Drawing.Size(300,200)
        $form.StartPosition = 'CenterScreen'
        
        $okButton = New-Object System.Windows.Forms.Button
        $okButton.Location = New-Object System.Drawing.Point(75,120)
        $okButton.Size = New-Object System.Drawing.Size(75,23)
        $okButton.Text = 'OK'
        $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.AcceptButton = $okButton
        $form.Controls.Add($okButton)
        
        $cancelButton = New-Object System.Windows.Forms.Button
        $cancelButton.Location = New-Object System.Drawing.Point(150,120)
        $cancelButton.Size = New-Object System.Drawing.Size(75,23)
        $cancelButton.Text = 'Cancel'
        $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
        $form.CancelButton = $cancelButton
        $form.Controls.Add($cancelButton)
        
        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(10,20)
        $label.Size = New-Object System.Drawing.Size(280,20)
        $label.Text = 'Please enter the ticket number:'
        $form.Controls.Add($label)
        
        $textBox = New-Object System.Windows.Forms.TextBox
        $textBox.Location = New-Object System.Drawing.Point(10,40)
        $textBox.Size = New-Object System.Drawing.Size(260,20)
        $form.Controls.Add($textBox)
        
        $form.Topmost = $true
        
        $form.Add_Shown({$textBox.Select()})
        $result = $form.ShowDialog()
        
        if ($result -eq [System.Windows.Forms.DialogResult]::OK){
            $xxxxxxxxxTicket = $textBox.Text
            Write-Host "Ticket number is $xxxxxxxxxTicket" -ForegroundColor Yellow
        }
    
    ##############################################################
    #Brings up a pop up window to select the terminated employee.#
    ##############################################################
        $UPN = Get-ADUser -Filter * -Properties SamAccountName | select SamAccountName | Out-GridView -OutputMode Single -Title "Select the User to Terminate" | select -ExpandProperty SamAccountName
    
    ##############################################
    #Confirms you have the correct user selected.#
    ##############################################
        if($UPN -ne $null){
            $ButtonType = [System.Windows.MessageBoxButton]::OKCancel
            $MessageIcon = [System.Windows.MessageBoxImage]::Question
            $MessageBody = "Is this the correct user? $UPN 
        
If you click OK the script will execute and the user will be disabled."
            $MessageTitle = "Confirm user selection."        
            $Result = [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
            if($result -ne 'OK'){
                Write-Host "Incorrect selction made, exiting task." -ForegroundColor Yellow
                $upn = $null
                $x = $null
                break
            }
        }
        else{
            Write-Host "No selection made, exiting task." -ForegroundColor Yellow
            $UPN = $null            
            $x = $null
            break
        }
    
    ##################################################################################
    #Brings up a pop up window to select the site the terminated employee belongs to.#
    ##################################################################################
        $selectSite = [ordered]@{
        
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx" = "\\xxxxxxxxx\xxxxxxxxx\"
                "xxxxxxxxx"  = "\\xxxxxxxxx\xxxxxxxxx\"
        
            }
        $SelectedSite =  $selectSite | Out-GridView -OutputMode Single -Title 'Select a site...' | select -ExpandProperty Value
    
    ###########################################################################
    #Stages the employee's terminated employee archive based on site selection#
    ###########################################################################
        $SelectedSite = $SelectedSite + $UPN + " " + $xxxxxxxxxTicket
        New-Item -ItemType directory -Path ($SelectedSite + "\Home")
        New-Item -ItemType directory -Path ($SelectedSite + "\C")
        #New-Item -ItemType directory -Path ($SelectedSite + "\RDS")
        #New-Item -ItemType directory -Path ($SelectedSite + "\Cell")
        #New-Item -ItemType directory -Path ($SelectedSite + "\Exchange PST Archives")
    
    #####################################
    #Open file explorer to $SelectedSite#
    #####################################
        #Get-ChildItem -path "$SelectedSite"
    
    #########################
    #Disables the AD Account#
    #########################
        Disable-ADAccount -Identity $UPN
        Write-Host "$UPN is disabled" -ForegroundColor Yellow
        Get-ADUser -Identity $UPN | select Name,Enabled
    
    ############################
    #Prompts for reset password#
    ############################
        $Chars1 = [Char[]]"BDFGHKLMNPRSTVWZ"
        $Chars21 = [Char[]]"aeiou"
        $Chars22 = [Char[]]"bdfghkmnprstvwz"
        $Chars3 = [Char[]]"2345679"
        $Chars4 = [Char[]]"!@#$%"
        $P1 = ($Chars1 | Get-Random -Count 1) -join ""
        $P2 = ($Chars21 | Get-Random -Count 1) -join ""
        $P3 = ($Chars22 | Get-Random -Count 1) -join ""
        $P4 = ($Chars21 | Get-Random -Count 1) -join ""
        $P5 = ($Chars22 | Get-Random -Count 1) -join ""
        $P6 = ($Chars21 | Get-Random -Count 1) -join ""
        $P7 = ($Chars3 | Get-Random -Count 4) -join ""
        $P8 = ($Chars4 | Get-Random -Count 2) -join ""
        $Password = $P1 + $P2 + $P3 + $P4 + $P5 + $P6 + $P7 + $P8
        Write-Output $Password | clip    
        $ButtonType = [System.Windows.MessageBoxButton]::OKCancel
        $MessageIcon = [System.Windows.MessageBoxImage]::None
        $MessageBody = "Password will be reset to = $Password
Password has been copied to your cliboard!"
        $MessageTitle = "Confirm"
        [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
        $Password
        Set-ADAccountPassword -Identity $UPN -reset -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)    
        $ButtonType = [System.Windows.MessageBoxButton]::OKCancel
        $MessageIcon = [System.Windows.MessageBoxImage]::None
        $MessageBody = "$UPN password reset to $Password"
        $MessageTitle = "Confirm"
        [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
    
    ###########################################################
    #Outputs AD User Object info and group memberships to .txt#
    #This portion submitted by Lee Ta                         #
    ###########################################################
        $ADUserProperties1 = @(
            'Created',
            'Department',
            'Description',
            'DisplayName',
            'EmailAddress',
            'HomeDirectory',
            'HomeDrive',
            'Manager',
            'MemberOf',
            'Modified',
            'MobilePhone',
            'Office',
            'OfficePhone',
            'OtherName',
            'ScriptPath',
            'Surname',
            'Title'
        )
        $ADUserProperties2 = @(
            'DisplayName',
            'Name',
            'SamAccountName',
            'GivenName'
            'OtherName',
            'Surname',
            'EmailAddress',
            'Title',
            'Department',
            'Office',
            'OfficePhone',
            'MobilePhone',
            'Manager',
            'ScriptPath',
            'HomeDrive',
            'HomeDirectory',
            'Description',
            'SID',
            'Created',       
            'Modified',
            @{n="MemberOf";e={($_.memberof | %{(Get-ADGroup $_).sAMAccountName}) -join "`r`n"}}
        )
        Get-ADUser $UPN -properties $ADUserProperties1 | Select-Object $ADUserProperties2 | Out-File ($SelectedSite + "\ADUuser and Group Memberships.txt") -Width 100
    
    ######################################
    #Removes the user's group memberships#
    ######################################
        foreach ($Group in (Get-Aduser $UPN -Properties MemberOf | Select MemberOf).MemberOf){
            Remove-ADGroupMember -Identity $Group -Members $UPN -Confirm:$false
        }
    
    ##################################################################
    #Move Employee to the respective site's 'xxxxxxxxx' OU#
    ##################################################################
        Get-ADUser $UPN | Move-ADObject -TargetPath 'OU=xxxxxxxxx,DC=xxxxxxxxx,DC=xxxxxxxxx'
    
    #########################################################
    #Appends 'TERMINATED MM-DD-YYYY' to Employee Description#
    #########################################################
        Set-ADUser -Identity $UPN -Description ((Get-ADUser -Identity $UPN -Properties Description | Select Description | Format-Table -HideTableHeaders | Out-String).trim() + " - TERMINATED " + (Get-Date -Format "MM-dd-yyyy"))
    
    ###########################################################################################################################################################################################
    #If employee had direct reports, for each direct report, individually prompts for UPN of that direct report's new manager, updates manager in direct report's Organization tab accordingly#
    #Once complete, clears the terminated employee's manager field                                                                                                                            #
    ###########################################################################################################################################################################################
        $DirectReports = Get-ADuser -Identity $UPN -Properties directreports, displayname | select -ExpandProperty DirectReports 
        foreach($DirectReport in $DirectReports){
            Do {
                $newManager = Get-ADUser -Filter * -Properties SamAccountName | select SamAccountName | Out-GridView -PassThru -Title "This User had direct reports, select a new manager." | select -ExpandProperty SamAccountName
                $ButtonType = [System.Windows.MessageBoxButton]::YesNo
                $MessageIcon = [System.Windows.MessageBoxImage]::Question
                $MessageBody = "Are you sure you want to set $newManager as the new Manager?"
                $MessageTitle = "Set the new manager."         
                $ManagerCheck = [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
                    if($ManagerCheck -eq "Yes"){
                        Set-ADUser -Identity $DirectReport -Manager $newManager
                        $newManager = $null                       
                    }
                    Else{
                        Write-Host "Going back to manager selection screen. Select a new manager." -ForegroundColor
                    }
            } 
            Until ($ManagerCheck -eq "Yes")
        }
            Set-ADUser -Identity $UPN -Clear Manager
            $x = $null
            Write-Host "$UPN has been terminated, please review the details below" -ForegroundColor Yellow
            Get-ADUser -Identity $UPN -Properties Manager, Description, MemberOf | select Name, Enabled, DistinguishedName, Manager, Description, MemberOf | Format-List
            $UPN = $null
    }
    
    #############################################################################################
    #If the employee selects the License an Employee with Office 365 task this code will execute#
    #############################################################################################
    if ($x -eq "License an Employee with Office 365"){
        $OfficeSite = [ordered]@{    
            "xxxxxxxxx" = "xx"
            "xxxxxxxxx" = "xx"
            "xxxxxxxxx" = "xx"
            "xxxxxxxxx" = "xx"
            "xxxxxxxxx" = "xx"
            "xxxxxxxxx" = "xx"
            "xxxxxxxxx" = "xx"
            "xxxxxxxxx" = "xx"
            "xxxxxxxxx" = "xx"
            "Maghria"  = "xx"    
        }
        $SelectedOfficeSite =  $OfficeSite | Out-GridView -OutputMode Single  -Title 'Select a site...' | select -ExpandProperty Value
        Get-MsolAccountSku | Format-Table
        $O365User = Get-MsolUser -EnabledFilter EnabledOnly -DomainName "xxxxxxxxxxxxxx.com" -MaxResults 970 -UnlicensedUsersOnly | Out-GridView -OutputMode Single | select -ExpandProperty UserPrincipalName
        $xxxxxxxxxO365Licenses = New-MsolLicenseOptions -AccountSkuId xxxxxxxxxxxxxxgcc:ENTERPRISEPACK_xxxxxxxx -DisabledPlans POWERAPPS_O365_P2_xxxxxxxx,FLOW_O365_P2_xxxxxxxx,FORMS_PLAN_E3_AR_xxxxxxxx,TEAMS_AR_xxxxxxxx,PROJECTWORKMANAGEMENT,STREAM_O365_E3,MCOSTANDARD,SHAREPOINTWAC,SHAREPOINTENTERPRISE
            if($O365User -ne $null){
                Set-MsolUser -UserPrincipalName $O365User -UsageLocation $SelectedOfficeSite
                Set-MsolUserLicense -UserPrincipalName $O365User -AddLicenses xxxxxxxxxxxxxxgcc:ENTERPRISEPACK_xxxxxxxx,xxxxxxxxxxxxxxgcc:EMS_xxxxxxxx -LicenseOptions $xxxxxxxxxO365Licenses
                (Get-MsolUser -UserPrincipalName $O365User).licenses | select AccountSkuID | Format-Table
                $O365User = $null
                $x = $null
            }
            else{
            write-host "You did not make a selection. Going back to task menu" -ForegroundColor Yellow
            $x = $null
            }
    }
    
    #################################################################################################
    #If the employee selects the Remove an Employees Office 365 Licenses task this code will execute#
    #################################################################################################
    if ($x -eq "Remove an Employees Office 365 Licenses"){
        $O365User = Get-MsolUser -EnabledFilter EnabledOnly -DomainName "xxxxxxxxxxxxxx.com" -MaxResults 970 | where {$_.isLicensed -eq $true} | Out-GridView -OutputMode Single | select -ExpandProperty UserPrincipalName
            if($O365User -ne $null){
                Set-MsolUserLicense -UserPrincipalName $O365User -RemoveLicenses xxxxxxxxxxxxxxgcc:ENTERPRISEPACK_xxxxxxxx,xxxxxxxxxxxxxxgcc:EMS_xxxxxxxx
                Get-MsolUser -UserPrincipalName $O365User | Format-Table
                Get-MsolAccountSku | Format-Table
                $O365User = $null
                $x = $null
            }
            else{
            write-host "You did not make a selection. Going back to task menu" -ForegroundColor Yellow
            $x = $null
            }
    }

    ##################################################################################################
    #If the employee selects the Put an Employee Email on Litigation Hold task this code will execute#
    ##################################################################################################
    if ($x -eq "Put an Employee Email on Litigation Hold"){
        $O365User = Get-MsolUser -EnabledFilter EnabledOnly -DomainName "xxxxxxxxxxxxxx.com" -MaxResults 970 | where {$_.isLicensed -eq $true} | Out-GridView -OutputMode Single | select -ExpandProperty UserPrincipalName
            if($O365User -ne $null){
                Set-Mailbox $O365User -LitigationHoldEnabled $true
                Get-Mailbox $O365User | FL LitigationHoldEnabled
                $O365User = $null
                $x = $null
            }
            else{
            write-host "You did not make a selection. Going back to task menu." -ForegroundColor Yellow
            $x = $null
            }        
    }
    
    ####################################################################################
    #If the employee selects the Generate a random password task this code will execute#
    ####################################################################################
    if($x -eq "Generate a random password"){
        $Chars1 = [Char[]]"BDFGHKLMNPRSTVWZ"
        $Chars21 = [Char[]]"aeiou"
        $Chars22 = [Char[]]"bdfghkmnprstvwz"
        $Chars3 = [Char[]]"2345679"
        $Chars4 = [Char[]]"!@#$%"
        $P1 = ($Chars1 | Get-Random -Count 1) -join ""
        $P2 = ($Chars21 | Get-Random -Count 1) -join ""
        $P3 = ($Chars22 | Get-Random -Count 1) -join ""
        $P4 = ($Chars21 | Get-Random -Count 1) -join ""
        $P5 = ($Chars22 | Get-Random -Count 1) -join ""
        $P6 = ($Chars21 | Get-Random -Count 1) -join ""
        $P7 = ($Chars3 | Get-Random -Count 4) -join ""
        $P8 = ($Chars4 | Get-Random -Count 2) -join ""
        $Password = $P1 + $P2 + $P3 + $P4 + $P5 + $P6 + $P7 + $P8
        Write-Output $Password | clip
        $ButtonType = [System.Windows.MessageBoxButton]::OKCancel
        $MessageIcon = [System.Windows.MessageBoxImage]::None
        $MessageBody = "Password Generated = $Password
Password has been copied to your cliboard!"
        $MessageTitle = "Confirm"
        [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
        $Password
        $x = $null
    }
    
    ####################################################################################
    #If the employee selects the Reset an Employee Password task this code will execute#
    ####################################################################################
    If($x -eq "Reset an Employee Password"){    
        $Chars1 = [Char[]]"BDFGHKLMNPRSTVWZ"
        $Chars21 = [Char[]]"aeiou"
        $Chars22 = [Char[]]"bdfghkmnprstvwz"
        $Chars3 = [Char[]]"2345679"
        $Chars4 = [Char[]]"!@#$%"
        $P1 = ($Chars1 | Get-Random -Count 1) -join ""
        $P2 = ($Chars21 | Get-Random -Count 1) -join ""
        $P3 = ($Chars22 | Get-Random -Count 1) -join ""
        $P4 = ($Chars21 | Get-Random -Count 1) -join ""
        $P5 = ($Chars22 | Get-Random -Count 1) -join ""
        $P6 = ($Chars21 | Get-Random -Count 1) -join ""
        $P7 = ($Chars3 | Get-Random -Count 4) -join ""
        $P8 = ($Chars4 | Get-Random -Count 2) -join ""
        $Password = $P1 + $P2 + $P3 + $P4 + $P5 + $P6 + $P7 + $P8
        Write-Output $Password | clip    
        $ButtonType = [System.Windows.MessageBoxButton]::OKCancel
        $MessageIcon = [System.Windows.MessageBoxImage]::None
        $MessageBody = "Password Generated = $Password
Password has been copied to your cliboard!"
        $MessageTitle = "Confirm"
        [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
        $Password
    
        $user = get-aduser -Filter * | select samaccountname | Out-GridView -OutputMode Single | select -ExpandProperty samAccountName
            if($user -ne $null){
                Set-ADAccountPassword -Identity $user -reset -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
                Set-ADUser -Identity $user -ChangePasswordAtLogon $true
                $ButtonType = [System.Windows.MessageBoxButton]::OKCancel
                $MessageIcon = [System.Windows.MessageBoxImage]::None
                $MessageBody = "$user password reset to $Password"
                $MessageTitle = "Confirm"
                [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
                $user = $null
                $x = $null
            }
            else{
            write-host "You did not make a selection. Going back to task menu." -ForegroundColor Yellow
            $x = $null
            }
    }

    #####################################################################################
    #If the employee selects the Unlock an Employees account task this code will execute#
    #####################################################################################
    if ($x -eq "Unlock an Employees account"){
        $lockedAccount = Search-ADAccount -LockedOut -UsersOnly | select SamAccountName | Out-GridView -OutputMode Single -Title "Select an account to unlock." | select -ExpandProperty SamAccountName
            if($lockedAccount -ne $null){
                Unlock-ADAccount -Identity $lockedAccount
                $lockedAccount = $null
                $x = $null
            }
            else{
            write-host "You did not make a selection. Going back to task menu." -ForegroundColor Yellow
            $x = $null
            }  
    }

    #######################################################################
    #If no selection is made or if you completed a task this will execute.#
    #######################################################################
    if ($x -eq $null){
        $ButtonType = [System.Windows.MessageBoxButton]::YesNo
        $MessageIcon = [System.Windows.MessageBoxImage]::Question
        $MessageBody = "Would you like to perform another task?"
        $MessageTitle = "Perform another task?"
         
        $taskcheck = [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
            if($taskcheck -eq 'Yes'){
                    Write-Host "Bringing up the task menu." -ForegroundColor Yellow
                    $x = $null
            }
            else{
                    Write-Host "Closing HelpDesk-Tools." -ForegroundColor Yellow
            }
    }
}
Until($taskcheck -eq 'No')