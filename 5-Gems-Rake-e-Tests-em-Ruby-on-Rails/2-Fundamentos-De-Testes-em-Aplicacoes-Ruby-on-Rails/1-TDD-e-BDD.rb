# TDD (Test Driven Development) e BDD (Behavior Driven Development)

# --- 1. TDD (Desenvolvimento Orientado por Testes) ---

# O TDD segue um ciclo curto e repetitivo:
# 1. RED: Escreva um teste que falha (porque a funcionalidade ainda não existe).
# 2. GREEN: Escreva o código mínimo necessário para o teste passar.
# 3. REFACTOR: Melhore o código mantendo o teste passando.

# Exemplo Prático de TDD: Criar um formatador de nomes.

# PASSO 1 (RED): Escreveríamos o teste primeiro (imagine que a classe NomeFormatter não existe ainda)
require 'minitest/autorun'

class TestNomeFormatter < Minitest::Test
  def test_deve_capitalizar_o_nome
    # formatter = NomeFormatter.new
    # assert_equal "João", formatter.formatar("joão")
  end
end

# PASSO 2 (GREEN): Criar a classe mínima
class NomeFormatter
  def formatar(nome)
    nome.capitalize
  end
end

# Agora o teste passaria.

# PASSO 3 (REFACTOR): Se precisássemos tratar espaços em branco, mudaríamos a implementação 
# e rodaríamos o teste novamente para garantir que a capitalização ainda funciona.


# --- 2. BDD (Desenvolvimento Orientado por Comportamento) ---

# O BDD é uma evolução do TDD que foca no comportamento do sistema sob o ponto de vista do usuário.
# Utiliza uma linguagem mais próxima da natural (Gherkin) com a estrutura:
# GIVEN (Dado que) - Contexto inicial
# WHEN (Quando) - Ação executada
# THEN (Então) - Resultado esperado

# No Ruby, o BDD é muito associado à gem RSpec.

# Exemplo de BDD (Conceitual):

=begin
Funcionalidade: Autenticação de Usuário
  Cenário: Login com sucesso
    Dado que eu tenha um usuário cadastrado com "email@teste.com"
    Quando eu preencho o formulário de login com as credenciais corretas
    Então eu devo ver a mensagem de "Bem-vindo!"
=end

# Exemplo de sintaxe BDD com RSpec (Apenas ilustrativo):

# describe "Autenticação" do
#   it "permite o login de um usuário válido" do
#     usuario = Usuario.new(email: "email@teste.com", senha: "123")
#     expect(usuario.autenticar("123")).to be true
#   end
# end


# --- DIFERENÇAS CHAVE ---

# TDD: Foco técnico. "O código está fazendo o que eu escrevi corretamente?" (Unidade)
# BDD: Foco no negócio/usuário. "O sistema está se comportando como o usuário espera?" (Comportamento)

# Ambos são complementares e fundamentais para criar software robusto e de alta qualidade no ecossistema Ruby on Rails.
