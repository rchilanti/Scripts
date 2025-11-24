# Conectar nos vCenters
Write-Host "Conectando nos vCenters" -ForegroundColor Blue
Connect-VIServer -Server "vc01" -User "Username" -Password "passwd" | Select-Object Name
Connect-VIServer -Server "vc02" -User "Username" -Password "passwd" | Select-Object Name
Connect-VIServer -Server "vc03" -User "Username" -Password "passwd" | Select-Object Name
Connect-VIServer -Server "vc04" -User "Username" -Password "passwd" | Select-Object Name
Connect-VIServer -Server "vc05" -User "Username" -Password "passwd" | Select-Object Name

$data = Get-Date -Format "dd-MM-yyyy"
$path = "C:\Temp\Scripts\VMware\ListaVMsSnapshots\Snapshots-$data.xlsx"

# Listar VMs com snapshots em cada vCenter
Write-Host "Exportando lista do vc01..." -ForegroundColor Blue
Get-VM -Server vc01 | Get-Snapshot | Select-Object VM, Name, @{N="Created";E={$_.Created.ToString("dd/MM/yyyy")}} | Export-Excel -Path $path -WorksheetName "vc01" -AutoSize -BoldTopRow

Write-Host "Exportando lista do vc02..." -ForegroundColor Blue
Get-VM -Server vc02 | Get-Snapshot | Select-Object VM, Name, @{N="Created";E={$_.Created.ToString("dd/MM/yyyy")}} | Export-Excel -Path $path -WorksheetName "vc02" -AutoSize -BoldTopRow

Write-Host "Exportando lista do vc03..." -ForegroundColor Blue
Get-VM -Server vc03 | Get-Snapshot | Select-Object VM, Name, @{N="Created";E={$_.Created.ToString("dd/MM/yyyy")}} | Export-Excel -Path $path -WorksheetName "vc03" -AutoSize -BoldTopRow

Write-Host "Exportando lista do vc04..." -ForegroundColor Blue
Get-VM -Server vc04 | Get-Snapshot | Select-Object VM, Name, @{N="Created";E={$_.Created.ToString("dd/MM/yyyy")}} | Export-Excel -Path $path -WorksheetName "vc04" -AutoSize -BoldTopRow

Write-Host "Exportando lista do vc05..." -ForegroundColor Blue
Get-VM -Server vc05 | Get-Snapshot | Select-Object VM, Name, @{N="Created";E={$_.Created.ToString("dd/MM/yyyy")}} | Export-Excel -Path $path -WorksheetName "vc05" -AutoSize -BoldTopRow

Write-Host "Lista de VMs com snapshot exportado com sucesso em $path" -ForegroundColor Green
Write-Host "=================================================="
#Desconecta de todos os vCenters
Disconnect-VIServer -Server "vc01" -Confirm:$false
Disconnect-VIServer -Server "vc02" -Confirm:$false
Disconnect-VIServer -Server "vc03" -Confirm:$false
Disconnect-VIServer -Server "vc04" -Confirm:$false
Disconnect-VIServer -Server "vc05" -Confirm:$false

Write-Host "Desconectado de todos os vCenters" -ForegroundColor Yellow
