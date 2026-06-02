# Will Paginate: Paginação simples para Ruby on Rails

A gem `will_paginate` é uma das bibliotecas mais antigas e populares para adicionar paginação em aplicações Ruby on Rails. Ela permite dividir grandes listas de registros em várias páginas de forma fácil e intuitiva.

## 1. Instalação

Adicione ao seu `Gemfile`:

```ruby
gem 'will_paginate', '~> 3.3'
```

E execute:
```bash
bundle install
```

---

## 2. Uso Básico no Model / Controller

Para paginar uma consulta, utilizamos o método `.paginate`.

### Exemplo no Controller:

```ruby
# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def index
    # :page indica a página atual (geralmente vinda dos params)
    # :per_page define quantos registros exibir por página
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end
end
```

---

## 3. Exibindo a Paginação na View

Para renderizar os links de navegação (Anterior, 1, 2, Próximo), utilizamos o helper `will_paginate`.

### Exemplo na View (ERB):

```erb
<!-- app/views/posts/index.html.erb -->

<h1>Lista de Posts</h1>

<ul>
  <% @posts.each do |post| %>
    <li><%= post.title %></li>
  <% end %>
</ul>

<!-- Renderiza os controles de paginação -->
<%= will_paginate @posts %>
```

---

## 4. Customização e Localização (I18n)

Você pode alterar os textos dos botões diretamente no helper:

```erb
<%= will_paginate @posts, previous_label: "Anterior", next_label: "Próximo" %>
```

Ou globalmente via I18n no arquivo `config/locales/pt-BR.yml`:

```yaml
pt-BR:
  will_paginate:
    previous_label: "&#8592; Anterior"
    next_label: "Próximo &#8594;"
    page_gap: "&hellip;"
```

---

## 5. Paginação em Arrays

Se você precisar paginar um array comum (não um objeto do ActiveRecord), precisará fazer um require adicional:

```ruby
require 'will_paginate/array'

@meu_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].paginate(page: 1, per_page: 5)
```

---

## Resumo das Vantagens
- Extremamente fácil de configurar.
- Sintaxe amigável.
- Grande suporte da comunidade e plugins para Bootstrap/Foundation.
