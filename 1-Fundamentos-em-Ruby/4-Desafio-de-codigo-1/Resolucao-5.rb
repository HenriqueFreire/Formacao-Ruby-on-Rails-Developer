# Resolução do Desafio 5: Cálculo de Juros Compostos

# Objetivo: Calcular o valor final de um investimento baseado em juros compostos.
# Fórmula: A = P * (1 + i) ^ n
# Onde:
# P = Valor Inicial
# i = Taxa de Juros (ex: 0.08)
# n = Período (anos)

# Lendo as entradas sequencialmente
valor_inicial = gets.to_f
taxa_juros = gets.to_f
periodo = gets.to_i

# Cálculo de Juros Compostos
# Em Ruby, o operador de potência é '**'
valor_final = valor_inicial * ((1 + taxa_juros) ** periodo)

# Exibição do resultado formatado com duas casas decimais
# Formato: "Valor final do investimento: R$ XX.XX"
puts "Valor final do investimento: R$ #{'%.2f' % valor_final}"
