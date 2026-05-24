# Compreensão da Arquitetura MVC (Model-View-Controller) em Rails

O Ruby on Rails utiliza o padrão de arquitetura MVC para organizar a lógica da aplicação, facilitando a manutenção e a escalabilidade.

## 1. Model (Modelo)
O **Model** é responsável pela lógica de dados e pelas regras de negócio. Ele interage com o banco de dados.

**Exemplo:**
Imagine um modelo `Produto`. Ele define o que é um produto e quais validações ele possui.

```ruby
# app/models/produto.rb
class Produto < ApplicationRecord
  validates :nome, presence: true
  validates :preco, numericality: { greater_than: 0 }

  def self.disponiveis
    where(ativo: true)
  end
end
```

## 2. View (Visão)
A **View** é a interface do usuário. No Rails, costumam ser arquivos HTML com código Ruby embutido (ERB - Embedded Ruby). Sua única função é exibir dados para o usuário.

**Exemplo:**
Uma página que lista os produtos.

```html
<!-- app/views/produtos/index.html.erb -->
<h1>Lista de Produtos</h1>

<ul>
  <% @produtos.each do |produto| %>
    <li><%= produto.nome %> - R$ <%= produto.preco %></li>
  <% end %>
</ul>
```

## 3. Controller (Controlador)
O **Controller** é o "maestro". Ele recebe as requisições do usuário (via rotas), busca os dados necessários no **Model** e os envia para a **View**.

**Exemplo:**
Um controlador que gerencia as ações relacionadas a produtos.

```ruby
# app/controllers/produtos_controller.rb
class ProdutosController < ApplicationController
  def index
    # O Controller pede os dados ao Model
    @produtos = Produto.disponiveis
    
    # Por padrão, o Rails renderiza a view app/views/produtos/index.html.erb
  end
end
```

## Resumo do Fluxo:
1. O **Usuário** acessa uma URL (ex: `/produtos`).
2. O **Roteador** do Rails direciona para a ação `index` do `ProdutosController`.
3. O **Controller** solicita ao **Model** `Produto` todos os produtos disponíveis.
4. O **Model** busca no banco de dados e retorna para o **Controller**.
5. O **Controller** pega esses dados e "injeta" na **View** `index.html.erb`.
6. A **View** processa o HTML e o envia de volta para o navegador do **Usuário**.
