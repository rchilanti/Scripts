#Script para verificar em qual folder do vCenter a VM se encontra

#Alterar para o hostname do seu vcenter
param(
  [string]  $vCenter1    = "vc01", 
	[string]  $vCenter2    = "vc02",	
	[string]  $vCenter3    = "vc03",	
	[string]  $vCenter4    = "vc04",	
	[string]  $vCenter5    = "vc05",	
    [string]$OutputPath = "C:\Temp\Scripts\VMware\Inventario\Folder_Todas_VMs.xlsx"
)

#----------------------vCenter1----------------------#
Write-Host "Conectando ao vCenter $vCenter1..." -ForegroundColor Green
Connect-VIServer -Server $vCenter1

Write-Host "Coletando todas as VMs do $vCenter1..." -ForegroundColor Cyan

$AllVMs = Get-VM

$report = $AllVMs | Select-Object `
    Name,
    @{N="Folder";      E={$_.Folder.Name}},
    @{N="Cluster";     E={ (Get-Cluster -VM $_).Name }},
    @{N="OS";          E={$_.ExtensionData.Config.GuestFullName}},
    @{N="PowerState";  E={$_.PowerState}},
    @{N="ToolsStatus"; E={$_.ExtensionData.Guest.ToolsStatus}}

# Exporta em Excel
$report | Export-Excel -Path $OutputPath -WorksheetName "vc01" -AutoSize -BoldTopRow -AutoFilter


Write-Host "-----------------------------------------"

#----------------------vCenter2----------------------#
Write-Host "Conectando ao vCenter $vCenter2..." -ForegroundColor Green
Connect-VIServer -Server $vCenter2

Write-Host "Coletando todas as VMs do $vCenter2..." -ForegroundColor Cyan

$AllVMs = Get-VM

$report = $AllVMs | Select-Object `
    Name,
    @{N="Folder";      E={$_.Folder.Name}},
    @{N="Cluster";     E={ (Get-Cluster -VM $_).Name }},
    @{N="OS";          E={$_.ExtensionData.Config.GuestFullName}},
    @{N="PowerState";  E={$_.PowerState}},
    @{N="ToolsStatus"; E={$_.ExtensionData.Guest.ToolsStatus}}

# Exporta em Excel
$report | Export-Excel -Path $OutputPath -WorksheetName "vc02" -AutoSize -BoldTopRow -AutoFilter


Write-Host "-----------------------------------------"

#----------------------vCenter3----------------------#
Write-Host "Conectando ao vCenter $vCenter3..." -ForegroundColor Green
Connect-VIServer -Server $vCenter3

Write-Host "Coletando todas as VMs do $vCenter3..." -ForegroundColor Cyan

$AllVMs = Get-VM

$report = $AllVMs | Select-Object `
    Name,
    @{N="Folder";      E={$_.Folder.Name}},
    @{N="Cluster";     E={ (Get-Cluster -VM $_).Name }},
    @{N="OS";          E={$_.ExtensionData.Config.GuestFullName}},
    @{N="PowerState";  E={$_.PowerState}},
    @{N="ToolsStatus"; E={$_.ExtensionData.Guest.ToolsStatus}}

# Exporta em Excel
$report | Export-Excel -Path $OutputPath -WorksheetName "vc03" -AutoSize -BoldTopRow -AutoFilter


Write-Host "-----------------------------------------"

#----------------------vCenter4----------------------#
Write-Host "Conectando ao vCenter $vCenter4..." -ForegroundColor Green
Connect-VIServer -Server $vCenter4

Write-Host "Coletando todas as VMs do $vCenter4..." -ForegroundColor Cyan

$AllVMs = Get-VM

$report = $AllVMs | Select-Object `
    Name,
    @{N="Folder";      E={$_.Folder.Name}},
    @{N="Cluster";     E={ (Get-Cluster -VM $_).Name }},
    @{N="OS";          E={$_.ExtensionData.Config.GuestFullName}},
    @{N="PowerState";  E={$_.PowerState}},
    @{N="ToolsStatus"; E={$_.ExtensionData.Guest.ToolsStatus}}

# Exporta em Excel
$report | Export-Excel -Path $OutputPath -WorksheetName "vc04" -AutoSize -BoldTopRow -AutoFilter


Write-Host "-----------------------------------------"

#----------------------vCenter5----------------------#
Write-Host "Conectando ao vCenter $vCenter5..." -ForegroundColor Green
Connect-VIServer -Server $vCenter5

Write-Host "Coletando todas as VMs do $vCenter5..." -ForegroundColor Cyan

$AllVMs = Get-VM

$report = $AllVMs | Select-Object `
    Name,
    @{N="Folder";      E={$_.Folder.Name}},
    @{N="Cluster";     E={ (Get-Cluster -VM $_).Name }},
    @{N="OS";          E={$_.ExtensionData.Config.GuestFullName}},
    @{N="PowerState";  E={$_.PowerState}},
    @{N="ToolsStatus"; E={$_.ExtensionData.Guest.ToolsStatus}}

# Exporta em Excel
$report | Export-Excel -Path $OutputPath -WorksheetName "vc05" -AutoSize -BoldTopRow -AutoFilter


Write-Host "-----------------------------------------"
Write-Host "Inventario gerado em: $OutputPath" -ForegroundColor Green

Disconnect-VIServer -Server $vCenter1 -Confirm:$false | Out-Null
Disconnect-VIServer -Server $vCenter2 -Confirm:$false | Out-Null
Disconnect-VIServer -Server $vCenter3 -Confirm:$false | Out-Null
Disconnect-VIServer -Server $vCenter4 -Confirm:$false | Out-Null
Disconnect-VIServer -Server $vCenter5 -Confirm:$false | Out-Null
Write-Host "Desconectado de todos os vCenters" -ForegroundColor Yellow
