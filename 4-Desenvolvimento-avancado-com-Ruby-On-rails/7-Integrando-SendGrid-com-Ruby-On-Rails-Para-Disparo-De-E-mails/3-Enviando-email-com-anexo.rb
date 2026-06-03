# Enviando E-mails com Anexos no Action Mailer

O Action Mailer facilita a inclusão de arquivos anexos nos e-mails, sejam eles arquivos físicos no servidor, arquivos gerados dinamicamente ou imagens embutidas (inline).

## 1. Anexo Simples de Arquivo Físico

Para anexar um arquivo que já existe no seu sistema de arquivos, use o método `attachments`.

```ruby
class UserMailer < ApplicationMailer
  def welcome_with_manual(user)
    @user = user
    
    # Lendo um arquivo do disco e anexando
    attachments['manual_do_usuario.pdf'] = File.read(Rails.root.join('public', 'manual.pdf'))
    
    mail(to: @user.email, subject: 'Bem-vindo! Aqui está seu manual')
  end
end
```

## 2. Anexo com Opções Customizadas

Você pode especificar o tipo de conteúdo (MIME type) e outras configurações.

```ruby
def send_invoice(user, invoice)
  attachments['fatura.pdf'] = {
    mime_type: 'application/pdf',
    content: invoice.generate_pdf_string # Supondo um método que gera o PDF
  }
  
  mail(to: user.email, subject: 'Sua Fatura Mensal')
end
```

## 3. Anexos Inline (Imagens no Corpo do E-mail)

Anexos inline são úteis para mostrar logotipos ou imagens diretamente no HTML do e-mail, sem que apareçam como um anexo separado na lista de arquivos do cliente de e-mail.

### No Mailer:
```ruby
class NotificationMailer < ApplicationMailer
  def alert_email(user)
    # O uso de attachments.inline torna o arquivo disponível via CID
    attachments.inline['logo.png'] = File.read(Rails.root.join('app/assets/images/logo.png'))
    
    mail(to: user.email, subject: 'Alerta de Sistema')
  end
end
```

### Na View (`app/views/notification_mailer/alert_email.html.erb`):
```html
<p>Olá, o sistema detectou uma atividade incomum.</p>

<!-- Usamos image_tag com o nome definido no attachments.inline -->
<%= image_tag attachments['logo.png'].url, alt: 'Logo da Empresa' %>

<p>Atenciosamente, Equipe de Suporte.</p>
```

## 4. Múltiplos Anexos

Você pode adicionar quantos anexos forem necessários apenas repetindo a chamada ao hash `attachments`.

```ruby
def monthly_report(admin)
  attachments['janeiro.csv'] = File.read('reports/jan.csv')
  attachments['fevereiro.csv'] = File.read('reports/feb.csv')
  attachments['março.csv'] = File.read('reports/mar.csv')
  
  mail(to: admin.email, subject: 'Relatórios do Trimestre')
end
```

## 5. Cuidados ao Usar Anexos

1. **Tamanho dos Arquivos:** E-mails com anexos muito grandes (geralmente acima de 10MB-25MB) podem ser rejeitados pelo servidor do destinatário ou pelo próprio provedor (como o SendGrid).
2. **Performance:** Ler arquivos grandes do disco ou gerar PDFs dinamicamente consome recursos. Sempre use `.deliver_later` para que o processamento ocorra em um worker em background.
3. **MIME Types:** O Rails tenta detectar o tipo do arquivo automaticamente pela extensão, mas é boa prática declarar o `mime_type` explicitamente para extensões menos comuns.
4. **Segurança:** Nunca anexe arquivos baseados em caminhos fornecidos diretamente pelo usuário para evitar vulnerabilidades de travessia de diretório (Directory Traversal).
