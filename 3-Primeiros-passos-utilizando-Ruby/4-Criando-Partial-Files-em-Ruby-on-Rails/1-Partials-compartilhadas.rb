# Partials Compartilhadas (Shared Partials)

Partials compartilhadas são componentes de interface que não pertencem a um controller específico, mas que são usados em várias partes da aplicação (ex: cabeçalhos, rodapés, notificações de erro, menus).

---

## 1. Organização de Arquivos
Por convenção, partials que são usadas globalmente no projeto são colocadas em uma pasta chamada `shared` dentro de `app/views/`.

**Estrutura de pastas sugerida:**
- `app/views/shared/_navbar.html.erb`
- `app/views/shared/_footer.html.erb`
- `app/views/shared/_errors.html.erb`

---

## 2. Como Chamar Partials Compartilhadas
Ao renderizar uma partial que está fora da pasta atual do controller, você deve fornecer o caminho completo a partir da pasta `views`.

### Exemplo de Uso na Navbar:
No seu layout principal (`application.html.erb`):
```erb
<body>
  <%= render "shared/navbar" %>
  <%= yield %>
  <%= render "shared/footer" %>
</body>
```

---

## 3. Exemplos Práticos

### A. Exibindo Mensagens de Erro Globais
É comum criar uma partial para exibir erros de validação de qualquer modelo.

**Arquivo: `app/views/shared/_errors.html.erb`**
```html
<% if object.errors.any? %>
  <div id="error_explanation" class="alert alert-danger">
    <h2><%= pluralize(object.errors.count, "erro") %> impediram de salvar:</h2>
    <ul>
      <% object.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  </div>
<% end %>
```

**Uso em qualquer formulário (Clientes, Produtos, etc):**
```erb
<%= form_with(model: @cliente) do |f| %>
  <%= render "shared/errors", object: @cliente %>
  ...
<% end %>
```

### B. Notificações Flash (Alertas e Avisos)
Centraliza as mensagens de sucesso ou erro que o Rails envia via `notice` ou `alert`.

**Arquivo: `app/views/shared/_flash.html.erb`**
```html
<% flash.each do |key, value| %>
  <div class="flash-message <%= key %>">
    <%= value %>
  </div>
<% end %>
```

**Uso no layout global:**
```erb
<%= render "shared/flash" %>
```

---

## 4. Vantagens das Partials Compartilhadas
1. **Centralização:** Se o design da barra de navegação mudar, você altera apenas um arquivo.
2. **Consistência:** Garante que alertas de erro tenham a mesma aparência em todo o sistema.
3. **Legibilidade:** O arquivo de layout não fica entulhado com centenas de linhas de HTML.
