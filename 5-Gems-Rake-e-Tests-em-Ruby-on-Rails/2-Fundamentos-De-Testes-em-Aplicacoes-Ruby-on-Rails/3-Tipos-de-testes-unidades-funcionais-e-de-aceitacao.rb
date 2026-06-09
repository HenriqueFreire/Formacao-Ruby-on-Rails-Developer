# Tipos de Testes: Unidade, Funcionais e de Aceitação

# No desenvolvimento com Ruby on Rails, dividimos os testes em diferentes níveis 
# de isolamento e abrangência. Conhecer cada um é fundamental para uma boa cobertura.

# --- 1. Testes de Unidade (Unit Tests) ---

# O que são: Testam a menor parte testável de uma aplicação (geralmente métodos de uma classe).
# Foco: Lógica isolada, sem depender de banco de dados externo ou chamadas de API (sempre que possível).
# No Rails: Geralmente associados aos Models.

# Exemplo:
class Produto
  attr_accessor :nome, :preco

  def calcular_imposto
    @preco * 0.1
  end
end

# Teste de Unidade (Minitest):
require 'minitest/autorun'

class TestProduto < Minitest::Test
  def test_deve_calcular_imposto_corretamente
    produto = Produto.new
    produto.preco = 100
    assert_equal 10.0, produto.calcular_imposto
  end
end


# --- 2. Testes Funcionais / Integração (Functional / Integration Tests) ---

# O que são: Testam a interação entre várias partes do sistema. 
# Foco: Verificar se um fluxo completo (ex: Controller -> Model -> DB) funciona.
# No Rails: Associados a Controllers e Request Tests.

# Exemplo Conceitual:
# - Simular uma requisição HTTP POST para criar um usuário.
# - Verificar se o usuário foi salvo no banco.
# - Verificar se houve o redirecionamento correto.

# post "/usuarios", params: { usuario: { nome: "Henrique" } }
# assert_response :redirect
# assert_equal 1, Usuario.count


# --- 3. Testes de Aceitação / Sistema (Acceptance / System Tests) ---

# O que são: Testam o sistema do ponto de vista do usuário final (ponta a ponta).
# Foco: Simular a navegação no browser (clicar em botões, preencher formulários).
# Ferramentas: Capybara, Selenium, Playwright.

# Exemplo de Teste de Aceitação (Capybara):
=begin
visit "/login"
fill_in "Email", with: "user@example.com"
fill_in "Senha", with: "123456"
click_button "Entrar"

assert_selector "h1", text: "Bem-vindo ao Painel"
=end


# --- RESUMO DA PIRÂMIDE DE TESTES ---

# 1. Unidade (Base): Muitos testes, muito rápidos, testam detalhes.
# 2. Integração (Meio): Menos testes, um pouco mais lentos, testam fluxos.
# 3. Aceitação (Topo): Poucos testes, lentos, testam a experiência final.

# Uma boa suíte de testes deve ter muitos testes de unidade e apenas o 
# essencial de testes de aceitação para cobrir os caminhos críticos (Caminho Feliz).
