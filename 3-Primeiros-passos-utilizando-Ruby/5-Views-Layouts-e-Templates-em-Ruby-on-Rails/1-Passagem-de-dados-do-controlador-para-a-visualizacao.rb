# Passagem de Dados do Controlador para a Visualização

No Rails, a comunicação entre o Controlador e a View é feita principalmente através de **variáveis de instância**.

---

## 1. Variáveis de Instância (`@`)

Qualquer variável definida com um `@` dentro de uma ação do controlador estará automaticamente disponível no arquivo de view correspondente.

**No Controlador:**
```ruby
class ProdutosController < ApplicationController
  def show
    # Esta variável estará disponível na view
    @produto = Produto.find(params[:id])
    @titulo_pagina = "Detalhes do Produto: #{@produto.nome}"
  end
end
```

**Na View (`show.html.erb`):**
```html
<h1><%= @titulo_pagina %></h1>
<p>Nome: <%= @produto.nome %></p>
```

---

## 2. Variáveis Locais vs. Variáveis de Instância

Variáveis locais (sem `@`) **não** são passadas para a view automaticamente.

```ruby
def index
  produtos = Produto.all # Variável local: a view não terá acesso a ela
  @produtos = Produto.all # Variável de instância: a view terá acesso
end
```

---

## 3. Passando Dados para Partiais (Locals)

Ao renderizar uma partial, é uma boa prática passar os dados explicitamente como variáveis locais usando a chave `locals`. Isso torna a partial mais independente e reutilizável.

**Na View Principal:**
```html
<%= render partial: "card_produto", locals: { produto: @produto, mostrar_botao: true } %>

<!-- Forma abreviada -->
<%= render "card_produto", produto: @produto, mostrar_botao: true %>
```

**Na Partial (`_card_produto.html.erb`):**
```html
<div class="card">
  <h2><%= produto.nome %></h2> <!-- Usamos 'produto' sem @ pois é uma variável local -->
  <% if mostrar_botao %>
    <button>Comprar</button>
  <% end %>
</div>
```

---

## 4. O Objeto `params`

O objeto `params` (que contém dados da URL ou de formulários) está disponível tanto no controlador quanto na view, mas o ideal é processar os dados no controlador e passar apenas o necessário para a view.

---

## 5. Flash Messages

O `flash` é um tipo especial de dado usado para passar mensagens curtas (sucesso, erro) entre ações (geralmente após um redirecionamento).

**No Controlador:**
```ruby
def create
  @produto = Produto.new(produto_params)
  if @produto.save
    redirect_to @produto, notice: "Produto criado com sucesso!"
  end
end
```

**No Layout (`application.html.erb`):**
```html
<% flash.each do |tipo, mensagem| %>
  <div class="alert alert-<%= tipo %>">
    <%= mensagem %>
  </div>
<% end %>
```
