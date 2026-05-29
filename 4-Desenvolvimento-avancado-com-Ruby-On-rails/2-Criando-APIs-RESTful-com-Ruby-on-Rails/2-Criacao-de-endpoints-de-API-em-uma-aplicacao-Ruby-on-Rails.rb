# Criação de Endpoints de API em uma aplicação Ruby on Rails

# Um "endpoint" é um ponto final de um canal de comunicação. Em APIs, 
# são as URLs que os clientes acessam para realizar operações nos recursos.

# --- Passo 1: Definindo as Rotas ---
# Use namespaces para organizar e versionar sua API. Isso evita quebrar 
# clientes antigos quando você fizer mudanças estruturais.

# config/routes.rb
# Rails.application.routes.draw do
#   namespace :api do
#     namespace :v1 do
#       resources :tasks
#     end
#   end
# end

# --- Passo 2: O Controller de API ---
# Para aplicações exclusivamente de API, o controller pode herdar de `ActionController::API` 
# em vez de `ActionController::Base`. Isso torna o controller mais leve, 
# removendo funcionalidades de renderização HTML e cookies.

class Api::V1::TasksController < ActionController::API
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /api/v1/tasks
  def index
    @tasks = Task.all
    render json: @tasks
  end

  # GET /api/v1/tasks/:id
  def show
    render json: @task
  end

  # POST /api/v1/tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tasks/:id
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tasks/:id
  def destroy
    @task.destroy
    head :no_content # Retorna status 204 sem corpo
  end

  private

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Tarefa não encontrada" }, status: :not_found
  end

  def task_params
    params.require(:task).permit(:title, :completed)
  end
end

# --- Pontos Chave na Criação de Endpoints ---

# 1. Strong Parameters: Sempre use `.permit` para evitar o envio de dados maliciosos.
# 2. Tratamento de Erros: Use blocos rescue ou `rescue_from` para retornar mensagens JSON amigáveis 
#    em vez de uma página de erro HTML 500.
# 3. Status Codes: Retorne sempre o código HTTP correto (ex: 201 para criado, 204 para deletado).
# 4. JSON Consistente: Tente manter a estrutura das respostas padronizada.

# --- Testando os Endpoints ---
# Você pode testar seus endpoints usando ferramentas como:
# - cURL (terminal)
# - Postman
# - Insomnia
# - VS Code Thunder Client
