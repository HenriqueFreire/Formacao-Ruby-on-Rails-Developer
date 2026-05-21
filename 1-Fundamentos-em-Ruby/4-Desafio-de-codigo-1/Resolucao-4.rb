# Resolução do Desafio 4: Registro de Depósitos Bancários

# Lendo o valor de entrada
valor = gets.to_f

if valor > 0
  puts "Deposito realizado com sucesso!"
  # Formatação rigorosa para duas casas decimais, conforme exemplos
  puts "Saldo atual: R$ #{'%.2f' % valor}"
elsif valor == 0
  puts "Encerrando o programa..."
else
  puts "Valor invalido! Digite um valor maior que zero."
end
