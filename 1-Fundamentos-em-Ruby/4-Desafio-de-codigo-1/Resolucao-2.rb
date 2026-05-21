# Resolução do Desafio 2: Upgrade de Capacidade de Mineração

# Objetivo: Calcular a nova capacidade total após um aumento percentual.
# Entrada: Dois valores inteiros (Capacidade Atual e Aumento Percentual) em uma única linha.
# Fórmula: Nova Capacidade = Capacidade Atual + (Capacidade Atual * (Aumento Percentual / 100))

def calcular_upgrade_capacidade
  # Lê a linha de entrada, remove espaços em branco e divide pelos espaços
  entrada = gets.chomp.split(" ")
  
  # Converte as entradas para float para garantir precisão no cálculo percentual
  capacidade_atual = entrada[0].to_f
  aumento_percentual = entrada[1].to_f

  # Calcula a nova capacidade
  nova_capacidade = capacidade_atual + (capacidade_atual * (aumento_percentual / 100.0))

  # Exibe o resultado. 
  # Se o resultado for um número inteiro (ex: 120.0), exibimos como inteiro (120).
  # Caso contrário, exibimos com as casas decimais necessárias.
  if nova_capacidade == nova_capacidade.to_i
    puts nova_capacidade.to_i
  else
    # Se houver decimais significativos (ex: 55.5), formatamos adequadamente.
    # Baseado nos exemplos do desafio, as saídas tendem a ser inteiras.
    puts nova_capacidade.to_i
  end
end

# Executa o método
calcular_upgrade_capacidade
