# Trabalho com Layouts e Renderização Parcial

O Rails oferece ferramentas poderosas para evitar a repetição de código HTML (princípio DRY) e manter uma estrutura visual consistente.

---

## 1. Layouts

Layouts são "molduras" que envolvem o conteúdo das suas views. O layout padrão é o `app/views/layouts/application.html.erb`.

### O que um Layout deve conter?
Geralmente contém as tags `<html>`, `<head>`, `<body>`, além de cabeçalhos e rodapés globais.

```html
<!-- app/views/layouts/application.html.erb -->
<!DOCTYPE html>
<html>
  <head>
    <title><%= yield(:title) || "Meu App Rails" %></title>
    <%= csrf_meta_tags %>
    <%= stylesheet_link_tag "application" %>
  </head>
  <body>
    <header>
      <h1>Minha Aplicação</h1>
    </header>

    <main>
      <!-- O yield é onde o conteúdo da view específica será injetado -->
      <%= yield %>
    </main>

    <footer>
      <p>Copyright 2024</p>
    </footer>
  </body>
</html>
```

---

## 2. Renderização Parcial (Partials)

Partiais permitem que você extraia pedaços de HTML para arquivos separados e os reutilize.
**Regra de Ouro:** O nome do arquivo de uma partial deve começar com um sublinhado (ex: `_produto.html.erb`), mas você a chama sem o sublinhado.

### Exemplo Simples:
```html
<!-- Chamando a partial em index.html.erb -->
<%= render "compartilhado/menu_lateral" %>
```

### Passando Dados para Partiais:
Sempre prefira passar variáveis locais explicitamente para manter a partial independente.

```html
<!-- Chamada -->
<%= render "card_produto", produto: @produto %>

<!-- Arquivo _card_produto.html.erb -->
<div class="card">
  <h3><%= produto.nome %></h3>
  <p>R$ <%= produto.preco %></p>
</div>
```

---

## 3. Renderizando Coleções

Em vez de usar um loop `each` manualmente, o Rails oferece um atalho muito eficiente para renderizar uma partial para cada item de uma lista.

**Forma Manual:**
```html
<% @produtos.each do |produto| %>
  <%= render "produto", produto: produto %>
<% end %>
```

**Forma Otimizada (atalho do Rails):**
```html
<%= render partial: "produto", collection: @produtos %>

<!-- Ou ainda mais curto (se a partial tiver o nome do modelo) -->
<%= render @produtos %>
```
*Nesta forma curta, o Rails procura por uma partial chamada `_produto.html.erb` dentro da pasta de produtos e passa cada item como a variável local `produto`.*

---

## 4. Blocos de Conteúdo (`content_for`)

Útil quando você quer injetar algo em uma parte específica do layout que não é o `yield` principal (ex: uma barra lateral diferente para cada página).

**No Layout:**
```html
<aside>
  <%= yield :sidebar %>
</aside>
```

**Na View:**
```html
<% content_for :sidebar do %>
  <ul>
    <li>Link exclusivo desta página</li>
  </ul>
<% end %>
```
