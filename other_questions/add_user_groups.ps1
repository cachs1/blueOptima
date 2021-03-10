### ADD THIS VARIABLES DEPENDING YOUR INFRASTRUCTURE
$path = ''
$mail = ''
$smtp = ''
$portSmtp = 
$administrator = ' '
###

$givename = Read-Host -Prompt 'Give name of user'
$surname = Read-Host -Prompt 'Give surname of user'
$name = "$givename $surname"
$sam = Read-Host -Prompt 'Type user id for log in'
do{
	$samExists = Get-ADUser -LDAPFilter "(sAMAccountName=$sam)"
	if ($samExists -ne $Null){
		$sam = Read-Host "Username $sam already exists please try another username"
	}
  }
Until  ($samExists -eq $Null)

$passwd = Read-Host -Prompt 'Add password: '

New-AdUser -GivenName $givename -Name $name -Path $path -Surname $surname -SamAccountName $sam -UserPrincipalName "$sam$mail" -Enabled $true -PasswordNeverExpires $true -AccountPassword (ConvertTo-SecureString $passwd -AsPlainText -force) -PassThru
Read-Host -Prompt "$sam user created sucesfully, press enter to continue"
$lista = Get-ADGroup -Filter * | select -ExpandProperty Name
$groups = ""
Do {
$strQuit = Read-Host -Prompt "Want to add to a group [Y] o [N]"
    if ($strQuit -eq "Y"){
        Do {
            Write-Output $lista
            $valExists = Read-Host -Prompt "Name of group" 
            if ($lista.Contains($valExists) = $true){ 
                Add-ADGroupMember -Identity $valExists -Members $sam
                Write-Output "$sam inserted into $valExists"
                $groups = $groups + " " + $valExists
                $i = 1 
            }else{
                Write-Output "group does not exist"
            }
        } Until ($i = 1)
    }
}
Until ($strQuit -eq "N")

Write-Output "$name with user $sam joined: $groups"

Send-MailMessage -To $administrator -From $email -Subject "Usuer $sam succesfully" -Body "$name with username $sam was added sucessfully to: $groups" -SmtpServer $smtp -Port $portSmtp

