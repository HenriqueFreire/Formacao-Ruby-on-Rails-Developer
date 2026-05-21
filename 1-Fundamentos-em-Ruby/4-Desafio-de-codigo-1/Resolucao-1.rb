# Resolução do Desafio 1: Taxa de Sucesso de Testes Automatizados

# O objetivo é receber dois números inteiros:
# 1. Número de testes bem-sucedidos
# 2. Número total de testes realizados

# O cálculo deve ser: (bem-sucedidos / total) * 100
# A saída deve ter duas casas decimais.

def calcular_taxa_sucesso
  # Lendo as entradas do usuário
  # No Ruby, o .to_f é essencial aqui para garantir que a divisão não seja inteira (o que resultaria em 0 se o numerador fosse menor)
  testes_bem_sucedidos = gets.chomp.to_f
  total_testes = gets.chomp.to_f

  # Cálculo da taxa
  taxa_sucesso = (testes_bem_sucedidos / total_testes) * 100

  # Exibindo o resultado formatado com 2 casas decimais
  # O formato "%.2f" garante as duas casas decimais conforme solicitado no Desafio-1.md
  puts "Taxa de sucesso: #{'%.2f' % taxa_sucesso}%"
end

# Executa a função
calcular_taxa_sucesso
