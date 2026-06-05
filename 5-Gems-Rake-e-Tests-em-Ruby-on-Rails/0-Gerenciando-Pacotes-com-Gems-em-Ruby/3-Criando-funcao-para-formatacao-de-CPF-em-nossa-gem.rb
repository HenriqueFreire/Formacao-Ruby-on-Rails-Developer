# Criando Função para Formatação de CPF em Nossa Gem

# Este arquivo demonstra como implementar uma funcionalidade real (utilitário)
# dentro de uma Gem, focando em organização de código e lógica de strings.

# =============================================================================
# 1. DEFINIÇÃO DO MÓDULO E CLASSE
# =============================================================================
# Imagine que este código esteja em: lib/minha_gem_util/formatador.rb

module MinhaGemUtil
  class Formatador
    # Método de classe para formatar CPF
    # Aceita strings com ou sem pontuação e retorna no padrão 000.000.000-00
    def self.cpf(valor)
      # 1. Limpeza: remove tudo que não for dígito
      numero = valor.to_s.gsub(/\D/, "")

      # 2. Validação simples de tamanho
      return "CPF Inválido (deve conter 11 dígitos)" unless numero.length == 11

      # 3. Formatação via Regex (Expressão Regular)
      # Captura 4 grupos: 3 dígitos, 3 dígitos, 3 dígitos e 2 dígitos
      numero.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
    end
  end
end

# =============================================================================
# 2. EXEMPLOS DE USO
# =============================================================================

puts "--- Testando Formatador de CPF ---"

# Caso 1: Apenas números
cpf1 = "12345678901"
puts "Entrada: #{cpf1} | Saída: #{MinhaGemUtil::Formatador.cpf(cpf1)}"

# Caso 2: String com caracteres extras ou bagunçada
cpf2 = "123.456.789-01 (contato)"
puts "Entrada: #{cpf2} | Saída: #{MinhaGemUtil::Formatador.cpf(cpf2)}"

# Caso 3: Entrada inválida (menos dígitos)
cpf3 = "123.456"
puts "Entrada: #{cpf3} | Saída: #{MinhaGemUtil::Formatador.cpf(cpf3)}"

# =============================================================================
# 3. POR QUE USAR REQUIRIMENTO DE GEMS?
# =============================================================================
# Ao colocar essa lógica em uma Gem, você evita repetir esse código em todos os
# seus controllers ou models do Rails. 
# Basta adicionar 'gem minha_gem_util' no Gemfile e usar em qualquer lugar:
#
# class User < ApplicationRecord
#   def cpf_formatado
#     MinhaGemUtil::Formatador.cpf(self.documento)
#   end
# end

puts "\nExemplo de formatação de CPF carregado!"
