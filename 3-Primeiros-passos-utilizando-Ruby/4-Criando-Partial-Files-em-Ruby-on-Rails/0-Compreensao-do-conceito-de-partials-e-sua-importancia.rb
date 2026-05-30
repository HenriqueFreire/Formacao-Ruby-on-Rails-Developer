# Compreensão do Conceito de Partials e sua Importância

As Partials (ou "Parciais") são uma das ferramentas mais poderosas do Ruby on Rails para organizar a interface do usuário e seguir o princípio DRY (Don't Repeat Yourself).

---

## 1. O que são Partials?
Partials são fragmentos de views (HTML/ERB) extraídos para arquivos separados. Elas permitem que você divida o processo de renderização em pedaços menores, reutilizáveis e fáceis de manter.

**Regra de Nomeação:**
O nome do arquivo de uma partial deve SEMPRE começar com um sublinhado (underscore).
- Arquivo: `_meu_componente.html.erb`
- Chamada: `<%= render "meu_componente" %>`

---

## 2. Por que usar Partials?
1. **DRY (Don't Repeat Yourself):** Evita duplicar código (ex: o mesmo formulário para 'Novo' e 'Editar').
2. **Organização:** Mantém arquivos de visualização principais (index, show) limpos e legíveis.
3. **Reutilização:** Um card de produto pode ser usado na Home, na Busca e no Carrinho.
4. **Manutenção:** Se precisar alterar um estilo, você altera em um único arquivo de partial.

---

## 3. Exemplos Práticos

### A. Reutilizando Formulários
É a prática mais comum no Rails para unificar os formulários de criação e edição.

**Arquivo: `app/views/produtos/_form.html.erb`**
```html
<%= form_with(model: produto) do |f| %>
  <div>
    <%= f.label :nome %>
    <%= f.text_field :nome %>
  </div>
  <%= f.submit "Salvar" %>
<% end %>
```

**Uso no `new.html.erb` ou `edit.html.erb`:**
```erb
<%= render "form", produto: @produto %>
```

### B. Passando Variáveis Locais (`locals`)
Para tornar uma partial verdadeiramente independente, evite usar variáveis de instância (com `@`) dentro dela. Em vez disso, passe variáveis locais.

**Chamada:**
```erb
<%= render partial: "card_usuario", locals: { usuario: @usuario, destaque: true } %>
```

**Na Partial (`_card_usuario.html.erb`):**
```html
<div class="card <%= 'destaque' if destaque %>">
  <h3><%= usuario.nome %></h3>
</div>
```

### C. Renderizando Coleções (Collections)
O Rails otimiza a renderização de listas inteiras usando partials.

**Forma Manual (Lenta):**
```erb
<% @produtos.each do |p| %>
  <%= render "produto", produto: p %>
<% end %>
```

**Forma Otimizada (Rápida):**
```erb
<%= render partial: "produto", collection: @produtos %>

<!-- Ou a forma abreviada mágica do Rails: -->
<%= render @produtos %>
```
*(Neste caso, o Rails procura automaticamente por `_produto.html.erb` e passa cada item como a variável local `produto`.)*
