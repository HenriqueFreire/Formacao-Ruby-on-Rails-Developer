# Criando Testes de Unidade para Validar Propriedades do Administrador

# Em aplicações Rails, modelos que lidam com autenticação e permissões (como o Administrador) 
# exigem testes rigorosos para garantir a segurança e a integridade dos dados.

# --- 1. O Modelo Administrador (Exemplo) ---

# class Administrador < ApplicationRecord
#   validates :nome, presence: true
#   validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
#   validates :senha, presence: true, length: { minimum: 6 }
# end

# --- 2. Implementando os Testes de Unidade ---

# Usamos o ActiveSupport::TestCase para validar cada propriedade individualmente.

=begin
require "test_helper"

class AdministradorTest < ActiveSupport::TestCase

  # Teste de Presença
  test "não deve ser válido sem nome" do
    admin = Administrador.new(email: "admin@teste.com", senha: "password123")
    assert_not admin.valid?
    assert_includes admin.errors[:nome], "can't be blank"
  end

  # Teste de Formato de Email
  test "deve rejeitar emails com formato inválido" do
    emails_invalidos = ["admin", "admin@teste", "admin.com"]
    emails_invalidos.each do |email|
      admin = Administrador.new(nome: "Admin", email: email, senha: "password123")
      assert_not admin.valid?, "#{email} deveria ser inválido"
    end
  end

  # Teste de Unicidade
  test "não deve permitir emails duplicados" do
    Administrador.create!(nome: "Admin 1", email: "original@teste.com", senha: "password123")
    duplicado = Administrador.new(nome: "Admin 2", email: "original@teste.com", senha: "password123")
    assert_not duplicado.valid?
    assert_includes duplicado.errors[:email], "has already been taken"
  end

  # Teste de Comprimento de Senha
  test "senha deve ter no mínimo 6 caracteres" do
    admin = Administrador.new(nome: "Admin", email: "admin@teste.com", senha: "12345")
    assert_not admin.valid?
    assert_includes admin.errors[:senha], "is too short (minimum is 6 characters)"
  end

  # Teste do "Caminho Feliz"
  test "deve ser válido com todas as propriedades corretas" do
    admin = Administrador.new(
      nome: "Administrador Geral", 
      email: "admin@empresa.com", 
      senha: "senha_segura_123"
    )
    assert admin.valid?
  end

end
=end

# --- CONCLUSÃO ---

# Validar as propriedades do Administrador via testes de unidade garante que:
# 1. Nenhum administrador seja criado sem as informações essenciais.
# 2. O sistema não aceite emails malformados que poderiam causar erros de envio.
# 3. Políticas de segurança (como tamanho de senha) sejam aplicadas consistentemente.
# 4. A integridade do banco de dados seja mantida através da unicidade de campos chave.
