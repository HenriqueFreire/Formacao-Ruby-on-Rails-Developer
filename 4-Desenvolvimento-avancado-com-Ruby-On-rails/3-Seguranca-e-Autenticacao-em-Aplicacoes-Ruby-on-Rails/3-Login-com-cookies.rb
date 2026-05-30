# Login com Cookies e Sessões no Ruby on Rails

A autenticação baseada em cookies é o método tradicional para aplicações web onde o servidor mantém o estado do usuário. No Rails, isso é gerenciado principalmente através do objeto `session`, que utiliza cookies criptografados para armazenar informações.

## 1. Como funciona o Cookie de Sessão no Rails?

Por padrão, o Rails utiliza o `CookieStore`. Ele armazena todos os dados da sessão em um cookie no navegador do cliente. Para garantir a segurança:
1.  Os dados são **criptografados** e **assinados** usando a `secret_key_base`.
2.  O cliente pode ver o cookie, mas não pode ler nem alterar seu conteúdo sem a chave mestra do servidor.

---

## 2. Implementando o Login (SessionsController)

Geralmente, criamos um controlador específico para gerenciar o ciclo de vida da sessão (login/logout).

```ruby
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    # Renderiza o formulário de login
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Armazena o ID do usuário na sessão (no cookie)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Login realizado com sucesso!"
    else
      flash.now[:alert] = "Email ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Remove o ID da sessão, encerrando o login
    session[:user_id] = nil
    # Ou session.delete(:user_id)
    redirect_to root_path, notice: "Logout realizado com sucesso!"
  end
end
```

---

## 3. Recuperando o Usuário Logado

No `ApplicationController`, definimos métodos para facilitar o acesso ao usuário atual em toda a aplicação.

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    # Uso de memoization (||=) para evitar múltiplas consultas ao banco
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authorize
    unless logged_in?
      redirect_to login_path, alert: "Você precisa estar logado para acessar esta página."
    end
  end
end
```

---

## 4. Cookies Permanentes (Remember Me)

Se você quiser que o usuário permaneça logado mesmo após fechar o navegador, pode usar `cookies.permanent`.

```ruby
# No create do SessionsController
if params[:remember_me]
  cookies.permanent.encrypted[:user_id] = user.id
else
  session[:user_id] = user.id
end
```

E no `current_user`:
```ruby
def current_user
  if (user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
  elsif (user_id = cookies.encrypted[:user_id])
    user = User.find_by(id: user_id)
    if user
      session[:user_id] = user.id
      @current_user = user
    end
  end
end
```

---

## 5. Considerações de Segurança

*   **HttpOnly**: Por padrão, os cookies do Rails são `HttpOnly`, o que significa que não podem ser acessados via JavaScript (proteção contra XSS).
*   **Secure**: Em produção, os cookies devem ser marcados como `Secure` para serem enviados apenas via HTTPS.
*   **Expiração**: Sessões de cookie expiram quando o navegador é fechado, a menos que sejam tornadas permanentes.

## 6. Rotas para Login

```ruby
# config/routes.rb
get  'login',  to: 'sessions#new'
post 'login',  to: 'sessions#create'
delete 'logout', to: 'sessions#destroy'
```
