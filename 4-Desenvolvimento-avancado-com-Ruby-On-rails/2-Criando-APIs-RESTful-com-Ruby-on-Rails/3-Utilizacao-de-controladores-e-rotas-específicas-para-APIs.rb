# Utilização de Controladores e Rotas Específicas para APIs no Ruby on Rails

No desenvolvimento de APIs com Ruby on Rails, é uma prática recomendada separar a lógica da API da lógica da aplicação web tradicional (HTML). Isso é feito através do uso de namespaces, controladores específicos e rotas dedicadas.

## 1. ActionController::API

Para APIs, em vez de herdar de `ActionController::Base`, herdamos de `ActionController::API`. Isso torna o controlador mais leve, pois remove módulos necessários apenas para renderização de HTML, cookies e sessões.

### Exemplo de Base Controller:
```ruby
# app/controllers/api/v1/api_controller.rb
module Api
  module V1
    class ApiController < ActionController::API
      # Lógica comum para todos os controladores da API (ex: autenticação)
    end
  end
end
```

---

## 2. Namespacing de Controladores

Organizar a API em versões (V1, V2, etc.) permite que você faça mudanças significativas sem quebrar clientes que utilizam versões anteriores.

### Exemplo de Controlador de Recurso:
```ruby
# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    class UsersController < ApiController
      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.find(params[:id])
        render json: @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email)
      end
    end
  end
end
```

---

## 3. Rotas Específicas para API

No arquivo `config/routes.rb`, utilizamos `namespace` para mapear as URLs para os controladores corretos.

### Exemplo de Configuração de Rotas:
```ruby
# config/routes.rb
Rails.application.routes.draw do
  # Rotas da API
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
    end
  end

  # Isso gerará rotas como:
  # GET    /api/v1/users
  # GET    /api/v1/users/:id
  # POST   /api/v1/users
end
```

### Uso de `scope` vs `namespace`:
- `namespace :api` procura controladores dentro de um módulo `Api::` e adiciona `/api` no prefixo da URL.
- `scope module: 'api'` procura controladores dentro de um módulo `Api::`, mas não adiciona prefixo na URL.
- `scope '/api'` adiciona prefixo na URL, mas não exige que os controladores estejam em um módulo.

---

## 4. Respondendo com JSON

O Rails facilita a renderização de JSON através do método `render json:`.

```ruby
# Exemplo de resposta com status e opções
render json: { message: "Recurso criado com sucesso" }, status: :ok
```

Para objetos mais complexos, recomenda-se o uso de serializadores (como `ActiveModel::Serializer` ou `Jbuilder`) para controlar quais campos são enviados na resposta.
