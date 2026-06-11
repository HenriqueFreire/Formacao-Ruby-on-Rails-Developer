# Guia de Configuração de HTTPS (SSL/TLS) em Produção

# O HTTPS é obrigatório para qualquer aplicação web moderna. Ele garante que os dados 
# trocados entre o navegador do usuário e o seu servidor sejam criptografados e seguros.

# ==========================================
# 1. O que é o Let's Encrypt?
# ==========================================
# É uma autoridade de certificação gratuita, automatizada e aberta. 
# Ela fornece certificados SSL/TLS que são reconhecidos por todos os navegadores.

# ==========================================
# 2. Instalando o Certbot (Ubuntu + Nginx)
# ==========================================
# O Certbot é a ferramenta oficial para obter e renovar certificados do Let's Encrypt.

# sudo apt update
# sudo apt install certbot python3-certbot-nginx

# ==========================================
# 3. Obtendo o Certificado
# ==========================================
# O Certbot analisará sua configuração do Nginx e solicitará o certificado automaticamente.
# Importante: O DNS (Registro A) já deve estar apontando para o servidor.

# sudo certbot --nginx -d meu-dominio.com -d www.meu-dominio.com

# Durante o processo, ele perguntará se você deseja redirecionar todo o tráfego HTTP para HTTPS. 
# Recomenda-se escolher a opção de REDIRECT.

# ==========================================
# 4. Configuração no Rails (force_ssl)
# ==========================================
# Para garantir que o Rails trate corretamente os cookies de sessão e os cabeçalhos 
# de segurança (HSTS), ative a opção force_ssl no ambiente de produção.

# No arquivo: config/environments/production.rb
# config.force_ssl = true

# Isso fará com que o Rails:
# - Redirecione HTTP para HTTPS.
# - Defina a flag "Secure" em todos os cookies.
# - Ative o cabeçalho HSTS (HTTP Strict Transport Security).

# ==========================================
# 5. Renovação Automática
# ==========================================
# Os certificados do Let's Encrypt duram 90 dias. O Certbot instala um cronjob ou 
# timer do systemd que tenta renovar o certificado automaticamente antes de expirar.

# Para testar a renovação:
# sudo certbot renew --dry-run

# ==========================================
# 6. Como fica o Nginx após o Certbot?
# ==========================================
# O Certbot adicionará linhas como estas ao seu arquivo em /etc/nginx/sites-available/:
#
# listen 443 ssl; # managed by Certbot
# ssl_certificate /etc/letsencrypt/live/meu-dominio.com/fullchain.pem; # managed by Certbot
# ssl_certificate_key /etc/letsencrypt/live/meu-dominio.com/privkey.pem; # managed by Certbot
# include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
# ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

# ==========================================
# 7. Verificando a Segurança
# ==========================================
# Após a configuração, você pode testar a qualidade do seu SSL em:
# https://www.ssllabs.com/ssltest/
