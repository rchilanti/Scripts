# Caminho para o arquivo com a lista de hostnames/IPs
$hostnamesFile = "C:\Temp\hostnames.txt"

# Arquivo de saída para os resultados
$outputFile = "C:\Temp\resultado.txt"

# Limpa o arquivo de saída
"Verificação iniciada em $(Get-Date)" | Out-File -FilePath $outputFile

# Verifica se o arquivo de hostnames existe
if (!(Test-Path $hostnamesFile)) {
    Write-Host "O arquivo '$hostnamesFile' não foi encontrado." -ForegroundColor Red
    exit
}

# Lê os hostnames do arquivo
$hostnames = Get-Content -Path $hostnamesFile

# Loop pelos hostnames na lista
foreach ($hostname in $hostnames) {
    Write-Host "Verificando $hostname..."
    
    # Resolve o endereço IP do hostname
    try {
        $ipAddress = (Resolve-DnsName -Name $hostname -ErrorAction Stop).IPAddress
    } catch {
        $ipAddress = "Não resolvido"
    }

    # Testa conectividade com o hostname
    $pingResult = Test-Connection -ComputerName $hostname -Count 1 -Quiet

    # Adiciona os resultados ao arquivo de saída
    if ($pingResult) {
        "$hostname-$ipAddress-OK" | Out-File -FilePath $outputFile -Append
    } else {
        "$hostname-$ipAddress-NOK" | Out-File -FilePath $outputFile -Append
    }
}

# Exibe o resultado no terminal
Get-Content -Path $outputFile
Write-Host "Verificação concluída. Resultados salvos em '$outputFile'." -ForegroundColor Green
