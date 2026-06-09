# Desenvolvimento de Testes de Unidade para Modelos e Classes em Rails

# Testes de unidade são a fundação de uma aplicação Rails saudável. 
# Eles testam a lógica de negócio contida nos Models e em classes utilitárias (POROs - Plain Old Ruby Objects).

# --- 1. Testando Validações de Modelos ---

# Em Rails, usamos o ActiveSupport::TestCase (que estende o Minitest).
# O objetivo é garantir que as regras de integridade do banco de dados sejam respeitadas.

# Imagine um modelo 'Usuario':
# class Usuario < ApplicationRecord
#   validates :nome, presence: true
#   validates :email, presence: true, uniqueness: true
# end

# Exemplo de Teste de Unidade para Validações:
=begin
require "test_helper"

class UsuarioTest < ActiveSupport::TestCase
  test "não deve salvar usuário sem nome" do
    usuario = Usuario.new(email: "teste@teste.com")
    assert_not usuario.save, "Salvou o usuário sem nome"
  end

  test "não deve salvar usuário com email duplicado" do
    Usuario.create!(nome: "User 1", email: "duplicado@teste.com")
    usuario_novo = Usuario.new(nome: "User 2", email: "duplicado@teste.com")
    assert_not usuario_novo.valid?
    assert_includes usuario_novo.errors[:email], "has already been taken"
  end
end
=end


# --- 2. Testando Métodos de Instância e de Classe ---

# Além de validações, testamos comportamentos customizados.

# class Pedido < ApplicationRecord
#   def calcular_total
#     itens.sum(:preco)
#   end
# end

# Exemplo de Teste de Comportamento:
=begin
class PedidoTest < ActiveSupport::TestCase
  test "deve calcular o total corretamente baseado nos itens" do
    pedido = Pedido.create!
    pedido.itens.create!(nome: "Item 1", preco: 10.50)
    pedido.itens.create!(nome: "Item 2", preco: 20.00)
    
    assert_equal 30.50, pedido.calcular_total
  end
end
=end


# --- 3. Testando Classes Puras (POROs) ---

# Nem toda lógica deve estar no Model. Usamos classes simples para serviços ou cálculos complexos.

class GeradorDeProtocolo
  def self.gerar(id_usuario)
    "#{Time.now.year}-#{id_usuario}-#{SecureRandom.hex(4)}"
  end
end

# Teste de Unidade (Minitest Puro):
require 'minitest/autorun'
require 'securerandom'

class TestGeradorDeProtocolo < Minitest::Test
  def test_deve_gerar_protocolo_no_formato_correto
    protocolo = GeradorDeProtocolo.gerar(123)
    assert_match /^\d{4}-123-[a-f0-9]{8}$/, protocolo
  end
end


# --- BOAS PRÁTICAS ---

# 1. Isolamento: Teste apenas uma coisa por método 'test'.
# 2. Rapidez: Testes de unidade devem ser extremamente rápidos.
# 3. Fixtures/Factories: Use dados controlados para garantir previsibilidade.
# 4. Cobertura: Foque em testar o "Caminho Feliz" e também os "Casos de Borda" (Edge Cases).
