$wrongPassword = Get-Random # ignore
$username = whoami # ignore
$servername = "a11-dc-2" # enter dc name here or another servers name
$modulename = "ActiveDirectory" # this is the module that needs to be loaded for the action to change

    
function Lock-ADAccount{
    Write-Host -ForegroundColor Green "You failed, so I'm now locking your AD Account out.Nice try though!"
do {
    $password = ConvertTo-SecureString $wrongPassword -AsPlainText -Force
    $cred= New-Object System.Management.Automation.PSCredential ($username, $password )
    Enter-PSSession -ComputerName $servername -Credential $cred -ErrorAction SilentlyContinue
    
    
}
until ((Get-ADUser -Identity $env:USERNAME -Properties LockedOut).LockedOut)
 

                        }


function Start-HardcoreMode {
#params
    Param(
   [int] $hardcoreness
    )
#checking module loaded
    $ADLoaded = Get-Module -Name $modulename
        if ($ADLoaded -like "$modulename")
        { $moduleloaded = "yes" }
        else { $moduleloaded = "no"}
       

if ($hardcoreness -eq "1" -and $moduleloaded -eq "yes")
    {
    Write-Host -ForegroundColor Green "Enabling hardcore mode 1, be careful!"
    $ExecutionContext.InvokeCommand.CommandNotFoundAction = {Lock-ADAccount}
    }
if ($hardcoreness -eq "2" -and $moduleloaded -eq "yes")
    {
    Write-Host -ForegroundColor Green "Enabling hardcore mode 2, be careful!"
    $ExecutionContext.InvokeCommand.CommandNotFoundAction = {Disable-ADAccount -Identity $env:USERNAME}
    }
    if ($hardcoreness -eq "3" -and $moduleloaded -eq "yes")
    {
    Write-Host -ForegroundColor Green "Enabling hardcore mode 3, be careful!"
    $ExecutionContext.InvokeCommand.CommandNotFoundAction = {Stop-Computer -ComputerName "localhost"}
    }
if ($moduleloaded -eq "no") {
    Write-Host -ForegroundColor Red "$modulename is not loaded, please load and run me again"
    }
}

Start-HardcoreMode 2