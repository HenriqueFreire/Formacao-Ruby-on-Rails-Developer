# Criando Função para Validar CPF em Nossa Gem (Versão Refatorada)

# Nesta etapa, evoluímos o código anterior para uma abordagem mais idiomática 
# e elegante, utilizando recursos poderosos da linguagem Ruby (Clean Code).

# =============================================================================
# 1. IMPLEMENTAÇÃO REFATORADA (O JEITO RUBY DE FAZER)
# =============================================================================

module MinhaGemUtil
  class Validador
    def self.cpf_valido?(valor)
      # Limpeza inicial
      cpf = valor.to_s.gsub(/\D/, "")
      
      # Validação de tamanho e duplicidade em uma única linha
      return false unless cpf.length == 11 && cpf.chars.uniq.count > 1

      # Convertemos para array de inteiros para cálculos matemáticos
      numeros = cpf.chars.map(&:to_i)

      # MÉTODO REFINADO:
      # zip: Combina os números com seus respectivos pesos
      # sum: Calcula a soma ponderada diretamente
      
      # Cálculo do 1º Dígito Verificador (Peso 10 a 2)
      soma1 = numeros[0..8].zip(10.downto(2)).sum { |n, p| n * p }
      digito1 = (soma1 * 10 % 11) % 10

      # Cálculo do 2º Dígito Verificador (Peso 11 a 2)
      soma2 = numeros[0..9].zip(11.downto(2)).sum { |n, p| n * p }
      digito2 = (soma2 * 10 % 11) % 10

      # Comparação final retorna true ou false
      digito1 == numeros[9] && digito2 == numeros[10]
    end
  end
end

# =============================================================================
# 2. POR QUE ESTA VERSÃO É MELHOR?
# =============================================================================
# 1. Uso de Enumerable#zip: Pareia o array de números com o array de pesos gerado por downto.
# 2. Uso de Enumerable#sum: Elimina a necessidade de inicializar variáveis (soma = 0).
# 3. Matemática simplificada: A fórmula (soma * 10 % 11) % 10 resolve a regra do dígito 10 virar 0.
# 4. Legibilidade: Menos linhas de código para realizar a mesma tarefa complexa.

# =============================================================================
# 3. TESTANDO A REFATORAÇÃO
# =============================================================================

puts "--- Testando Validador Refatorado ---"

cpf_teste = "75163814041" # Exemplo válido
resultado = MinhaGemUtil::Validador.cpf_valido?(cpf_teste)

puts "CPF: #{cpf_teste} | Válido? #{resultado ? 'Sim' : 'Não'}"

puts "\nRefatoração de validação de CPF carregada!"
