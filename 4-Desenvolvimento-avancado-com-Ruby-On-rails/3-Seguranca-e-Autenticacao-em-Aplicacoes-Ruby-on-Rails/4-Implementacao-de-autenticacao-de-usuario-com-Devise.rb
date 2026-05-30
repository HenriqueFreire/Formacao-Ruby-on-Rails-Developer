# Implementação de Autenticação de Usuário com Devise no Ruby on Rails

O **Devise** é a solução de autenticação mais popular e completa para Ruby on Rails. Ele é baseado no Warden e oferece uma solução modular que cuida de tudo: desde o login e registro até a recuperação de senha e confirmação de conta.

## 1. Instalação e Configuração

Adicione a gem ao seu `Gemfile`:

```ruby
gem 'devise'
```

Execute os comandos de instalação:

```bash
bundle install
rails generate devise:install
```

### Configurações Pós-instalação:
O Rails solicitará algumas configurações manuais, como:
- Definir as opções de URL padrão para o Mailer em `config/environments/development.rb`.
- Definir uma rota raiz (`root_to`) no `config/routes.rb`.
- Adicionar mensagens flash no seu layout principal (`app/views/layouts/application.html.erb`).

---

## 2. Criando o Modelo de Usuário

Você pode gerar um modelo (geralmente chamado `User`) com o Devise:

```bash
rails generate devise User
rails db:migrate
```

Isso criará o model, as rotas e a migration com campos como `email`, `encrypted_password`, `reset_password_token`, etc.

---

## 3. Módulos do Devise

No seu model `app/models/user.rb`, você verá os módulos ativos:

```ruby
class User < ApplicationRecord
  # Módulos padrão:
  devise :database_authenticatable, # Autenticação via BD
         :registerable,           # Cadastro de usuários
         :recoverable,            # Recuperação de senha
         :rememberable,           # "Lembrar-me" via cookies
         :validatable             # Validações de email e senha

  # Outros módulos comuns:
  # :confirmable,   # Confirmação via email
  # :lockable,      # Bloqueio após várias tentativas falhas
  # :trackable,     # Rastreia IPs e horários de login
  # :omniauthable   # Autenticação via redes sociais (Facebook, Google)
end
```

---

## 4. Helpers Úteis no Controller e nas Views

O Devise fornece helpers que facilitam muito o dia a dia:

### No Controller:
```ruby
class PostsController < ApplicationController
  # Exige que o usuário esteja logado para acessar qualquer ação
  before_action :authenticate_user!

  def create
    # O Devise fornece o objeto do usuário logado
    @post = current_user.posts.build(post_params)
    # ...
  end
end
```

### Nas Views:
```erb
<% if user_signed_in? %>
  <p>Bem-vindo, <%= current_user.email %></p>
  <%= link_to "Sair", destroy_user_session_path, method: :delete %>
<% else %>
  <%= link_to "Entrar", new_user_session_path %>
  <%= link_to "Cadastrar", new_user_registration_path %>
<% end %>
```

---

## 5. Personalizando Views e Controllers

Por padrão, o Devise usa views internas. Para editá-las (mudar o design do formulário de login, por exemplo):

```bash
rails generate devise:views
```

Para personalizar a lógica dos controllers (como permitir campos extras no cadastro):

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name])
  end
end
```

---

## 6. Resumo das Vantagens do Devise
1.  **Segurança**: Segue as melhores práticas de criptografia e proteção.
2.  **Velocidade**: Implementa fluxos complexos em minutos.
3.  **Flexibilidade**: Você escolhe apenas os módulos que precisa.
4.  **Comunidade**: Vasto material e suporte para problemas comuns.
