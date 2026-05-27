# Validações de Presença (validates_presence_of)

A validação de presença é uma das ferramentas mais fundamentais do ActiveRecord. Ela garante que os atributos especificados não sejam vazios (`nil`, string vazia ou apenas espaços em branco) antes de permitir que o registro seja salvo no banco de dados.

---

## 1. Por que usar?
Garantir a integridade dos dados na camada da aplicação (Model) é a primeira linha de defesa contra dados inconsistentes. Sem essa validação, o banco de dados poderia aceitar usuários sem nome ou produtos sem preço, o que causaria erros em outras partes do sistema.

---

## 2. Sintaxe

### Forma Moderna (Recomendada)
O Rails 3+ introduziu uma sintaxe mais limpa e unificada:
```ruby
class Usuario < ApplicationRecord
  validates :nome, presence: true
  validates :email, presence: true
end
```

### Forma Clássica (Legacy)
Ainda suportada, mas menos utilizada hoje em dia:
```ruby
class Usuario < ApplicationRecord
  validates_presence_of :nome, :email
end
```

---

## 3. Exemplos Práticos

### A. Validando múltiplos campos de uma vez
```ruby
class Produto < ApplicationRecord
  validates :nome, :preco, :codigo_barras, presence: true
end
```

### B. Validando Associações
Você também pode validar se um objeto associado está presente:
```ruby
class Pedido < ApplicationRecord
  belongs_to :cliente
  validates :cliente, presence: true # Garante que o pedido tenha um cliente associado
end
```

---

## 4. O Cuidado com Booleanos (Pegadinha!)
Se você quiser validar se um campo booleano é `true` ou `false` (ou seja, que ele não seja `nil`), o `presence: true` **não funciona corretamente** para o valor `false`, pois o Rails considera `false` como "vazio".

**Forma correta para Booleanos:**
```ruby
class Usuario < ApplicationRecord
  # Queremos garantir que o usuário marcou se aceita os termos (true ou false)
  validates :aceita_termos, inclusion: { in: [true, false] }
end
```

---

## 5. Personalizando Mensagens
```ruby
class Contato < ApplicationRecord
  validates :telefone, presence: { message: "não pode ficar em branco para que possamos te ligar" }
end
```

---

## Resumo Sênior
- Use a sintaxe `validates :atributo, presence: true`.
- Lembre-se que `presence` valida se o valor não é `blank?` (no sentido do Rails).
- Sempre prefira validar no Model, mas considere também adicionar `null: false` nas suas migrações de banco de dados para uma camada extra de segurança.
