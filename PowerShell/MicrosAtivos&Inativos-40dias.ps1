# Micros inativos a mais de 40 dias
dsquery computer -inactive 5.7 -limit 0 > C:\Temp\Scripts\micros_inativos_40Dias.txt


# Micros ativos a mais de 40 dias
$all = dsquery computer -limit 0
$inactive = dsquery computer -inactive 5.7 -limit 0
$active = $all | Where-Object { $inactive -notcontains $_ }
$active | Out-File -FilePath "C:\Temp\Scripts\micros_ativos_40Dias.txt" -Encoding UTF8
