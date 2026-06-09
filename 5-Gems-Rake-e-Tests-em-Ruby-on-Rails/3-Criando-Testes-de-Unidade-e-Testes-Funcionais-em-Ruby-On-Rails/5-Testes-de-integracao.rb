# Testes de Integração em Rails

# Testes de integração (atualmente referidos como Request Tests no Rails moderno) 
# são projetados para testar como as diferentes partes da sua aplicação interagem.

# Diferente dos testes funcionais, que historicamente focavam em um único controlador,
# os testes de integração simulam requisições HTTP completas e podem abranger múltiplos 
# controladores e fluxos de negócio complexos.

# --- 1. O que os Testes de Integração verificam? ---
# - O roteamento correto das URLs.
# - A pilha de Middlewares.
# - A interação entre Controllers, Models e o Banco de Dados.
# - Fluxos que passam por mais de uma ação ou controlador (ex: Login -> Compra -> Checkout).

# --- 2. Exemplo Prático: Fluxo de Autenticação e Acesso ---

=begin
require "test_helper"

class FluxoUsuarioTest < ActionDispatch::IntegrationTest
  
  test "usuario faz login e acessa area restrita" do
    # 1. Tenta acessar uma página protegida
    get "/admin"
    assert_response :redirect
    follow_redirect!
    assert_template "sessoes/new"

    # 2. Faz o login
    post "/login", params: { email: "usuario@teste.com", senha: "123" }
    assert_response :redirect
    follow_redirect!
    
    # 3. Verifica se agora tem acesso
    assert_equal "/admin", path
    assert_select "h1", "Bem-vindo ao Painel"
  end

  test "fluxo de criacao de postagem via API" do
    # Simula uma requisição JSON
    post "/api/v1/posts", 
         params: { post: { titulo: "Novo Post", conteudo: "Conteudo" } },
         headers: { "Authorization" => "Bearer token_valido" },
         as: :json

    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal "Novo Post", json_response["titulo"]
  end

end
=end

# --- 3. Métodos Importantes ---

# - get, post, patch, put, delete: Simulam os verbos HTTP.
# - follow_redirect!: Segue o redirecionamento retornado pelo servidor.
# - as: :json / as: :html: Define o formato da requisição.
# - response.body: O conteúdo retornado pela resposta.
# - path: O caminho da URL atual após redirecionamentos.

# --- 4. Integração vs Sistema ---

# - Integração (Request): Mais rápido, não usa navegador real, foca no protocolo HTTP e dados.
# - Sistema (System): Mais lento, usa navegador (Capybara), foca na interface e interação visual.

# --- CONCLUSÃO ---

# Testes de integração são o "meio-termo" perfeito na pirâmide de testes. 
# Eles oferecem uma cobertura excelente com uma performance muito melhor que os testes de sistema, 
# sendo ideais para testar APIs e fluxos lógicos críticos da aplicação.
