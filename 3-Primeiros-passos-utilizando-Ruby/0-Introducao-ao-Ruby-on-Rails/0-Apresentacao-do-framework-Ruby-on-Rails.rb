# Apresentação do Framework Ruby on Rails
#
# Ruby on Rails (ou apenas Rails) é um framework de desenvolvimento web escrito em Ruby.
# Ele foi projetado para facilitar a programação de aplicações web, tornando-as mais 
# rápidas de desenvolver e mais fáceis de manter.

# --- 1. Filosofia do Rails ---
# O Rails se baseia em dois princípios fundamentais:
#
# - DRY (Don't Repeat Yourself): Não repita a si mesmo. O código deve ser escrito de 
#   forma que a informação seja definida em um único lugar.
# - CoC (Convention over Configuration): Convenção sobre Configuração. O Rails assume 
#   que existe uma "melhor forma" de fazer as coisas e, se você seguir essas 
#   convenções, não precisará gastar tempo configurando tudo.

# --- 2. Arquitetura MVC (Model-View-Controller) ---
# O Rails organiza a aplicação em três camadas principais:
#
# - Model (Modelo): Gerencia os dados e a lógica de negócio (interação com o banco de dados).
# - View (Visualização): Responsável pela interface que o usuário vê (geralmente HTML/ERB).
# - Controller (Controlador): O intermediário que recebe as requisições, processa os 
#   dados via Model e envia para a View.

# --- 3. Exemplo de Código (Simulação de um Controller) ---

# No Rails, um controller de produtos seria algo assim:
# (Este código é ilustrativo, pois o Rails roda dentro de seu próprio ambiente)

class ProdutosController < ActionController::Base
  # Método (Action) que lista todos os produtos
  def index
    @produtos = Produto.all # O Model 'Produto' busca todos os registros no banco
    # O Rails renderiza automaticamente a view 'app/views/produtos/index.html.erb'
  end

  # Método que mostra um produto específico
  def show
    @produto = Produto.find(params[:id]) # Busca pelo ID passado na URL
  end
end


# --- 4. Comandos Poderosos do Terminal ---
# O Rails fornece geradores que criam código automaticamente para você.

# Exemplo de criação de uma aplicação:
# $ rails new minha_app

# Exemplo de criação de um Scaffold (Gera Model, Controller, View e Banco de Dados):
# $ rails generate scaffold Cliente nome:string email:string

# Exemplo de execução do servidor:
# $ rails server


# --- 5. Por que usar Rails? ---
# - Agilidade: Perfeito para MVPs (Minimum Viable Products).
# - Comunidade: Vasta biblioteca de "Gems" (pacotes de código) prontas para usar.
# - Segurança: Proteção nativa contra ataques comuns (SQL Injection, XSS, CSRF).
# - Carreira: Muitas empresas grandes (GitHub, Shopify, Airbnb, Twitch) utilizam Rails.
