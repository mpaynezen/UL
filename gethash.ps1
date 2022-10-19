Set-ExecutionPolicy -ExecutionPolicy Unrestricted
if(!(Test-Path c:\ul\hash.csv))
{
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Script -Name Get-WindowsAutoPilotInfo -Force
mkdir c:\ul
Get-WindowsAutoPilotInfo -OutputFile c:\ul\hash.csv
$hash=import-csv c:\ul\hash.csv
$Serial=$hash.'Device Serial Number'
$hsh=$hash.'Hardware Hash'
$body=@{
	Computer=$env:computername
	Serial=$serial
	Hash=$hsh
	}
Invoke-RestMethod -uri https://hooks.zapier.com/hooks/catch/13601215/b0gqx0d/ -body $body
}
