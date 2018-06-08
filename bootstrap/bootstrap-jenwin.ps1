Start-Transcript -Path C:\bootstrap-jenwin.log

Write-Host "Setup Jenkins Build Node for $RemoteHostName"

Write-Host "Installing Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Host "Installing NotePad++"
choco install notepadplusplus.install

Write-Host "Installing 7zip"
choco install 7zip.install