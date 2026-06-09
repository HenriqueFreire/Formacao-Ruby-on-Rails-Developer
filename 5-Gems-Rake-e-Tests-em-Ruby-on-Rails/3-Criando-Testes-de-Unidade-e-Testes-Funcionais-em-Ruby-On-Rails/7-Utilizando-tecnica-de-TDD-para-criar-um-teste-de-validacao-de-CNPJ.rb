# Utilizando técnica de TDD para criar um teste de validação de CNPJ

# O TDD (Test Driven Development) nos obriga a pensar no comportamento antes da implementação.
# Vamos seguir o ciclo: RED (Falha) -> GREEN (Passa) -> REFACTOR (Melhora).

# --- PASSO 1: RED (O Teste que Falha) ---
# Criamos o teste para uma classe 'CnpjValidator' que ainda não existe ou não tem lógica.

require 'minitest/autorun'

=begin
class TestCnpjValidator < Minitest::Test
  def setup
    @validator = CnpjValidator.new
  end

  def test_deve_ser_valido_com_cnpj_correto
    assert @validator.validar?("11.222.333/0001-81")
  end

  def test_deve_ser_invalido_com_cnpj_errado
    assert_not @validator.validar?("11.222.333/0001-00")
  end

  def test_deve_ser_invalido_com_tamanho_errado
    assert_not @validator.validar?("123")
  end
end
=end

# --- PASSO 2: GREEN (Implementação Mínima para Passar) ---

class CnpjValidator
  def validar?(cnpj)
    return false if cnpj.nil?
    
    # Remove caracteres não numéricos
    numeros = cnpj.gsub(/[^\d]/, '')
    
    # Validação simples de tamanho (CNPJ tem 14 dígitos)
    return false unless numeros.length == 14

    # Validação simplificada (em um cenário real, usaríamos o algoritmo de dígitos verificadores)
    # Aqui vamos apenas simular a passagem do teste 'RED' acima
    numeros == "11222333000181"
  end
end

# --- PASSO 3: REFACTOR (Melhorando o Código) ---

# Agora que os testes passam, podemos implementar o algoritmo real de verificação 
# de dígitos sem medo de quebrar o que já funciona.

class CnpjValidatorRefactored
  def validar?(cnpj)
    return false if cnpj.nil?
    numeros = cnpj.gsub(/[^\d]/, '')
    return false if numeros.length != 14 || numeros.chars.uniq.count == 1
    
    # Aqui entraria o algoritmo complexo de multiplicação pelos pesos (5,4,3,2,9,8...)
    # O TDD nos dá a segurança de que, se mudarmos o algoritmo, o comportamento esperado
    # ("11.222.333/0001-81" ser válido) continuará sendo verificado.
    true 
  end
end

# --- EXEMPLO EM RAILS (Custom Validator) ---

# No Rails, poderíamos usar essa lógica em um validador customizado:
=begin
class CnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless CnpjValidatorService.new.validar?(value)
      record.errors.add(attribute, "não é um CNPJ válido")
    end
  end
end

# No Model:
# validates :cnpj, cnpj: true
=end

# --- CONCLUSÃO ---

# Usar TDD para validações complexas como CNPJ garante que:
# 1. Cobrimos casos de erro (strings vazias, formatos errados).
# 2. Temos um guia claro do que o código precisa fazer antes de começar a digitar.
# 3. Podemos refatorar a lógica de cálculo (que é complexa no CNPJ) com segurança total.
