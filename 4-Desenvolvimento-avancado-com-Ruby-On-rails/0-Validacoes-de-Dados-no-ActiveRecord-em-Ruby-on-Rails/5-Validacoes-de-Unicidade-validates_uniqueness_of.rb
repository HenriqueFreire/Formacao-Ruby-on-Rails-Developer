# Validações de Unicidade (validates_uniqueness_of)

A validação de unicidade garante que o valor de um atributo seja único em toda a tabela do banco de dados. É fundamental para campos como E-mail, CPF, Nome de Usuário ou SKUs de produtos.

---

## 1. Sintaxe

### Forma Moderna (Recomendada)
```ruby
class Usuario < ApplicationRecord
  validates :email, uniqueness: true
end
```

### Forma Clássica (Legacy)
```ruby
class Usuario < ApplicationRecord
  validates_uniqueness_of :email
end
```

---

## 2. Opções de Unicidade

### A. Escopo (`scope`)
Às vezes, um valor não precisa ser único em toda a tabela, mas sim dentro de um contexto específico.
```ruby
class ItemPedido < ApplicationRecord
  # O mesmo produto só pode aparecer uma vez dentro do mesmo pedido
  validates :produto_id, uniqueness: { scope: :pedido_id, message: "já foi adicionado a este pedido" }
end
```

### B. Sensibilidade a Maiúsculas (`case_sensitive`)
Por padrão, a validação de unicidade é case-sensitive (dependendo do banco de dados). Você pode forçar que ela ignore a diferença entre maiúsculas e minúsculas.
```ruby
class Usuario < ApplicationRecord
  # "Joao@Email.com" e "joao@email.com" serão considerados duplicados
  validates :email, uniqueness: { case_sensitive: false }
end
```

---

## 3. A "Pegadinha" da Condição de Corrida (Race Condition)

**AVISO SÊNIOR:** A validação `uniqueness` do Rails acontece no nível da aplicação (Ruby). Ela faz um `SELECT` para ver se o valor existe e depois um `INSERT`. 

Em sistemas de alto tráfego, dois processos podem fazer o `SELECT` ao mesmo tempo, ambos verem que o valor não existe, e ambos tentarem inserir, gerando uma duplicata.

**Solução:** Sempre adicione um **Índice Único** na sua migration do banco de dados para garantir 100% de segurança:
```ruby
# Na sua migration:
add_index :usuarios, :email, unique: true
```

---

## 4. Combinando com outras validações
```ruby
class Produto < ApplicationRecord
  validates :sku, presence: true, uniqueness: true, length: { minimum: 5 }
end
```

---

## Resumo Sênior
- Use `uniqueness: true` para garantir que dados de identificação não se repitam.
- Use `scope` para unicidade composta (ex: um aluno não pode ter dois cadastros na mesma turma).
- **Nunca confie apenas na validação do Rails para unicidade crítica;** sempre use restrições de banco de dados (`unique index`) para evitar inconsistências causadas por concorrência.
