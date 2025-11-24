# Conectar silenciosamente
$null = Connect-VIServer -Server "hostnamedoesxiouvcenter" `
    -User "usuariodoesxiouvcenter" `
    -Password "senhadoesxiouvcenter"

#Arquivo da lista das VMs que deseja deletar os snapshots
#Deve colocar uma abaixo da outra ex:
#W11-001
#W11-002
#W11-003
$VMs = Get-Content C:\Temp\Scripts\VMware\RemoveSnapshots\vms-snaps.txt

# Definir o limite de quantidade de remocao em paralelo
$batchSize = 5
$index = 0

while ($index -lt $VMs.Count) {

    $batch = $VMs[$index..([Math]::Min($index + $batchSize - 1, $VMs.Count - 1))]

    Write-Host ""
    Write-Host "==================================================" -ForegroundColor Yellow
    Write-Host "   Processando lote $([int]($index / $batchSize) + 1)" -ForegroundColor Yellow
    Write-Host "   VMs: $($batch -join ', ')" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Yellow
    Write-Host ""

    # Lista para armazenar as tasks do lote
    $tasks = @()

    foreach ($vm in $batch) {

        Write-Host " - Removendo snapshots da VM: $vm..." -ForegroundColor Blue

        # Iniciar task de deleção e armazenar
        $task = Get-VM $vm | Get-Snapshot | Remove-Snapshot -Confirm:$false -RunAsync

        if ($task) {
            $tasks += $task
        } else {
            Write-Host "     Nenhum snapshot encontrado." -ForegroundColor Yellow
        }
    }

    # Esperar todas tasks do lote terminarem
    if ($tasks.Count -gt 0) {
        Write-Host ""
        Write-Host " Aguardando conclusao de todas as tasks do lote..." -ForegroundColor Magenta
        Wait-Task -Task $tasks | Out-Null
        Write-Host " Lote concluido." -ForegroundColor Green
    } else {
        Write-Host " Nenhuma task para aguardar neste lote." -ForegroundColor Yellow
    }

    # Avançar para o próximo lote
    $index += $batchSize
}

Write-Host ""
Write-Host "Processo concluido para todas as VMs da lista." -ForegroundColor Green
Write-Host "=================================================="
