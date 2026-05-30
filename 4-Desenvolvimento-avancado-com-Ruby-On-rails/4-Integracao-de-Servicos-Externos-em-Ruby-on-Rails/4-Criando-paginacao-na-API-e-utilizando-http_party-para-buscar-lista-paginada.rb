# Paginação na API e Consumo com HTTParty

Em aplicações reais, listar milhares de registros de uma vez é ineficiente. A **paginação** divide os dados em pedaços (páginas), melhorando a performance e a experiência do usuário.

---

## 1. Parte 1: Implementando Paginação na API (Servidor)

No Rails, as gems mais comuns para isso são `pagy`, `kaminari` ou `will_paginate`. Atualmente, a **Pagy** é a mais recomendada por ser extremamente leve.

### Exemplo no Controller da API:

```ruby
# app/controllers/api/v1/posts_controller.rb
class Api::V1::PostsController < ActionController::API
  include Pagy::Backend

  def index
    # Pagina os posts (ex: 10 por página)
    # O parâmetro :page é lido automaticamente de params[:page]
    @pagy, @posts = pagy(Post.all, items: 10)

    # Retornamos os dados e informações de metadados da paginação
    render json: {
      data: @posts,
      meta: {
        current_page: @pagy.page,
        next_page: @pagy.next,
        prev_page: @pagy.prev,
        total_pages: @pagy.pages,
        total_count: @pagy.count
      }
    }
  end
end
```

---

## 2. Parte 2: Buscando Lista Paginada com HTTParty (Cliente)

Para consumir essa API, precisamos enviar o parâmetro da página que desejamos consultar.

### Exemplo de Cliente Ruby com HTTParty:

```ruby
require 'httparty'

class PostClient
  include HTTParty
  base_uri 'http://localhost:3000/api/v1'

  def listar_posts(pagina = 1)
    options = { query: { page: pagina } }
    response = self.class.get("/posts", options)
    
    if response.success?
      response.parsed_response
    else
      nil
    end
  end
end

# Utilizando o cliente
client = PostClient.new

# Busca a página 1
pagina1 = client.listar_posts(1)
puts "Exibindo página #{pagina1['meta']['current_page']} de #{pagina1['meta']['total_pages']}"
pagina1['data'].each { |post| puts "- #{post['title']}" }

# Busca a próxima página se existir
if pagina1['meta']['next_page']
  puts "\nBuscando próxima página..."
  pagina2 = client.listar_posts(pagina1['meta']['next_page'])
  # ... processa página 2
end
```

---

## 3. Buscando Todos os Registros (Iteração Automática)

Às vezes, você precisa baixar todos os dados de uma API paginada. Podemos fazer isso com um loop:

```ruby
def baixar_tudo
  pagina_atual = 1
  todos_os_posts = []

  loop do
    puts "Baixando página #{pagina_atual}..."
    resultado = client.listar_posts(pagina_atual)
    
    break if resultado.nil? || resultado['data'].empty?

    todos_os_posts.concat(resultado['data'])
    
    break unless resultado['meta']['next_page']
    pagina_atual = resultado['meta']['next_page']
  end

  puts "Total de posts baixados: #{todos_os_posts.count}"
  todos_os_posts
end
```

---

## Resumo das Melhores Práticas

1.  **Metadados na Resposta**: Sempre retorne informações como `total_pages` e `next_page` na sua API para facilitar a vida de quem a consome.
2.  **Limites de Itens**: No servidor, defina um limite máximo para o parâmetro `per_page` (ou `items`) para evitar que um usuário mal-intencionado solicite 1.000.000 de itens de uma vez.
3.  **Performance**: Certifique-se de que as colunas usadas para ordenação na paginação (geralmente `created_at` ou `id`) possuem índices no banco de dados.
