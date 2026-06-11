# Guia de Configuração do Nginx para Ruby on Rails

# O Nginx atua como um servidor web de alta performance que recebe as requisições 
# HTTP/HTTPS e as encaminha para o servidor de aplicação (Puma), funcionando como um Reverse Proxy.

# ==========================================
# 1. Instalação (Ubuntu)
# ==========================================
# sudo apt update
# sudo apt install nginx

# ==========================================
# 2. Estrutura de Diretórios do Nginx
# ==========================================
# /etc/nginx/nginx.conf          -> Configuração principal.
# /etc/nginx/sites-available/    -> Onde você cria as configurações dos sites.
# /etc/nginx/sites-enabled/      -> Links simbólicos para ativar os sites.

# ==========================================
# 3. Exemplo de Configuração para Rails (Puma via Socket)
# ==========================================
# Crie o arquivo: sudo nano /etc/nginx/sites-available/meu_app

# upstream app {
#   # Caminho para o socket do Puma definido no arquivo config/puma.rb do seu projeto
#   server unix:///home/deploy/meu_app/shared/tmp/sockets/meu_app-puma.sock fail_timeout=0;
# }
#
# server {
#   listen 80;
#   server_name meu-dominio.com; # Ou o IP do servidor
#
#   # Raiz da aplicação (pasta public)
#   root /home/deploy/meu_app/current/public;
#
#   try_files $uri/index.html $uri @app;
#
#   location @app {
#     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#     proxy_set_header Host $http_host;
#     proxy_set_header X-Forwarded-Proto $scheme;
#     proxy_redirect off;
#     proxy_pass http://app;
#   }
#
#   # Configurações de Cache para Assets estáticos
#   location ~ ^/(assets|packs)/ {
#     gzip_static on;
#     expires max;
#     add_header Cache-Control public;
#   }
#
#   error_page 500 502 503 504 /500.html;
#   client_max_body_size 10M;
#   keepalive_timeout 10;
# }

# ==========================================
# 4. Ativando a Configuração
# ==========================================
# Remova a configuração padrão se necessário:
# sudo rm /etc/nginx/sites-enabled/default

# Crie o link simbólico:
# sudo ln -s /etc/nginx/sites-available/meu_app /etc/nginx/sites-enabled/meu_app

# Teste a sintaxe:
# sudo nginx -t

# Reinicie o Nginx:
# sudo systemctl restart nginx

# ==========================================
# 5. Configuração de Logs
# ==========================================
# Os logs do Nginx são fundamentais para depuração de erros 502/504.
# Acessos: /var/log/nginx/access.log
# Erros:   /var/log/nginx/error.log

# ==========================================
# 6. HTTPS com Let's Encrypt (Certbot)
# ==========================================
# O Certbot altera automaticamente o seu arquivo do Nginx para suportar SSL.
# sudo apt install certbot python3-certbot-nginx
# sudo certbot --nginx -d meu-dominio.com
