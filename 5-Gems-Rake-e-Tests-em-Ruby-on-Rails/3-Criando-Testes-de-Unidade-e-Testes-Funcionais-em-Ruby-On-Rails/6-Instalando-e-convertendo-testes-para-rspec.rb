# Instalando e Convertendo Testes para RSpec

# O RSpec é a biblioteca de testes mais utilizada na comunidade Ruby. 
# Ele utiliza uma DSL (Domain Specific Language) que foca em um estilo 
# mais descritivo e próximo da linguagem natural, sendo a base para o BDD.

# --- 1. Como Instalar o RSpec no Rails ---

# Passo 1: Adicione ao Gemfile
=begin
group :development, :test do
  gem 'rspec-rails', '~> 6.0.0'
end
=end

# Passo 2: Instale a Gem
# bundle install

# Passo 3: Inicialize o RSpec no projeto
# rails generate rspec:install
# Isso criará as pastas 'spec/', '.rspec' e os arquivos 'spec_helper.rb' e 'rails_helper.rb'.

# --- 2. Minitest vs RSpec (A Sintaxe) ---

# No Minitest (Padrão Rails):
# assert_equal 10, @produto.preco

# No RSpec:
# expect(@produto.preco).to eq(10)

# --- 3. Exemplo de Conversão: Teste de Unidade ---

# --- ANTES (Minitest) ---
=begin
class ProdutoTest < ActiveSupport::TestCase
  test "deve calcular imposto" do
    produto = Produto.new(preco: 100)
    assert_equal 10, produto.calcular_imposto
  end
end
=end

# --- DEPOIS (RSpec) ---
=begin
RSpec.describe Produto, type: :model do
  describe "#calcular_imposto" do
    it "retorna 10% do valor do preço" do
      produto = Produto.new(preco: 100)
      expect(produto.calcular_imposto).to eq(10)
    end
  end
end
=end

# --- 4. Exemplo de Conversão: Teste de Controller/Request ---

# --- ANTES (Minitest) ---
=begin
test "deve carregar index" do
  get produtos_path
  assert_response :success
end
=end

# --- DEPOIS (RSpec) ---
=begin
RSpec.describe "Produtos", type: :request do
  describe "GET /index" do
    it "retorna uma resposta de sucesso" do
      get "/produtos"
      expect(response).to have_http_status(:success)
    end
  end
end
=end

# --- 5. Por que converter? ---
# 1. Legibilidade: Os testes ficam mais fáceis de ler para pessoas não técnicas.
# 2. Organização: O uso de 'describe' e 'context' permite estruturar melhor cenários complexos.
# 3. Ecossistema: Muitas ferramentas e documentações focam primeiramente no RSpec.

# --- CONCLUSÃO ---
# Converter testes não é apenas mudar a sintaxe, é adotar uma mentalidade 
# de descrever comportamentos (BDD) em vez de apenas verificar estados (TDD puro).
