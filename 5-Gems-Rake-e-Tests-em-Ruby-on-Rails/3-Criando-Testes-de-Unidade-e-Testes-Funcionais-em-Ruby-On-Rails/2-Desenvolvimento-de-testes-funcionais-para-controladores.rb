# Desenvolvimento de Testes Funcionais para Controladores em Rails

# Testes funcionais em Rails (geralmente chamados de Controller Tests ou Request Tests) 
# focam em testar as ações de um controlador e como elas respondem a requisições HTTP.

# O objetivo é verificar:
# 1. Se a requisição foi bem-sucedida (status HTTP).
# 2. Se o usuário foi redirecionado corretamente.
# 3. Se as variáveis de instância corretas foram passadas para a view.
# 4. Se a mensagem de flash correta foi exibida.

# --- 1. Estrutura de um Teste Funcional ---

# Imagine um controlador 'ProdutosController' com a ação 'index' e 'create'.

=begin
require "test_helper"

class ProdutosControllerTest < ActionDispatch::IntegrationTest
  
  # Testando a ação INDEX (GET)
  test "deve carregar a lista de produtos" do
    get produtos_url
    assert_response :success
    assert_select "h1", "Lista de Produtos" # Verifica se existe um H1 específico na view
  end

  # Testando a ação CREATE (POST) com sucesso
  test "deve criar um novo produto e redirecionar" do
    assert_difference("Produto.count") do
      post produtos_url, params: { produto: { nome: "Notebook", preco: 3500.00 } }
    end

    assert_redirected_to produto_url(Produto.last)
    assert_equal "Produto criado com sucesso!", flash[:notice]
  end

  # Testando a ação CREATE (POST) com falha (dados inválidos)
  test "não deve criar produto com dados inválidos" do
    assert_no_difference("Produto.count") do
      post produtos_url, params: { produto: { nome: "", preco: -10 } }
    end

    assert_response :unprocessable_entity
  end

  # Testando PROTEÇÃO (Acesso negado)
  test "deve redirecionar para login se não estiver autenticado" do
    get admin_painel_url
    assert_redirected_to login_url
  end

end
=end

# --- 2. Asserções Comuns em Testes Funcionais ---

# - assert_response :success (200)
# - assert_response :redirect (302)
# - assert_response :unprocessable_entity (422)
# - assert_redirected_to caminho_path
# - assert_select "seletor_css", "texto esperado"
# - assert_difference "Modelo.count", 1 do ... end

# --- 3. Diferença entre Controller Tests e Request Tests ---

# Atualmente, o Rails recomenda o uso de 'Integration Tests' (Request Tests) 
# em vez de 'Controller Tests' puros. 
# - Controller Tests: Testam o controlador isoladamente.
# - Integration Tests: Simulam a pilha completa (Roteamento -> Middleware -> Controller -> View).

# --- CONCLUSÃO ---

# Testes funcionais garantem que as "portas de entrada" da sua aplicação 
# (os endpoints HTTP) estão funcionando como esperado, protegendo a lógica 
# de navegação e a integração entre o Controller e o resto do sistema.
