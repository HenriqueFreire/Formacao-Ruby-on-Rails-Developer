# Configurando SendGrid para Envio de E-mails no Rails

O SendGrid é um dos serviços de entrega de e-mail mais populares. No Rails, podemos integrá-lo facilmente via SMTP ou através da API oficial.

## 1. Obtendo a API Key do SendGrid

1. Crie uma conta no [SendGrid](https://sendgrid.com/).
2. Vá em **Settings** > **API Keys**.
3. Clique em **Create API Key**, dê um nome e selecione **Full Access** (ou apenas Mail Send).
4. Copie a chave gerada. **Importante:** Guarde-a em um lugar seguro; ela não será mostrada novamente.

## 2. Configurando Variáveis de Ambiente

Nunca coloque sua chave de API diretamente no código. Use gemas como `dotenv-rails` ou o sistema de `credentials` do Rails.

No arquivo `.env`:
```bash
SENDGRID_API_KEY=SG.sua_chave_aqui_...
```

## 3. Configuração SMTP (Método mais comum)

Edite o arquivo `config/environments/production.rb` (ou `development.rb` para testes):

```ruby
Rails.application.configure do
  # ... outras configurações ...

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  
  config.action_mailer.smtp_settings = {
    user_name: 'apikey', # O nome de usuário é literalmente a string 'apikey'
    password: ENV['SENDGRID_API_KEY'], # Sua API Key criada no painel
    domain: 'seu-dominio.com',
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }
end
```

## 4. Verificação de Remetente (Sender Authentication)

Para que seus e-mails não caiam no spam, o SendGrid exige que você verifique seu remetente:
- **Single Sender Verification:** Verifica um único endereço de e-mail.
- **Domain Authentication:** Verifica todo o seu domínio (recomendado para produção).

No seu Mailer, o `from` deve ser um e-mail verificado:
```ruby
class ApplicationMailer < ActionMailer::Base
  default from: 'contato@seu-dominio-verificado.com'
  layout 'mailer'
end
```

## 5. Usando a Gem SendGrid (Opcional - via API)

Se preferir usar a API HTTP em vez de SMTP, adicione ao `Gemfile`:
`gem 'sendgrid-ruby'`

Exemplo de envio direto via API:
```ruby
require 'sendgrid-ruby'
include SendGrid

def send_custom_email
  from = Email.new(email: 'test@example.com')
  to = Email.new(email: 'destinatario@example.com')
  subject = 'Enviando com a API do SendGrid'
  content = Content.new(type: 'text/plain', value: 'Olá, este é um teste via API!')
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  
  puts response.status_code
  puts response.body
end
```

## 6. Dicas de Segurança

- **Whitelabeling:** Configure o DKIM e SPF no seu provedor de DNS seguindo as instruções do SendGrid para melhorar a entregabilidade.
- **Logs:** O SendGrid possui um painel de **Activity** onde você pode ver se o e-mail foi entregue, aberto ou se houve erro (bounce).
