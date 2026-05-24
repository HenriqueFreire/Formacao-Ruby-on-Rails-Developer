# Trabalho com Bancos de Dados em Rails (Active Record)

O Rails utiliza o **Active Record** como sua camada de ORM (Object-Relational Mapping). Ele facilita a interação com o banco de dados, permitindo que você manipule dados como se fossem objetos Ruby.

---

## 1. Migrations (Migrações)

As migrações são uma forma de evoluir o esquema do banco de dados de forma controlada e versionada.

**Exemplo de criação de migração via terminal:**
```bash
bin/rails generate migration CreateProdutos nome:string preco:decimal ativo:boolean
```

**Exemplo de um arquivo de migração:**
```ruby
class CreateProdutos < ActiveRecord::Migration[7.0]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.decimal :preco, precision: 8, scale: 2
      t.boolean :ativo, default: true

      t.timestamps # Cria created_at e updated_at
    end
  end
end
```

---

## 2. Operações CRUD Básicas

Com o Active Record, você não precisa escrever SQL para operações comuns.

### Create (Criar)
```ruby
# Cria e salva no banco
produto = Produto.create(nome: "Teclado", preco: 150.00)

# Ou cria em memória e salva depois
produto = Produto.new(nome: "Mouse")
produto.save
```

### Read (Ler)
```ruby
# Busca todos
@produtos = Produto.all

# Busca por ID
@produto = Produto.find(1)

# Busca com filtros
@produtos_caros = Produto.where("preco > ?", 100)

# Busca o primeiro ou último
@primeiro = Produto.first
@ultimo = Produto.last
```

### Update (Atualizar)
```ruby
@produto = Produto.find(1)
@produto.update(preco: 120.00)
```

### Delete (Excluir)
```ruby
@produto = Produto.find(1)
@produto.destroy
```

---

## 3. Validações

As validações garantem que apenas dados válidos sejam salvos no banco.

```ruby
class Produto < ApplicationRecord
  validates :nome, presence: true, uniqueness: true
  validates :preco, numericality: { greater_than: 0 }
end
```

---

## 4. Scopes (Escopos)

Scopes permitem definir consultas reutilizáveis dentro do modelo.

```ruby
class Produto < ApplicationRecord
  scope :ativos, -> { where(ativo: true) }
  scope :baratos, -> { where("preco < 50") }
end

# Uso:
@produtos_disponiveis = Produto.ativos.baratos
```

---

## 5. Console do Rails

Uma ferramenta poderosa para testar comandos de banco de dados é o console:
```bash
bin/rails console
# Dentro do console, você pode digitar comandos Ruby:
> Produto.count
> p = Produto.first
> p.nome
```
