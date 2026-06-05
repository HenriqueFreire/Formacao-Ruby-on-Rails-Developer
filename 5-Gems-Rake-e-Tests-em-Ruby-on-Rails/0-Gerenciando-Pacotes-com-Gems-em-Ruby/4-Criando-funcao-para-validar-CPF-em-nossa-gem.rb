# Criando Função para Validar CPF em Nossa Gem

# Validar um CPF é um processo matemático que verifica se os dígitos verificadores
# (os dois últimos números) correspondem aos nove primeiros dígitos.

# =============================================================================
# 1. IMPLEMENTAÇÃO DO ALGORITMO DE VALIDAÇÃO
# =============================================================================

module MinhaGemUtil
  class Validador
    def self.cpf_valido?(valor)
      # 1. Limpa o valor (mantém apenas números)
      cpf = valor.to_s.gsub(/\D/, "")

      # 2. Verificações básicas de tamanho e sequências repetidas
      return false unless cpf.length == 11
      return false if cpf.chars.uniq.count == 1 # Ex: "111.111.111-11"

      # 3. Cálculo do Primeiro Dígito Verificador
      soma = 0
      9.times { |i| soma += cpf[i].to_i * (10 - i) }
      resto = soma % 11
      digito_1 = (resto < 2) ? 0 : 11 - resto
      
      return false if cpf[9].to_i != digito_1

      # 4. Cálculo do Segundo Dígito Verificador
      soma = 0
      10.times { |i| soma += cpf[i].to_i * (11 - i) }
      resto = soma % 11
      digito_2 = (resto < 2) ? 0 : 11 - resto

      return false if cpf[10].to_i != digito_2

      # Se passou por todas as etapas, o CPF é válido
      true
    end
  end
end

# =============================================================================
# 2. EXEMPLOS DE USO
# =============================================================================

puts "--- Testando Validador de CPF ---"

cpfs_para_testar = [
  "123.456.789-01", # Inválido
  "11111111111",    # Inválido (repetido)
  "000.000.000-00", # Inválido (repetido)
  "75163814041"     # Exemplo de CPF Válido (gerado para teste)
]

cpfs_para_testar.each do |c|
  status = MinhaGemUtil::Validador.cpf_valido?(c) ? "VÁLIDO" : "INVÁLIDO"
  puts "CPF: #{c.ljust(15)} | Status: #{status}"
end

# =============================================================================
# 3. INTEGRAÇÃO NO RAILS
# =============================================================================
# Você pode usar este validador em um Model do Rails para criar validações customizadas:
#
# class User < ApplicationRecord
#   validate :documento_deve_ser_valido
#
#   def documento_deve_ser_valido
#     unless MinhaGemUtil::Validador.cpf_valido?(self.cpf)
#       errors.add(:cpf, "não é um número de CPF válido")
#     end
#   end
# end

puts "\nLógica de validação de CPF carregada!"
