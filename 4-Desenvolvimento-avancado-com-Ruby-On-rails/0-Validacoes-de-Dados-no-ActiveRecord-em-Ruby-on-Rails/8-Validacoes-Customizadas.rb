# Validações Customizadas em Ruby on Rails

Quando as validações nativas do Rails (presença, comprimento, etc.) não são suficientes, você pode criar suas próprias regras de negócio personalizadas. Existem três formas principais de fazer isso.

---

## 1. Métodos de Validação Customizados

Esta é a forma mais simples, ideal para validações que não serão reutilizadas em outros modelos. Você usa o método `validate` (no singular) e passa o nome de um método privado.

```ruby
class Pedido < ApplicationRecord
  validate :data_de_entrega_nao_pode_ser_no_passado

  private

  def data_de_entrega_nao_pode_ser_no_passado
    if data_entrega.present? && data_entrega < Date.today
      errors.add(:data_entrega, "não pode ser uma data no passado")
    end
  end
end
```

---

## 2. Custom Each Validators (`ActiveModel::EachValidator`)

Use esta abordagem quando quiser criar uma validação que possa ser aplicada a atributos individuais em vários modelos, da mesma forma que o `presence: true`.

**Passo 1: Criar o validador** (geralmente em `app/validators/email_validator.rb`)
```ruby
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add(attribute, (options[:message] || "não é um e-mail válido"))
    end
  end
end
```

**Passo 2: Usar no Model**
```ruby
class Usuario < ApplicationRecord
  # O Rails procura automaticamente por EmailValidator
  validates :email, email: true
end
```

---

## 3. Custom Validators (`ActiveModel::Validator`)

Ideal para validações complexas que verificam o estado de múltiplos atributos ao mesmo tempo.

**Passo 1: Criar o validador**
```ruby
class MeuValidadorComplexo < ActiveModel::Validator
  def validate(record)
    if record.nome.start_with? 'X'
      record.errors.add :base, "Nomes que começam com X são proibidos neste sistema"
    end
  end
end
```

**Passo 2: Usar no Model**
```ruby
class Pessoa < ApplicationRecord
  validates_with MeuValidadorComplexo
end
```

---

## 4. Adicionando Erros

Para invalidar um objeto, você deve adicionar uma mensagem à coleção `errors`:
- `errors.add(:atributo, "mensagem")`: Erro específico de um campo.
- `errors.add(:base, "mensagem")`: Erro geral do objeto (não atrelado a um campo específico).

---

## Resumo Sênior
- Use **Métodos Privados** para regras rápidas e específicas do modelo atual.
- Use **EachValidator** para regras de campos genéricos (E-mail, CPF, Título de Eleitor) que se repetem no sistema.
- **Dica de Performance:** Validações customizadas podem ser lentas se envolverem consultas ao banco de dados. Tente otimizar ou usar cache quando possível.
- **Localização:** Mantenha seus validadores customizados na pasta `app/validators/` para manter o projeto organizado.
