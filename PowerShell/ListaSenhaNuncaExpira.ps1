# Importa o módulo do Active Directory, caso ainda não esteja carregado
Import-Module ActiveDirectory

# Define o caminho do arquivo CSV para salvar os resultados
$caminhoCSV = "C:\Temp\Scripts\Usuarios_SenhaNuncaExpira.csv"

# Obtém todos os usuários com a opção "PasswordNeverExpires" ativada, incluindo o status da conta
$usuariosComPasswordNeverExpires = Get-ADUser -Filter {PasswordNeverExpires -eq $true} -Property SamAccountName, Name, Enabled | 
    Select-Object Name, SamAccountName, @{Name="Status";Expression={if ($_.Enabled) {"Ativa"} else {"Desativada"}}}

# Exporta os dados para um arquivo CSV
$usuariosComPasswordNeverExpires | Export-Csv -Path $caminhoCSV -NoTypeInformation -Encoding UTF8

Write-Output "Relatório gerado em $caminhoCSV"
