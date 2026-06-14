# Configurando ProxyPass no Apache2 para Rails

# O Apache2 pode atuar como um Proxy Reverso, recebendo requisições na porta 80/443
# e encaminhando-as para o servidor da aplicação Rails (que pode estar no Docker).

# 1. Habilitar Módulos Necessários
# Antes de configurar, é preciso habilitar os módulos de proxy no Apache:
# $ sudo a2enmod proxy
# $ sudo a2enmod proxy_http
# $ sudo systemctl restart apache2

# 2. Exemplo de Configuração de VirtualHost
# Geralmente o arquivo fica em /etc/apache2/sites-available/meu_site.conf

# --- EXEMPLO DE CONFIGURAÇÃO APACHE ---
# <VirtualHost *:80>
#     ServerName www.meusite.com.br
#
#     # ProxyPass: Encaminha requisições da raiz (/) para o endereço interno
#     # ProxyPassReverse: Ajusta os cabeçalhos das respostas para que o proxy seja transparente
#
#     ProxyPreserveHost On
#
#     ProxyPass / http://localhost:3000/
#     ProxyPassReverse / http://localhost:3000/
#
#     # Logs de Erro e Acesso
#     ErrorLog ${APACHE_LOG_DIR}/meu_site_error.log
#     CustomLog ${APACHE_LOG_DIR}/meu_site_access.log combined
# </VirtualHost>
# --- FIM DO EXEMPLO ---

# 3. Explicação dos Parâmetros
# - ProxyPreserveHost On: Mantém o cabeçalho 'Host' original da requisição. 
#   Isso é importante para que o Rails saiba qual domínio está sendo acessado.
#
# - ProxyPass: Define o mapeamento da URL pública para a URL interna (ex: porta 3000 do Docker).
#
# - ProxyPassReverse: Garante que o Apache reescreva os cabeçalhos de redirecionamento 
#   enviados pelo Rails para que o cliente não veja o endereço interno (localhost:3000).

# 4. Configurando HTTPS (SSL)
# Quando usamos SSL, o Apache faz o "SSL Termination" e encaminha HTTP puro para o contêiner.

# --- EXEMPLO COM SSL (RESUMIDO) ---
# <VirtualHost *:443>
#     ServerName www.meusite.com.br
#
#     SSLEngine on
#     SSLCertificateFile /caminho/para/cert.pem
#     SSLCertificateKeyFile /caminho/para/key.pem
#
#     ProxyPass / http://localhost:3000/
#     ProxyPassReverse / http://localhost:3000/
#
#     # Informa ao Rails que a conexão original foi via HTTPS
#     RequestHeader set X-Forwarded-Proto "https"
# </VirtualHost>
# --- FIM DO EXEMPLO ---

# 5. Ativando o site
# $ sudo a2ensite meu_site.conf
# $ sudo systemctl reload apache2
