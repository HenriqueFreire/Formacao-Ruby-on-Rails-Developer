# Validações de Confirmação (validates_confirmation_of)

A validação de confirmação é usada quando você deseja que o usuário preencha dois campos com o mesmo valor para garantir que não houve erro de digitação. O caso de uso mais clássico é a confirmação de senha ou de e-mail.

---

## 1. Como funciona?

Quando você usa `confirmation: true`, o Rails cria um **atributo virtual** temporário com o sufixo `_confirmation`. 

Por exemplo, se você validar a confirmação de `:password`, o Rails esperará receber também um campo chamado `:password_confirmation`. A validação só falha se os dois valores forem diferentes.

---

## 2. Sintaxe

### Forma Moderna (Recomendada)
```ruby
class Usuario < ApplicationRecord
  validates :password, confirmation: true
end
```

### Forma Clássica (Legacy)
```ruby
class Usuario < ApplicationRecord
  validates_confirmation_of :password
end
```

---

## 3. Exemplo Prático Completo

### No Model:
```ruby
class Usuario < ApplicationRecord
  validates :email, confirmation: true
  validates :email_confirmation, presence: true # Opcional, mas recomendado
end
```

### Na View (Formulário):
```erb
<%= form_with(model: @usuario) do |f| %>
  <div>
    <%= f.label :email %>
    <%= f.email_field :email %>
  </div>

  <div>
    <%= f.label :email_confirmation, "Confirme seu E-mail" %>
    <%= f.email_field :email_confirmation %>
  </div>

  <%= f.submit "Cadastrar" %>
<% end %>
```

---

## 4. O Cuidado com a Verificação Vazia

**AVISO IMPORTANTE:** Por padrão, o Rails só executa a validação de confirmação se o atributo `_confirmation` estiver presente (ou seja, se ele for enviado no formulário). Se o campo de confirmação for deixado em branco e não for enviado, a validação de confirmação **passará**.

Para garantir que o usuário **sempre** preencha a confirmação, você deve adicionar uma validação de presença para o campo de confirmação:

```ruby
class Usuario < ApplicationRecord
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
end
```

---

## 5. Case Sensitivity (Sensibilidade a maiúsculas)
Você pode definir se a confirmação deve ser idêntica inclusive nas letras maiúsculas/minúsculas.

```ruby
validates :email, confirmation: { case_sensitive: false }
```

---

## Resumo Sênior
- O campo `_confirmation` é um atributo virtual; ele não precisa existir na sua tabela do banco de dados.
- Sempre combine `confirmation: true` com `presence: true` no campo de confirmação para evitar que o usuário pule essa etapa.
- Essa validação é puramente de UI/UX, para evitar que o usuário salve uma senha errada sem perceber.
