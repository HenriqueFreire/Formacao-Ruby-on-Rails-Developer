# Enviando E-mails com Parâmetros no Action Mailer

Enviar e-mails dinâmicos requer a passagem de dados (parâmetros) do seu código (Controller ou Job) para a classe do Mailer e, consequentemente, para a View do e-mail.

## 1. Método Tradicional (Argumentos no Método)

A forma mais comum é passar objetos ou valores diretamente como argumentos para o método do mailer.

### O Mailer (`app/mailers/order_mailer.rb`):
```ruby
class OrderMailer < ApplicationMailer
  def confirmation_email(user, order)
    @user = user
    @order = order
    
    # Podemos usar os dados para personalizar o assunto
    mail(to: @user.email, subject: "Confirmação do Pedido ##{@order.number}")
  end
end
```

### Chamando o Mailer:
```ruby
# No Controller ou Job
user = User.find(1)
order = Order.find(10)

OrderMailer.confirmation_email(user, order).deliver_later
```

---

## 2. Usando Action Mailer `with` (Recomendado para Rails 5.1+)

O Rails introduziu o método `with`, que passa um hash de parâmetros que fica disponível via `params` dentro do mailer. Isso é similar a como parâmetros funcionam em Controllers.

### O Mailer:
```ruby
class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @referral_code = params[:referral_code]
    
    mail(to: @user.email, subject: 'Bem-vindo ao sistema!')
  end
end
```

### Chamando com `with`:
```ruby
UserMailer.with(user: User.first, referral_code: 'PROMO2024').welcome_email.deliver_later
```

---

## 3. Usando os Parâmetros na View

Qualquer variável de instância (como `@user`) definida no método do mailer estará disponível na sua view (`.html.erb` ou `.text.erb`).

### Exemplo de View (`app/views/order_mailer/confirmation_email.html.erb`):
```html
<h1>Olá, <%= @user.name %>!</h1>
<p>Seu pedido número <strong><%= @order.number %></strong> foi recebido com sucesso.</p>

<h3>Itens do Pedido:</h3>
<ul>
  <% @order.items.each do |item| %>
    <li><%= item.product_name %> - <%= number_to_currency(item.price) %></li>
  <% end %>
</ul>

<p>Total: <%= number_to_currency(@order.total_price) %></p>
```

---

## 4. Anexos (Attachments)

Você também pode passar arquivos como parâmetros ou gerá-los dinamicamente.

```ruby
class ReportMailer < ApplicationMailer
  def monthly_report(admin, pdf_content)
    # Anexo simples
    attachments['relatorio.pdf'] = pdf_content
    
    # Anexo com metadados
    attachments['logo.png'] = {
      content: File.read(Rails.root.join('app/assets/images/logo.png')),
      mime_type: 'image/png'
    }

    mail(to: admin.email, subject: 'Seu Relatório Mensal Chegou')
  end
end
```

---

## 5. Dicas Importantes

1. **Serialize Dados Simples:** Ao usar `deliver_later` (assíncrono), o Active Job serializa os argumentos. Se você passar um objeto ActiveRecord (`@user`), o Rails salva apenas o ID e recarrega o objeto no banco de dados quando o job for executado.
2. **Evite Parâmetros Gigantes:** Não passe objetos muito pesados ou complexos que não podem ser serializados facilmente se estiver usando filas (Redis/Sidekiq).
3. **Validando Presença:** Sempre verifique se os parâmetros obrigatórios foram passados para evitar erros de `NoMethodError` no envio.
