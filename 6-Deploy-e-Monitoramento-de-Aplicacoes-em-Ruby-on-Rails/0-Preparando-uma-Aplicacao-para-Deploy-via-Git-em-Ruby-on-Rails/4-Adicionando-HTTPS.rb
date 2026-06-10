# Adicionando HTTPS em Aplicações Ruby on Rails

O HTTPS (HyperText Transfer Protocol Secure) é essencial para proteger a integridade e a privacidade dos dados transmitidos entre o navegador do usuário e o servidor. Ele utiliza o protocolo SSL/TLS para criptografar a comunicação.

## 1. Configurando o Rails para Forçar HTTPS

O primeiro passo é garantir que sua aplicação Rails redirecione automaticamente todas as requisições HTTP para HTTPS e marque os cookies como seguros.

No arquivo `config/environments/production.rb`, descomente ou adicione a seguinte linha:

```ruby
# config/environments/production.rb
Rails.application.configure do
  # Força todo o tráfego a usar SSL, redireciona HTTP para HTTPS e 
  # garante que cookies de sessão sejam enviados apenas por conexões seguras.
  config.force_ssl = true
end
```

## 2. Obtendo um Certificado SSL Gratuito com Let's Encrypt (VPS)

Se você estiver usando um servidor próprio (como DigitalOcean, AWS ou Linode) com Nginx ou Apache, o **Certbot** é a ferramenta padrão para obter certificados gratuitos.

### Instalação e Execução (Exemplo com Nginx no Ubuntu):
```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx

# Executar o Certbot para configurar o SSL automaticamente no Nginx
sudo certbot --nginx -d meusite.com.br -d www.meusite.com.br
```
O Certbot cuidará da validação, download do certificado e configuração do servidor web.

## 3. HTTPS no Heroku (ACM)

O Heroku oferece o **ACM (Automatic Certificate Management)**, que gerencia automaticamente os certificados SSL para domínios configurados.

### Como Ativar:
```bash
# O ACM está disponível para todos os apps em dynos pagos (Basic, Standard, Performance)
heroku certs:auto:enable
```
Para verificar o status:
```bash
heroku certs:auto
```

## 4. Usando Cloudflare para SSL Flexível ou Completo

Se você usa o Cloudflare como seu provedor de DNS, pode ativar o SSL sem configurar certificados no seu servidor (embora o modo "Full/Strict" seja o mais recomendado por segurança).

- **Flexible SSL**: Criptografia entre o usuário e o Cloudflare. O Cloudflare fala com seu servidor via HTTP.
- **Full/Strict SSL**: Criptografia em todo o caminho. Exige um certificado (mesmo que autoassinado) no seu servidor original.

## 5. HTTP Strict Transport Security (HSTS)

Quando você ativa `config.force_ssl = true`, o Rails também envia o cabeçalho HSTS. Isso instrui o navegador a **nunca** tentar acessar o site via HTTP novamente por um determinado período.

### Exemplo de Configuração Personalizada:
```ruby
config.ssl_options = { hsts: { expires: 1.year, subdomains: true } }
```

## 6. Verificando se o SSL está Correto

Após a configuração, você pode testar a segurança do seu site usando ferramentas online:
1. **SSL Labs (Qualys)**: https://www.ssllabs.com/ssltest/
2. **Observatory (Mozilla)**: https://observatory.mozilla.org/

## 7. Resumo
1. **Ative `config.force_ssl = true`** no ambiente de produção do Rails.
2. **Obtenha um certificado** via Certbot (VPS), Heroku ACM ou Cloudflare.
3. **Redirecione o tráfego** no nível do servidor web (Nginx/Apache) se o Rails não for o único ponto de entrada.
4. **Renove automaticamente**: Certificados Let's Encrypt expiram a cada 90 dias; certifique-se de que o cronjob do Certbot está ativo.
