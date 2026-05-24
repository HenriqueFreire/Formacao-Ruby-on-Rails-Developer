# Uso de Layouts para Estruturar Páginas em Rails

Os Layouts permitem manter um design consistente em toda a aplicação, definindo uma estrutura comum (como cabeçalho, rodapé e menus) que envolve o conteúdo de cada página individual.

---

## 1. O Layout Principal (application.html.erb)

Por padrão, o Rails utiliza o arquivo `app/views/layouts/application.html.erb`. Tudo o que for comum a todas as páginas deve estar aqui.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Minha Loja Rails</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body>
    <header>
      <nav>
        <%= link_to "Home", root_path %>
        <%= link_to "Produtos", produtos_path %>
      </nav>
    </header>

    <main>
      <!-- O conteúdo das views específicas entra aqui -->
      <%= yield %>
    </main>

    <footer>
      <p>&copy; 2024 - Todos os direitos reservados.</p>
    </footer>
  </body>
</html>
```

---

## 2. O Comando yield

O `<%= yield %>` é o "espaço reservado". Quando você acessa a página de um produto, o Rails renderiza a view `show.html.erb` e insere o HTML resultante exatamente onde está o `yield`.

### Múltiplos yields (Named Yields)
Você pode ter espaços reservados específicos para coisas como barras laterais ou scripts.

**No Layout:**
```html
<aside>
  <%= yield :sidebar %>
</aside>
```

**Na View:**
```html
<% content_for :sidebar do %>
  <p>Links úteis exclusivos desta página!</p>
<% end %>

<h1>Conteúdo Principal</h1>
```

---

## 3. Definindo Layouts Diferentes

Você pode querer um layout diferente para uma área administrativa ou para uma página de login.

### No Controlador:
```ruby
class AdminController < ApplicationController
  layout "admin" # Procura por app/views/layouts/admin.html.erb
end
```

### Dinamicamente:
```ruby
class ProdutosController < ApplicationController
  layout :definir_layout

  private

  def definir_layout
    user_signed_in? ? "application" : "public"
  end
end
```

---

## 4. Passando dados para o Layout

Às vezes você quer mudar o título da página ou adicionar uma classe ao `<body>` baseando-se na página atual.

**Na View:**
```ruby
<% provide(:title, "Detalhes do Produto: #{@produto.nome}") %>
```

**No Layout:**
```html
<title><%= yield(:title) || "Minha Loja" %></title>
```
