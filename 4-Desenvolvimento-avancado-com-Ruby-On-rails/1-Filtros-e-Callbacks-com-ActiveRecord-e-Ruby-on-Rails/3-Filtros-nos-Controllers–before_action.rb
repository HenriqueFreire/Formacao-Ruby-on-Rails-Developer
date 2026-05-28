# Filtros nos Controllers (Action Controller Filters)

# No Ruby on Rails, os filtros permitem executar código antes, depois ou ao redor 
# das ações (actions) do controlador. O filtro mais comum é o `before_action`.

# --- Tipos de Filtros ---
# 1. before_action: Executado ANTES da ação. Pode interromper o fluxo (ex: se o usuário não estiver logado).
# 2. after_action: Executado DEPOIS da ação. Útil para modificar a resposta ou logar dados.
# 3. around_action: Executado "ao redor" da ação. Geralmente usado para abrir transações ou medir tempo.

# --- Exemplo Prático: Autenticação e DRY (Don't Repeat Yourself) ---

class PostsController < ApplicationController
  # 1. Filtro global para todas as ações neste controller
  before_action :authenticate_user!

  # 2. Filtro apenas para ações específicas (scoping)
  # Útil para carregar o registro uma única vez para show, edit, update e destroy
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # 3. Filtro que ignora certas ações
  # Permite que visitantes vejam o índice e os posts sem estarem logados
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    # @post já foi carregado pelo set_post
  end

  def edit
    # @post já foi carregado pelo set_post
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post atualizado com sucesso.'
    else
      render :edit
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to posts_path, alert: 'Post não encontrado.'
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to login_path, alert: 'Você precisa estar logado para acessar esta área.'
    end
  end

  def user_signed_in?
    # Lógica de verificação de sessão
    !!session[:user_id]
  end
end

# --- Herança de Filtros ---
# Filtros definidos no `ApplicationController` são aplicados a todos os controllers da aplicação.

class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

# --- Boas Práticas ---
# 1. Interrupção: Se um `before_action` renderizar ou redirecionar, a ação do controller NÃO será executada.
# 2. Ordem: Os filtros são executados na ordem em que são declarados.
# 3. Métodos Privados: Sempre defina os métodos dos filtros como `private` no controller.
# 4. Legibilidade: Use `only` e `except` para deixar claro onde o filtro se aplica.
