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
<br>
Install-Module -Name VMware.PowerCLI
<br>
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
<br>
Import-Module VMware.VimAutomation.Core
<br>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
<br>
Set-PowerCLIConfiguration -Scope User -InvalidCertificateAction Prompt -Confirm:$false
<br>
<br>
<p align="center">
    <strong>Após realizar os passos acima, faça um teste de conexão no seu vCenter para validar que tudo ocorrerá bem.</strong>
</p>
<br>
Connect-VIServer -Server "hostnamedoseuvcenter" -User "usuario" -Password "senha"
