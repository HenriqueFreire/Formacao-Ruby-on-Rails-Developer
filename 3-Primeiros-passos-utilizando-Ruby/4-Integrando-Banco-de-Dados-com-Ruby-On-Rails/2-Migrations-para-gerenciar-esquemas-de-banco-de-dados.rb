# Migrations para Gerenciar Esquemas de Banco de Dados

As Migrações (Migrations) são a linguagem do Rails para alterar o banco de dados. Elas permitem que você descreva as alterações usando Ruby, mantendo o banco sincronizado com o código em qualquer máquina.

---

## 1. Comandos de Geração Mais Comuns

O Rails tenta adivinhar o que você quer fazer baseando-se no nome da migração.

```bash
# Adicionar uma coluna a uma tabela existente
bin/rails generate migration AddDescricaoToProdutos descricao:text

# Remover uma coluna
bin/rails generate migration RemovePrecoFromProdutos preco:decimal

# Criar uma tabela de junção (Join Table) para N-para-N
bin/rails generate migration CreateJoinTableUsuariosProdutos usuario produto
```

---

## 2. Anatomia de uma Migração

As migrações modernas usam o método `change`, que o Rails sabe como "reverter" automaticamente (ex: se o `change` cria uma tabela, o rollback a apaga).

```ruby
class AddStatusToPedidos < ActiveRecord::Migration[7.0]
  def change
    # Adiciona coluna com valor padrão e índice
    add_column :pedidos, :status, :string, default: "pendente"
    add_index :pedidos, :status

    # Renomeia uma coluna
    rename_column :pedidos, :data, :data_do_pedido

    # Altera o tipo ou restrições de uma coluna
    change_column_null :pedidos, :valor_total, false
  end
end
```

---

## 3. Métodos `up` e `down`

Quando uma migração é complexa demais para o Rails reverter sozinho (como deletar dados ou colunas sem um tipo óbvio de volta), usamos `up` e `down`.

```ruby
class MinhaMigracaoComplexa < ActiveRecord::Migration[7.0]
  def up
    # O que acontece ao rodar a migração
    add_column :usuarios, :nome_completo, :string
    # Exemplo de migração de dados:
    Usuario.all.each { |u| u.update(nome_completo: "#{u.nome} #{u.sobrenome}") }
  end

  def down
    # O que acontece ao reverter (rollback)
    remove_column :usuarios, :nome_completo
  end
end
```

---

## 4. Gerenciando o Status das Migrações

```bash
# Verifica quais migrações já foram rodadas (up) e quais faltam (down)
bin/rails db:migrate:status

# Reverte a última migração
bin/rails db:rollback

# Reverte as últimas 3 migrações
bin/rails db:rollback STEP=3

# Roda as migrações apenas para o ambiente de teste
RAILS_ENV=test bin/rails db:migrate
```

---

## 5. Boas Práticas
1. **Nunca edite uma migração que já foi enviada para o servidor.** Em vez disso, crie uma nova migração para corrigir a anterior.
2. **Use índices:** Sempre adicione índices em colunas que você usa com frequência em buscas (`where`) ou associações (`belongs_to`).
3. **Mantenha o schema.rb atualizado:** O arquivo `db/schema.rb` é a representação final do seu banco. Ele é atualizado automaticamente ao rodar `db:migrate`.
