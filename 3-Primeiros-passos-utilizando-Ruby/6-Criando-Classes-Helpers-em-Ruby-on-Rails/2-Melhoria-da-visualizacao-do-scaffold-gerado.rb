# Melhoria da Visualização do Scaffold Gerado

O código gerado pelo `rails generate scaffold` é excelente para produtividade inicial, mas o design padrão é extremamente simples e não deve ser usado em produção. Aqui exploramos como melhorá-lo.

---

## 1. Customizando o CSS do Scaffold

O Rails gera um arquivo chamado `app/assets/stylesheets/scaffolds.scss`. A primeira coisa que muitos desenvolvedores fazem é apagar o conteúdo desse arquivo ou sobrescrevê-lo com seu próprio framework (como Bootstrap ou Tailwind).

**Exemplo de melhoria via CSS puro:**
```css
/* app/assets/stylesheets/custom.css */
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

th, td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

tr:hover { background-color: #f5f5f5; }

.btn-primary {
  background-color: #007bff;
  color: white;
  padding: 8px 16px;
  text-decoration: none;
  border-radius: 4px;
}
```

---

## 2. Usando Helpers para Embelezar Dados

Em vez de exibir dados brutos do banco, use Helpers para formatar a saída.

**Exemplo (Moeda e Data):**
```html
<!-- index.html.erb (Gerado) -->
<td><%= produto.preco %></td>

<!-- index.html.erb (Melhorado) -->
<td><%= number_to_currency(produto.preco, unit: "R$", separator: ",", delimiter: ".") %></td>
<td><%= l(produto.created_at, format: :short) %></td>
```

---

## 3. Melhorando o Formulário (`_form.html.erb`)

O scaffold gera um formulário funcional, mas visualmente desorganizado. Você pode usar classes de grid e labels melhores.

```html
<!-- app/views/produtos/_form.html.erb -->
<%= form_with(model: produto, class: "contents") do |form| %>
  <div class="field-group">
    <%= form.label :nome, "Nome do Produto" %>
    <%= form.text_field :nome, class: "input-field" %>
  </div>

  <div class="field-group">
    <%= form.label :categoria_id, "Selecione a Categoria" %>
    <%= form.collection_select :categoria_id, Categoria.all, :id, :nome, { prompt: true }, { class: "select-field" } %>
  </div>

  <div class="actions">
    <%= form.submit "Salvar Alterações", class: "btn-save" %>
  </div>
<% end %>
```

---

## 4. Customizando os Templates de Scaffold

Você pode mudar o que o Rails gera por padrão ao rodar o comando scaffold. Basta criar seus próprios templates em `lib/templates`.

1. Crie a pasta: `lib/templates/erb/scaffold/`
2. Crie o arquivo: `index.html.erb` dentro dela.
3. O Rails passará a usar o seu arquivo como base para todos os novos scaffolds.

---

## 5. Adicionando Ícones e Interatividade

Melhore a experiência do usuário adicionando ícones (como FontAwesome) e mensagens de confirmação mais amigáveis.

```html
<%= link_to edit_produto_path(produto) do %>
  <i class="fas fa-edit"></i> Editar
<% end %>

<%= button_to @produto, method: :delete, data: { turbo_confirm: "Deseja realmente excluir este item?" }, class: "btn-danger" do %>
  <i class="fas fa-trash"></i> Excluir
<% end %>
```

---

## 6. Resumo das Melhorias
1. **Layout Geral:** Envolva o scaffold em um layout (`application.html.erb`) com um container centralizado.
2. **Componentes:** Extraia partes repetitivas para Partials e Helpers.
3. **Feedback:** Estilize as mensagens de `notice` e `alert` (flash messages).
4. **Semântica:** Use tags HTML5 apropriadas (`<header>`, `<main>`, `<footer>`, `<section>`).
