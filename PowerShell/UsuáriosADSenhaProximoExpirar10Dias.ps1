# Número de dias antes do vencimento para alerta
$DiasParaExpirar = 10

# Obtém os usuários cujo atributo 'PasswordNeverExpires' está desativado
$usuarios = Get-ADUser -Filter {Enabled -eq $true -and PasswordNeverExpires -ne $true} -Properties "Name", "msDS-UserPasswordExpiryTimeComputed" 

# Lista para armazenar os objetos de saída
$resultado = foreach ($user in $usuarios) {
    $expira = [datetime]::FromFileTime($user.'msDS-UserPasswordExpiryTimeComputed')
    $diasRestantes = ($expira - (Get-Date)).Days

    if ($diasRestantes -le $DiasParaExpirar -and $diasRestantes -ge 0) {
        [PSCustomObject]@{
            Nome          = $user.Name
            ExpiraEm      = $expira
            DiasRestantes = $diasRestantes
        }
    }
}

# Ordena, exibe na tela e exporta para CSV
$resultado | Sort-Object DiasRestantes | Tee-Object -Variable saida | Format-Table -AutoSize
$saida | Export-Csv -Path "C:\Temp\Scripts\UsuariosSenhaProximaDeExpirar.csv" -NoTypeInformation -Encoding UTF8
