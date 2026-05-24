# Criação de Controladores e Definição de Ações em Rails

Os controladores são o "C" do padrão MVC. Eles são responsáveis por processar as requisições que chegam do navegador, interagir com os modelos e renderizar as visões apropriadas.

---

## 1. Criando um Controlador

Você pode criar um controlador manualmente ou usando o gerador do Rails. Por convenção, os nomes dos controladores são pluralizados (ex: `ProdutosController`).

**Comando via terminal:**
```bash
bin/rails generate controller Produtos index show
```

## 2. As 7 Ações Padrão (RESTful)

Um controlador Rails que segue o padrão REST geralmente implementa estas 7 ações:

```ruby
class ProdutosController < ApplicationController
  # 1. index: Lista todos os registros
  def index
    @produtos = Produto.all
  end

  # 2. show: Exibe um registro específico
  def show
    @produto = Produto.find(params[:id])
  end

  # 3. new: Exibe o formulário de criação
  def new
    @produto = Produto.new
  end

  # 4. create: Salva o novo registro no banco de dados
  def create
    @produto = Produto.new(produto_params)
    if @produto.save
      redirect_to @produto, notice: "Produto criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 5. edit: Exibe o formulário de edição
  def edit
    @produto = Produto.find(params[:id])
  end

  # 6. update: Salva as alterações de um registro existente
  def update
    @produto = Produto.find(params[:id])
    if @produto.update(produto_params)
      redirect_to @produto, notice: "Produto atualizado!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 7. destroy: Remove um registro do banco de dados
  def destroy
    @produto = Produto.find(params[:id])
    @produto.destroy
    redirect_to produtos_url, notice: "Produto excluído."
  end

  private

  # Strong Parameters: Segurança para filtrar quais campos podem ser alterados
  def produto_params
    params.require(:produto).permit(:nome, :preco, :descricao)
  end
end
```

---

## 3. Callbacks (before_action)

Para evitar repetição de código (DRY - Don't Repeat Yourself), usamos `before_action` para executar métodos comuns antes de certas ações.

**Exemplo:**
```ruby
class ProdutosController < ApplicationController
  before_action :set_produto, only: [:show, :edit, :update, :destroy]

  def show; end
  def edit; end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end
end
```

---

## 4. Como o Controller interage com a View

Por padrão, o Rails procura uma view com o mesmo nome da ação na pasta do controlador:
- `def index` -> `app/views/produtos/index.html.erb`
- `def show` -> `app/views/produtos/show.html.erb`

As variáveis iniciadas com `@` (variáveis de instância) definidas no controlador ficam disponíveis automaticamente para serem usadas nas visões.
