# Configurando Action Mailer em uma Aplicação Rails

O Action Mailer permite que você envie e-mails de sua aplicação usando classes e views de mailer.

## 1. Configuração por Ambiente

As configurações de e-mail geralmente variam entre ambientes (desenvolvimento, teste, produção). Elas são definidas nos arquivos dentro de `config/environments/`.

### Desenvolvimento (config/environments/development.rb)
No desenvolvimento, muitas vezes queremos apenas ver os e-mails no console ou usar uma ferramenta como o MailHog/Letter Opener.

```ruby
Rails.application.configure do
  # Não ignora erros de entrega
  config.action_mailer.raise_delivery_errors = true

  # Método de entrega: :smtp, :sendmail, :test, :file
  config.action_mailer.delivery_method = :smtp
  
  # Configuração SMTP (Exemplo com MailHog ou servidor local)
  config.action_mailer.smtp_settings = {
    address: 'localhost',
    port: 1025
  }

  # Configuração da URL padrão para links nos e-mails
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
end
```

### Produção (config/environments/production.rb)
Em produção, você usará um serviço real como SendGrid, AWS SES, Mailgun, etc.

#### Exemplo com SendGrid (SMTP):
```ruby
Rails.application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    :user_name => 'apikey', # Texto fixo 'apikey' para SendGrid
    :password => ENV['SENDGRID_API_KEY'],
    :domain => 'seu-dominio.com',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }

  config.action_mailer.default_url_options = { host: 'seu-site.com' }
end
```

## 2. Criando um Mailer

Você pode gerar um mailer via terminal:
`rails generate mailer UserMailer`

Isso criará `app/mailers/user_mailer.rb`:

```ruby
class UserMailer < ApplicationMailer
  default from: 'notificacoes@exemplo.com'

  def bem_vindo_email(user)
    @user = user
    @url  = 'http://exemplo.com/login'
    mail(to: @user.email, subject: 'Bem-vindo ao Meu Site Incrível')
  end
end
```

## 3. Criando as Views do E-mail

Os e-mails precisam de templates em `app/views/user_mailer/`.

### Texto (bem_vindo_email.text.erb):
```erb
Bem-vindo ao exemplo.com, <%= @user.name %>
===============================================

Você se cadastrou com sucesso no exemplo.com.
Para fazer login, basta seguir este link: <%= @url %>.

Obrigado por se juntar a nós!
```

### HTML (bem_vindo_email.html.erb):
```html
<!DOCTYPE html>
<html>
  <head>
    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
  </head>
  <body>
    <h1>Bem-vindo ao exemplo.com, <%= @user.name %></h1>
    <p>
      Você se cadastrou com sucesso no exemplo.com.
      Seu nome de usuário é: <%= @user.login %>.<br>
    </p>
    <p>
      Para fazer login no site, basta seguir este link: <a href="<%= @url %>">Fazer Login</a>.
    </p>
    <p>Obrigado por se juntar a nós e tenha um ótimo dia!</p>
  </body>
</html>
```

## 4. Enviando o E-mail

No seu controller ou em um job:

```ruby
# Envio síncrono (bloqueia a requisição)
UserMailer.bem_vindo_email(@user).deliver_now

# Envio assíncrono (recomendado, usa Active Job)
UserMailer.bem_vindo_email(@user).deliver_later
```

## 5. Previews de E-mail

O Rails permite visualizar os e-mails no navegador sem enviá-los de verdade.
Configurado em `test/mailers/previews/user_mailer_preview.rb`:

```ruby
class UserMailerPreview < ActionMailer::Preview
  def bem_vindo_email
    UserMailer.bem_vindo_email(User.first)
  end
end
```
Acesse em: `http://localhost:3000/rails/mailers/user_mailer/bem_vindo_email`
