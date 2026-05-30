# Implementação de Autenticação OAuth com Serviços de Terceiros

O **OAuth 2.0** é o padrão da indústria para autorização. Ele permite que usuários façam login em sua aplicação usando suas contas de serviços populares como Google, GitHub, Facebook ou LinkedIn, sem que você precise gerenciar senhas.

No ecossistema Ruby on Rails, a solução padrão para isso é a gem **OmniAuth**.

---

## 1. Como o Fluxo OAuth Funciona

1.  **Redirecionamento**: O usuário clica em "Login com Google" e é enviado para o servidor do Google.
2.  **Autorização**: O usuário autoriza sua aplicação a acessar seus dados básicos.
3.  **Callback**: O Google redireciona o usuário de volta para sua aplicação com um **código temporário**.
4.  **Troca de Token**: Sua aplicação troca esse código por um **Access Token**.
5.  **Acesso**: Sua aplicação usa o token para buscar os dados do usuário (nome, email, avatar).

---

## 2. Configuração com OmniAuth

### Passo 1: Instalação
Adicione as gems necessárias ao seu `Gemfile`. Para cada serviço (estratégia), você precisará de uma gem específica.

```ruby
gem 'omniauth'
gem 'omniauth-google-oauth2' # Exemplo para Google
gem 'omniauth-github'        # Exemplo para GitHub
```

### Passo 2: Inicializador
Crie um arquivo de configuração para definir as chaves (ID e Secret) que você obteve no console do desenvolvedor do serviço (ex: Google Cloud Console).

```ruby
# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end
```

---

## 3. Criando as Rotas e o Controller

### Rotas
O OmniAuth espera um endpoint de callback padrão: `/auth/:provider/callback`.

```ruby
# config/routes.rb
get '/auth/:provider/callback', to: 'sessions#create'
get '/auth/failure', to: 'sessions#failure'
```

### Controller de Sessões
Aqui é onde você recebe os dados do usuário e decide se cria uma nova conta ou faz login em uma existente.

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    # O OmniAuth coloca todos os dados do usuário no hash env['omniauth.auth']
    auth_data = request.env['omniauth.auth']
    
    user = User.find_or_create_by(uid: auth_data['uid'], provider: auth_data['provider']) do |u|
      u.email = auth_data['info']['email']
      u.name = auth_data['info']['name']
      u.image = auth_data['info']['image']
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "Bem-vindo, #{user.name}!"
  end

  def failure
    redirect_to root_path, alert: "Erro na autenticação. Tente novamente."
  end
end
```

---

## 4. Integração com Devise (Opcional)

Se você já usa o **Devise**, ele possui suporte nativo ao OmniAuth, o que simplifica ainda mais o processo.

```ruby
# No modelo User
class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
end
```

---

## 5. Cuidados Importantes

- **Segurança das Chaves**: **NUNCA** coloque o `Client Secret` diretamente no código. Use variáveis de ambiente (`ENV`) ou o `credentials.yml.enc` do Rails.
- **Escopos (Scopes)**: Solicite apenas as permissões necessárias (ex: `email` e `profile`). Pedir permissão para ler contatos ou arquivos pode assustar o usuário.
- **Tratamento de Erros**: Usuários podem cancelar a autorização no meio do caminho. Sua aplicação deve lidar com o callback de falha graciosamente.

## Resumo
A autenticação OAuth melhora a taxa de conversão da sua aplicação, pois remove a fricção de preencher formulários de cadastro. Com **OmniAuth**, você tem uma interface padronizada para integrar dezenas de serviços diferentes de forma consistente.
