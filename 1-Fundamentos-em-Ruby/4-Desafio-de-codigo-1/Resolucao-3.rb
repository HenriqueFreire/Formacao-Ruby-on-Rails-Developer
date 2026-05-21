# Resolução do Desafio 3: Validação de Saque Bancário

# Objetivo: Validar se há saldo suficiente para realizar um saque e atualizar o saldo.
# Entrada: 
# 1. Saldo Total (Inteiro)
# 2. Valor do Saque (Inteiro)

def realizar_saque
  # Lendo as entradas do usuário em linhas separadas
  saldo_total = gets.chomp.to_i
  valor_saque = gets.chomp.to_i

  # Regra de Negócio: Verificar se o saldo é suficiente
  if saldo_total >= valor_saque
    # Sucesso: Subtrai o valor e calcula o novo saldo
    novo_saldo = saldo_total - valor_saque
    puts "Saque realizado com sucesso. Novo saldo: #{novo_saldo}"
  else
    # Falha: Saldo insuficiente
    puts "Saldo insuficiente. Saque nao realizado!"
  end
end

# Executa o método
realizar_saque
