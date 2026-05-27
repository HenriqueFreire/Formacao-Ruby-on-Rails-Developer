  # Validações de Aceitação (validates_acceptance_of)

A validação de aceitação é usada principalmente para garantir que o usuário aceitou os Termos de Serviço, uma Política de Privacidade ou qualquer outra confirmação de checkbox em um formulário.

Diferente de outras validações, por padrão, ela **não exige um campo no banco de dados**. O Rails cria um atributo virtual para realizar a verificação apenas durante a submissão do formulário.

---

## 1. Sintaxe

### Forma Moderna (Recomendada)
```ruby
class Usuario < ApplicationRecord
  validates :termos_de_servico, acceptance: true
end
```

### Forma Clássica (Legacy)
```ruby
class Usuario < ApplicationRecord
  validates_acceptance_of :termos_de_servico
end
```

---

## 2. Como funciona o Atributo Virtual

Se você não tiver uma coluna `termos_de_servico` na sua tabela `usuarios`, o Rails criará um atributo temporário. 
- Se o checkbox for marcado (enviando "1"), a validação passa.
- Se não for marcado, a validação falha.

**Nota:** Se você quiser salvar o registro de que o usuário aceitou (por questões jurídicas), você deve criar a coluna no banco de dados (geralmente um booleano).

---

## 3. Customizando Valores Aceitos

Por padrão, o Rails aceita os valores `['1', true]` como "aceito". Você pode mudar isso usando a opção `accept`.

```ruby
class Cadastro < ApplicationRecord
  # Aceita apenas se o valor enviado for "sim"
  validates :concordo_com_regras, acceptance: { accept: 'sim' }
  
  # Aceita múltiplos valores
  validates :politica_privacidade, acceptance: { accept: ['true', 'aceito'] }
end
```

---

## 4. Exemplo Prático (Model + View)

### No Model:
```ruby
class Usuario < ApplicationRecord
  validates :termos, acceptance: { message: 'precisam ser aceitos para continuar' }
end
```

### Na View (ERB):
```erb
<%= form_with(model: @usuario) do |f| %>
  <div class="field">
    <%= f.check_box :termos %>
    <%= f.label :termos, "Eu li e aceito os termos de serviço" %>
  </div>

  <%= f.submit "Cadastrar" %>
<% end %>
```

---

## Resumo Sênior
- O `validates_acceptance_of` é ideal para checkboxes que não precisam ser persistidos (como "Lembrar-me" ou "Aceito os Termos").
- Se precisar persistir a aceitação, crie uma migration adicionando a coluna booleana, mas a validação no model continua a mesma.
- Lembre-se que essa validação só ocorre se o atributo for enviado. Se o campo não estiver no formulário, a validação não será disparada (a menos que você configure o contrário).
