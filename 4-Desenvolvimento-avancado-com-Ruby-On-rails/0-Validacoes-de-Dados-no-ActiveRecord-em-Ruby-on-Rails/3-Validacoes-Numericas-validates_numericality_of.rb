# Validações Numéricas (validates_numericality_of)

As validações numéricas garantem que os atributos possuam apenas valores numéricos. Por padrão, elas aceitam números inteiros e decimais (floats).

---

## 1. Sintaxe

### Forma Moderna (Recomendada)
```ruby
class Produto < ApplicationRecord
  validates :preco, numericality: true
end
```

### Forma Clássica (Legacy)
```ruby
class Produto < ApplicationRecord
  validates_numericality_of :preco
end
```

---

## 2. Opções de Validação Numérica

O Rails oferece uma série de restrições que você pode aplicar aos números:

### A. Apenas Inteiros (`only_integer`)
Garante que o valor seja um número inteiro (sem casas decimais).
```ruby
validates :quantidade, numericality: { only_integer: true }
```

### B. Comparações Relacionais
Você pode limitar o valor do número usando operadores matemáticos:

- `greater_than`: Deve ser maior que X.
- `greater_than_or_equal_to`: Deve ser maior ou igual a X.
- `equal_to`: Deve ser exatamente igual a X.
- `less_than`: Deve ser menor que X.
- `less_than_or_equal_to`: Deve ser menor ou igual a X.
- `other_than`: Deve ser diferente de X.

**Exemplo Prático:**
```ruby
class Produto < ApplicationRecord
  validates :preco, numericality: { greater_than: 0 }
  validates :estoque, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
```

### C. Paridade e Outros
- `odd`: Deve ser um número ímpar.
- `even`: Deve ser um número par.

```ruby
validates :numero_da_sorte, numericality: { odd: true }
```

---

## 3. Permitindo Valores Nulos

Se o campo for opcional mas, se preenchido, deve ser numérico, use `allow_nil: true`.

```ruby
class Frete < ApplicationRecord
  # O peso é opcional, mas se informado, deve ser maior que zero
  validates :peso, numericality: { greater_than: 0 }, allow_nil: true
end
```

---

## 4. Personalizando Mensagens

```ruby
class Item < ApplicationRecord
  validates :quantidade, numericality: { 
    only_integer: true, 
    greater_than: 0,
    message: "deve ser um número inteiro positivo" 
  }
end
```

---

## Resumo Sênior
- Use `numericality: true` sempre que o campo representar valores matemáticos (preço, idade, quantidade).
- Combine `only_integer: true` com `greater_than_or_equal_to: 0` para validar quantidades em estoque (evita números negativos e decimais quebrados).
- Note que o ActiveRecord converterá strings como `"123"` para números automaticamente antes de validar, mas falhará se a string contiver letras (ex: `"12a3"`).
