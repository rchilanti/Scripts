#Para conseguir executar os scripts, é necessário instalar o PowerCLI, via PowerShell.

1-Sempre execute o PowerShell como administrador

Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

Install-Module -Name VMware.PowerCLI

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

Import-Module VMware.VimAutomation.Core

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Set-PowerCLIConfiguration -Scope User -InvalidCertificateAction Prompt -Confirm:$false

#Após realizar os passos acima, faça um teste de conexão no seu vCenter para validar que tudo ocorrerá bem.

Connect-VIServer -Server "hostnamedoseuvcenter" -User "usuario" -Password "senha"
