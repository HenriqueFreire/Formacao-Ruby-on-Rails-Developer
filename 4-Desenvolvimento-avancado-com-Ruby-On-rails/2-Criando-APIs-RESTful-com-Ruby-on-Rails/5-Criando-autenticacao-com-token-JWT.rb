# Criando Autenticação com Token JWT no Ruby on Rails

A autenticação baseada em tokens JWT (JSON Web Tokens) é o padrão para APIs modernas e stateless. Diferente da autenticação baseada em sessão (cookies), o JWT armazena as informações do usuário em um token assinado enviado no header das requisições.

## 1. Configuração Inicial

Primeiro, adicione a gem `jwt` ao seu `Gemfile`:

```ruby
gem 'jwt'
gem 'bcrypt', '~> 3.1.7' # Necessário para has_secure_password
```

---

## 2. Classe Utilitária para JWT

Crie um arquivo para lidar com a codificação e decodificação dos tokens.

```ruby
# app/lib/json_web_token.rb
class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  rescue JWT::DecodeError => e
    nil
  end
end
```

---

## 3. Autenticação no Controlador Base

No seu `ApiController`, adicione a lógica para validar o token em cada requisição.

```ruby
# app/controllers/api/v1/api_controller.rb
module Api
  module V1
    class ApiController < ActionController::API
      before_action :authenticate_request

      attr_reader :current_user

      private

      def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        
        decoded = JsonWebToken.decode(header)
        @current_user = User.find(decoded[:user_id]) if decoded

        render json: { error: 'Não autorizado' }, status: :unauthorized unless @current_user
      end
    end
  end
end
```

---

## 4. Endpoint de Login (Auth)

Crie um controlador para lidar com a geração do token após validar as credenciais do usuário.

```ruby
# app/controllers/api/v1/authentication_controller.rb
module Api
  module V1
    class AuthenticationController < ApiController
      skip_before_action :authenticate_request, only: :login

      # POST /api/v1/auth/login
      def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                         username: @user.username }, status: :ok
        else
          render json: { error: 'Não autorizado' }, status: :unauthorized
        end
      end
    end
  end
end
```

---

## 5. Configurando Rotas

```ruby
# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#login'
      resources :users
      # Outros recursos protegidos...
    end
  end
end
```

## Como utilizar no Cliente:
Ao fazer uma requisição para um endpoint protegido, o cliente deve enviar o token no header:
`Authorization: Bearer <seu_token_jwt>`
