# Autorização em APIs RESTful no Ruby on Rails

Enquanto a **autenticação** verifica *quem* você é (usando JWT, por exemplo), a **autorização** determina *o que* você pode fazer. Em APIs, é crucial garantir que um usuário não acesse ou modifique recursos de outros usuários.

## 1. Autorização Manual (Simples)

Para casos simples, você pode verificar a permissão diretamente no controlador.

### Exemplo:
```ruby
# app/controllers/api/v1/posts_controller.rb
module Api
  module V1
    class PostsController < ApiController
      def update
        @post = Post.find(params[:id])
        
        # Verifica se o post pertence ao usuário logado
        if @post.user_id == current_user.id
          if @post.update(post_params)
            render json: @post
          else
            render json: @post.errors, status: :unprocessable_entity
          end
        else
          render json: { error: 'Acesso Negado' }, status: :forbidden
        end
      end
    end
  end
end
```

---

## 2. Autorização com a Gem Pundit

A gem `pundit` é uma das mais utilizadas para organizar a lógica de autorização em objetos chamados **Policies**.

### Configuração:
Adicione `gem 'pundit'` ao seu `Gemfile` e inclua no seu `ApiController`:

```ruby
class ApiController < ActionController::API
  include Pundit::Authorization
  # ...
end
```

### Criando uma Policy:
```ruby
# app/policies/post_policy.rb
class PostPolicy < ApplicationPolicy
  def update?
    # O usuário logado é o dono do post ou é um administrador?
    user.admin? || record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end
end
```

### Usando no Controlador:
```ruby
def update
  @post = Post.find(params[:id])
  authorize @post # Pundit chamará PostPolicy#update?
  
  if @post.update(post_params)
    render json: @post
  else
    render json: @post.errors, status: :unprocessable_entity
  end
end
```

---

## 3. Tratamento Global de Erros de Autorização

Para evitar repetir o tratamento de erro em cada ação, você pode capturar a exceção do Pundit globalmente.

```ruby
# app/controllers/api/v1/api_controller.rb
class ApiController < ActionController::API
  include Pundit::Authorization
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { error: 'Você não tem permissão para realizar esta ação.' }, status: :forbidden
  end
end
```

---

## 4. Scopes de Autorização

O Pundit também permite filtrar quais registros o usuário pode *ver* na listagem (`index`).

```ruby
# app/policies/post_policy.rb
class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end

# No controlador:
def index
  @posts = policy_scope(Post)
  render json: @posts
end
```

---

## Resumo de Status HTTP para Autorização:
- **401 Unauthorized**: O usuário não está autenticado.
- **403 Forbidden**: O usuário está autenticado, mas não tem permissão para o recurso específico.
