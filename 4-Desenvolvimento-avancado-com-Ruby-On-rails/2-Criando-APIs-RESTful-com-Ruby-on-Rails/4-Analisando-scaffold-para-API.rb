# Analisando Scaffold para API no Ruby on Rails

O comando `scaffold` é uma ferramenta poderosa do Rails que gera automaticamente um conjunto de arquivos (model, controller, views, tests, migrations) para um recurso. Quando estamos desenvolvendo uma API, o scaffold se comporta de forma ligeiramente diferente para focar apenas nos dados (JSON).

## 1. Gerando um Scaffold de API

Para gerar um scaffold otimizado para API, você pode usar o comando:

```bash
rails generate scaffold User name:string email:string --api
```

Ou, se a sua aplicação já foi criada com o modo `--api` (`rails new my_api --api`), o gerador de scaffold omitirá automaticamente as views HTML.

---

## 2. O que o Scaffold de API gera?

Diferente do scaffold tradicional, o de API:
1. **Não gera Views**: Arquivos `.html.erb` não são criados.
2. **Controlador Slim**: O controlador herda de `ActionController::API`.
3. **Foco em JSON**: Os métodos do controlador usam apenas `render json:`.

### Exemplo de Controller Gerado:

```ruby
class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      # location: @user adiciona o header 'Location' na resposta
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email)
    end
end
```

---

## 3. Diferenças Importantes

### Status HTTP
O scaffold de API faz uso explícito de status HTTP semânticos:
- `status: :created` (201) para criações bem-sucedidas.
- `status: :unprocessable_entity` (422) para erros de validação.
- `204 No Content` implicitamente no `destroy` (em versões recentes do Rails).

### CSRF Protection
APIs geralmente não usam proteção CSRF baseada em cookies (pois são stateless ou usam tokens), e o controlador gerado reflete essa configuração.

---

## 4. Estendendo o Scaffold

Após gerar o scaffold, é comum:
1. **Mover para um Namespace**: Colocar o controlador dentro de `module Api::V1`.
2. **Adicionar Serializadores**: Usar `Jbuilder` ou `ActiveModel::Serializers` para filtrar quais campos do JSON serão expostos (ex: esconder a senha).

### Exemplo de Jbuilder (se instalado):
```ruby
# app/views/users/_user.json.jbuilder
json.extract! user, :id, :name, :email, :created_at, :updated_at
json.url user_url(user, format: :json)
```
