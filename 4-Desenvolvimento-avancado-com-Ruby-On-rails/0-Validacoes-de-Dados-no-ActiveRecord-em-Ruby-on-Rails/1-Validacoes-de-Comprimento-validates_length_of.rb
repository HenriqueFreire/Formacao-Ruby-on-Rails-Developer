# Validações de Comprimento (validates_length_of)

As validações de comprimento são usadas para garantir que o valor de um atributo tenha uma quantidade específica de caracteres. Elas são essenciais para evitar que dados muito curtos (como uma senha fraca) ou muito longos (que podem quebrar o layout ou exceder o limite do banco de dados) sejam salvos.

---

## 1. Sintaxe

### Forma Moderna (Recomendada)
```ruby
class Usuario < ApplicationRecord
  validates :login, length: { minimum: 3, maximum: 20 }
end
```

### Forma Clássica (Legacy)
```ruby
class Usuario < ApplicationRecord
  validates_length_of :login, minimum: 3, maximum: 20
end
```

---

## 2. Opções de Validação

O Rails oferece várias opções para definir os limites de tamanho:

### A. Comprimento Mínimo (`minimum`)
Garante que a string tenha pelo menos X caracteres.
```ruby
validates :senha, length: { minimum: 8 }
```

### B. Comprimento Máximo (`maximum`)
Garante que a string não ultrapasse X caracteres. Útil para campos de banco de dados com limite de tamanho (ex: `string` de 255 caracteres).
```ruby
validates :bio, length: { maximum: 500 }
```

### C. Comprimento Exato (`is`)
Garante que a string tenha exatamente X caracteres. Ideal para códigos postais (CEP), CPF ou siglas de estados.
```ruby
validates :uf, length: { is: 2 } # Ex: "SP", "RJ"
validates :cep, length: { is: 8 }
```

### D. Intervalo (`in` ou `within`)
Define um limite mínimo e máximo simultaneamente.
```ruby
validates :nome_usuario, length: { in: 3..20 }
```

---

## 3. Mensagens Personalizadas

Você pode personalizar as mensagens para cada tipo de erro de comprimento:

```ruby
class Usuario < ApplicationRecord
  validates :senha, length: {
    minimum: 8,
    too_short: "é muito curta (mínimo de %{count} caracteres)",
    maximum: 128,
    too_long: "é muito longa (máximo de %{count} caracteres)"
  }
end
```

---

## 4. Permitindo Valores Nulos ou Vazios

Às vezes, você quer validar o comprimento **apenas se** o usuário preencher o campo.

- `allow_nil: true`: Ignora a validação se o valor for `nil`.
- `allow_blank: true`: Ignora a validação se o valor for `blank?` (nil ou string vazia).

```ruby
class Perfil < ApplicationRecord
  # O Twitter é opcional, mas se preenchido, deve ter entre 1 e 15 caracteres
  validates :twitter_handle, length: { maximum: 15 }, allow_blank: true
end
```

---

## Resumo Sênior
- Use `validates :campo, length: { ... }` para manter o código moderno.
- Utilize `maximum` para proteger seu banco de dados contra estouro de buffer ou ataques de negação de serviço (DoS) via strings gigantes.
- Combine com `allow_blank: true` para campos opcionais que possuem requisitos de formato.
