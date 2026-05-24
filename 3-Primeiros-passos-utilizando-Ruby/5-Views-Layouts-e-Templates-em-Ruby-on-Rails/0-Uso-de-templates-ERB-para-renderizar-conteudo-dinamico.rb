# Uso de Templates ERB para Renderizar Conteúdo Dinâmico

O **ERB (Embedded Ruby)** é o sistema de templates padrão do Rails. Ele permite que você insira código Ruby dentro de arquivos HTML, transformando páginas estáticas em aplicações dinâmicas.

---

## 1. As Tags Fundamentais

Existem duas tags principais que você usará constantemente:

### Tag de Expressão `<%= ... %>`
Avalia o código Ruby e **renderiza** o resultado como uma string no HTML.
```html
<p>O nome do usuário é: <%= @usuario.nome %></p>
<p>2 + 2 é igual a: <%= 2 + 2 %></p>
```

### Tag de Execução `<% ... %>`
Apenas executa o código Ruby, mas **não** exibe nada no HTML. É usada para lógica de controle (if, each, etc).
```html
<% if @usuario.admin? %>
  <p>Bem-vindo, Administrador!</p>
<% end %>
```

---

## 2. Iterando sobre Coleções

O uso mais comum do ERB é percorrer uma lista de objetos vindos do controlador.

**No Controlador:**
```ruby
@produtos = Produto.all
```

**Na View (index.html.erb):**
```html
<ul>
  <% @produtos.each do |produto| %>
    <li><%= produto.nome %> - <%= number_to_currency(produto.preco) %></li>
  <% end %>
</ul>
```

---

## 3. Comentários em ERB

Para comentar código dentro das tags ERB (para que não seja executado nem renderizado):
```html
<%# Este comentário não aparecerá no HTML final %>
```

---

## 4. Capturando Conteúdo com `content_for`

O `content_for` permite armazenar um bloco de HTML em um identificador para ser usado em outro lugar (geralmente no Layout).

**Na View:**
```html
<% content_for :scripts do %>
  <script>console.log("Página carregada!");</script>
<% end %>
```

**No Layout (`application.html.erb`):**
```html
<head>
  <%= yield :scripts %>
</head>
```

---

## 5. Escapamento Automático de HTML

Por segurança (evitar ataques XSS), o Rails escapa automaticamente caracteres especiais em strings renderizadas com `<%= %>`.

- Se `@texto = "<b>Negrito</b>"`, o Rails renderizará o texto literal no navegador.
- Para renderizar o HTML real, use o método `.html_safe` ou o helper `raw()`:
```html
<%= @texto.html_safe %>
```
*(Use com cautela! Nunca use isso em dados fornecidos por usuários sem sanitização).*
