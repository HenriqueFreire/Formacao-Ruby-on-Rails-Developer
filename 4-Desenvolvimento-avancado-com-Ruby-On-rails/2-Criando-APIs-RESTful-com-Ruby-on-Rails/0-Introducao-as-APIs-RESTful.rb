# Introdução às APIs RESTful com Ruby on Rails

# REST (Representational State Transfer) é um estilo de arquitetura para sistemas distribuídos.
# Uma API RESTful é aquela que segue os princípios do REST, utilizando os métodos HTTP 
# para manipular recursos (entidades do sistema).

# --- Princípios Básicos do REST ---
# 1. Stateless: Cada requisição deve conter toda a informação necessária para ser processada.
# 2. Cliente-Servidor: Separação de responsabilidades.
# 3. Cacheável: As respostas devem ser explicitamente marcadas como cacheáveis ou não.
# 4. Interface Uniforme: Uso padrão de recursos e métodos.

# --- Mapeamento HTTP para CRUD ---

# Ação CRUD | Método HTTP | Rota (Exemplo: Artigos) | Descrição
# ----------|-------------|-------------------------|-----------------------------------
# Read      | GET         | /articles               | Lista todos os artigos
# Create    | POST        | /articles               | Cria um novo artigo
# Read      | GET         | /articles/:id           | Exibe um artigo específico
# Update    | PUT/PATCH   | /articles/:id           | Atualiza um artigo (PUT: total, PATCH: parcial)
# Delete    | DELETE      | /articles/:id           | Remove um artigo

# --- Configurando Rotas no Rails ---
# No arquivo `config/routes.rb`, o comando `resources` cria automaticamente todas as rotas acima.

# config/routes.rb
# Rails.application.routes.draw do
#   namespace :api do
#     namespace :v1 do
#       resources :articles
#     end
#   end
# end

# --- Exemplo de Controller de API ---
# Ao contrário dos controllers tradicionais que renderizam HTML (ERB), 
# os controllers de API geralmente retornam JSON.

class Api::V1::ArticlesController < ApplicationController
  # GET /api/v1/articles
  def index
    @articles = Article.all
    render json: @articles, status: :ok
  end

  # GET /api/v1/articles/:id
  def show
    @article = Article.find(params[:id])
    render json: @article
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Artigo não encontrado' }, status: :not_found
  end

  # POST /api/v1/articles
  def create
    @article = Article.new(article_params)
    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end

# --- Status Codes Comuns ---
# 200 OK: Sucesso total.
# 201 Created: Recurso criado com sucesso.
# 204 No Content: Sucesso, mas não há conteúdo para retornar (comum em DELETE).
# 400 Bad Request: A requisição tem algum erro de sintaxe.
# 401 Unauthorized: Usuário não autenticado.
# 403 Forbidden: Usuário autenticado, mas sem permissão.
# 404 Not Found: Recurso não encontrado.
# 422 Unprocessable Entity: Erro de validação nos dados enviados.
# 500 Internal Server Error: Erro inesperado no servidor.
