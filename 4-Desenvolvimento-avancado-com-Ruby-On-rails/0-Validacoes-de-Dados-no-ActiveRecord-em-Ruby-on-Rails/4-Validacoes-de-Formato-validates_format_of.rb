# Validações de Formato (validates_format_of)

As validações de formato permitem testar se o valor de um atributo corresponde a uma expressão regular (Regex) específica. Elas são extremamente poderosas para validar e-mails, CEPs, CPFs, URLs e qualquer outro dado que siga um padrão textual fixo.

---

## 1. Sintaxe

### Forma Moderna (Recomendada)
```ruby
class Usuario < ApplicationRecord
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
```

### Forma Clássica (Legacy)
```ruby
class Usuario < ApplicationRecord
  validates_length_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
```

---

## 2. Componentes da Validação

A validação de formato exige o uso de uma das duas opções:
- `:with`: O valor deve corresponder à Regex fornecida.
- `:without`: O valor **não** deve corresponder à Regex fornecida (útil para proibir caracteres específicos).

---

## 3. Exemplos Práticos

### A. Validando um CEP (Brasil)
```ruby
class Endereco < ApplicationRecord
  # Aceita formatos como 01234-567 ou 01234567
  validates :cep, format: { with: /\A\d{5}-?\d{3}\z/, message: "formato inválido (ex: 01234-567)" }
end
```

### B. Validando Somente Letras (Nome)
```ruby
class Pessoa < ApplicationRecord
  # Garante que não existam números ou símbolos no nome
  validates :nome, format: { with: /\A[a-zA-ZÀ-ÿ\s]+\z/ }
end
```

### C. Proibindo domínios específicos (usando `without`)
```ruby
class Cadastro < ApplicationRecord
  # Proíbe e-mails temporários do Mailinator
  validates :email, format: { without: /mailinator\.com/, message: "não aceitamos e-mails temporários" }
end
```

---

## 4. Regra de Ouro do Rails: Âncoras de Regex

No Rails, ao validar formatos, você **DEVE** usar `\A` (início da string) e `\z` (fim da string) em vez de `^` e `$`. 

- `^` e `$` validam o início/fim de uma **linha**.
- `\A` e `\z` validam o início/fim da **string inteira**.

Se você usar `^` ou `$`, o Rails lançará um erro de segurança para evitar ataques de injeção.

---

## Resumo Sênior
- O `validates_format_of` é o "canivete suíço" para dados padronizados.
- Sempre teste suas Regex em ferramentas como [Rubular](https://rubular.com/) antes de aplicar no código.
- Use `message:` para dar um feedback claro, já que a mensagem padrão ("is invalid") não ajuda o usuário a saber o que ele errou.
