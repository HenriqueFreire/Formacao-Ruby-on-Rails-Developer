# Configurando HTTPS no Apache2 para Rails

# Segurança é fundamental. O HTTPS criptografa o tráfego entre o cliente e o servidor.
# No Apache2, isso envolve o uso do módulo 'ssl' e a configuração de certificados.

# 1. Habilitar Módulo SSL
# Primeiro, ative o suporte a SSL no Apache:
# $ sudo a2enmod ssl
# $ sudo systemctl restart apache2

# 2. Obtendo Certificados (Let's Encrypt)
# A forma mais comum e gratuita é usando o Certbot:
# $ sudo apt install certbot python3-certbot-apache
# $ sudo certbot --apache -d meusite.com.br

# 3. Configuração Manual do VirtualHost SSL
# Se você tiver os arquivos do certificado (.crt e .key), a configuração fica assim:

# --- EXEMPLO DE CONFIGURAÇÃO HTTPS ---
# <VirtualHost *:443>
#     ServerName www.meusite.com.br
#
#     SSLEngine on
#     SSLCertificateFile /etc/ssl/certs/meusite.crt
#     SSLCertificateKeyFile /etc/ssl/private/meusite.key
#
#     # Proxy para o Rails (Docker)
#     ProxyPreserveHost On
#     ProxyPass / http://localhost:3000/
#     ProxyPassReverse / http://localhost:3000/
#
#     # Cabeçalhos de Segurança (Opcional mas recomendado)
#     Header always set Strict-Transport-Security "max-age=63072000; includeSubDomains"
# </VirtualHost>
# --- FIM DO EXEMPLO ---

# 4. Redirecionamento Automático de HTTP para HTTPS
# É uma boa prática forçar todo o tráfego para HTTPS.

# --- EXEMPLO DE REDIRECIONAMENTO ---
# <VirtualHost *:80>
#     ServerName www.meusite.com.br
#     Redirect permanent / https://www.meusite.com.br/
# </VirtualHost>
# --- FIM DO EXEMPLO ---

# 5. Configuração no Rails (Importante!)
# Para que o Rails saiba que está sob HTTPS e gere URLs corretas, 
# adicione/verifique no seu 'config/environments/production.rb':

# config.force_ssl = true

# Isso fará com que:
# - Cookies sejam marcados como 'secure'.
# - O Rails use o cabeçalho 'HSTS'.
# - Redirecionamentos internos mantenham o protocolo HTTPS.

# 6. Testando a Configuração
# Sempre verifique se a sintaxe do Apache está correta antes de reiniciar:
# $ sudo apache2ctl configtest
# $ sudo systemctl reload apache2
