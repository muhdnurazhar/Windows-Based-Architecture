New-ADOrganizationalUnit Managers
New-ADOrganizationalUnit Competitors
New-ADOrganizationalUnit Visitors

New-ADGroup -Path "ou=Managers,dc=wsmb2026,dc=my" -GroupCategory Security -GroupScope Global WSMB_Managers
New-ADGroup -Path "ou=Competitors,dc=wsmb2026,dc=my" -GroupCategory Security -GroupScope Global WSMB_Competitors
New-ADGroup -Path "ou=Visitors,dc=wsmb2026,dc=my" -GroupCategory Security -GroupScope Global WSMB_Visitors


param (
    [int]$count = 20
)

for ($i = 1; $i -le $count; $i++){
#managers
    try {
    New-Item -ItemType Directory -Path \\hq-file\homes\mgr$i -Force
    New-ADUser -Name mgr$i -AccountPassword (ConvertTo-SecureString -String Skills@39 -AsPlainText -Force) -CannotChangePassword $true -ChangePasswordAtLogon $false -DisplayName mgr$i -Enabled $true -GivenName mgr$i -HomeDirectory \\hq-file\homes\mgr$i -HomeDrive H: -PasswordNeverExpires $true -Path "ou=managers,dc=wsmb2026,dc=my" -SamAccountName mgr$i -Surname mgr$i -UserPrincipalName "mgr$i@wsmb2026.my"
    Add-ADGroupMember -Identity WSMB_Managers -Members mgr$i
    }
    catch { Write-Host mgr$i exists, skipped }
#competitors
    try {
    New-Item -ItemType Directory -Path \\hq-file\homes\cpt$i -Force
    New-ADUser -Name cpt$i -AccountPassword (ConvertTo-SecureString -String Skills@39 -AsPlainText -Force) -CannotChangePassword $true -ChangePasswordAtLogon $false -DisplayName cpt$i -Enabled $true -GivenName cpt$i -HomeDirectory \\hq-file\homes\cpt$i -HomeDrive H: -PasswordNeverExpires $true -Path "ou=competitors,dc=wsmb2026,dc=my" -SamAccountName cpt$i -Surname cpt$i -UserPrincipalName "cpt$i@wsmb2026.my"
    Add-ADGroupMember -Identity WSMB_competitors -Members cpt$i
    }
    catch { Write-Host cpt$i exists, skipped }
#visitors
    try {
    New-Item -ItemType Directory -Path \\hq-file\homes\vis$i -Force
    New-ADUser -Name vis$i -AccountPassword (ConvertTo-SecureString -String Skills@39 -AsPlainText -Force) -CannotChangePassword $true -ChangePasswordAtLogon $false -DisplayName vis$i -Enabled $true -GivenName vis$i -HomeDirectory \\hq-file\homes\vis$i -HomeDrive H: -PasswordNeverExpires $true -Path "ou=visitors,dc=wsmb2026,dc=my" -SamAccountName vis$i -Surname vis$i -UserPrincipalName "vis$i@wsmb2026.my"
    Add-ADGroupMember -Identity WSMB_visitors -Members vis$i
    }
    catch { Write-Host vis$i exists, skipped }

}
