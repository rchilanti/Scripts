<p align="center">
    <strong>Para conseguir executar os scripts, é necessário instalar o PowerCLI, via PowerShell.</strong>
</p>
<br>
<br>
<p align="center">
    <strong>Sempre execute o PowerShell como administrador</strong>
</p>
<br>
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

Install-Module -Name VMware.PowerCLI

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

Import-Module VMware.VimAutomation.Core

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Set-PowerCLIConfiguration -Scope User -InvalidCertificateAction Prompt -Confirm:$false
<br>
<br>
<p align="center">
    <strong>Após realizar os passos acima, faça um teste de conexão no seu vCenter para validar que tudo ocorrerá bem.</strong>
</p>
<br>
Connect-VIServer -Server "hostnamedoseuvcenter" -User "usuario" -Password "senha"
