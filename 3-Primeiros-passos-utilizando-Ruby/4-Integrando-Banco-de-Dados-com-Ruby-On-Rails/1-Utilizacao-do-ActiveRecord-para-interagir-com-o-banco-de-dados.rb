# Utilização do ActiveRecord para Interagir com o Banco de Dados

O ActiveRecord vai muito além do CRUD básico. Ele oferece ferramentas poderosas para gerenciar o ciclo de vida dos objetos e otimizar consultas.

---

## 1. Callbacks (Ganchos)

Callbacks permitem disparar lógica em momentos específicos do ciclo de vida de um objeto (antes ou depois de salvar, validar, deletar, etc.).

**Exemplo:**
```ruby
class Usuario < ApplicationRecord
  before_save :normalizar_email
  after_create :enviar_boas_vindas

  private

  def normalizar_email
    self.email = email.downcase
  end

  def enviar_boas_vindas
    puts "Enviando e-mail de boas-vindas para #{self.nome}..."
  end
end
```

---

## 2. Evitando o Problema N+1 (Eager Loading)

O problema N+1 ocorre quando você busca registros e, para cada um deles, faz uma nova consulta no banco (ex: buscar posts e depois buscar o autor de cada post). Usamos o `includes` para resolver isso.

**Forma ineficiente:**
```ruby
# Faz 1 consulta para posts + N consultas para autores
@posts = Post.all
@posts.each { |post| puts post.autor.nome }
```

**Forma eficiente (Eager Loading):**
```ruby
# Faz apenas 2 consultas no total
@posts = Post.includes(:autor).all
@posts.each { |post| puts post.autor.nome }
```

---

## 3. Enums

Enums permitem mapear atributos inteiros no banco de dados para strings amigáveis no Ruby.

**Exemplo:**
```ruby
class Pedido < ApplicationRecord
  # No banco, o campo 'status' é um integer (0, 1, 2)
  enum status: { pendente: 0, processando: 1, enviado: 2, entregue: 3 }
end

# Uso:
pedido = Pedido.new
pedido.processando! # Define o status e salva
pedido.enviado?     # Retorna false
Pedido.entregue     # Busca todos os pedidos entregues
```

---

## 4. Consultas Avançadas e Projeções

### Pluck (Busca apenas colunas específicas e retorna um Array)
```ruby
# Retorna ['Teclado', 'Mouse', 'Monitor']
nomes = Produto.pluck(:nome)
```

### Select (Busca colunas específicas mas retorna Objetos)
```ruby
# Retorna objetos Produto apenas com os campos id e nome
@produtos = Produto.select(:id, :nome)
```

### Agregações
```ruby
total = Produto.sum(:preco)
media = Produto.average(:preco)
quantidade = Produto.count
```

---

## 5. Transações

As transações garantem que um bloco de código seja executado inteiramente ou não seja executado de forma alguma (Atomicidade).

```ruby
ActiveRecord::Base.transaction do
  conta_origem.sacar!(100)
  conta_destino.depositar!(100)
end
# Se qualquer um falhar, o banco volta ao estado original.
```
