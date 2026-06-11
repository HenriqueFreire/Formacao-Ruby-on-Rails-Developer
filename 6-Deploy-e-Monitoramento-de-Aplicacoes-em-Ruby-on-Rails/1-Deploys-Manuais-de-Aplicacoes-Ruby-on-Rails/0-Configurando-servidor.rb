# Guia de Configuração de Servidor para Ruby on Rails (Deploy Manual)

# Este guia descreve os passos fundamentais para configurar um servidor Linux (Ubuntu) 
# para hospedar uma aplicação Ruby on Rails manualmente.

# ==========================================
# 1. Preparação do Servidor
# ==========================================
# Após acessar o servidor via SSH:
# sudo apt update
# sudo apt upgrade

# Instale dependências essenciais:
# sudo apt install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# ==========================================
# 2. Instalação do Ruby (via rbenv)
# ==========================================
# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# source ~/.bashrc

# rbenv install 3.3.0
# rbenv global 3.3.0
# gem install bundler rails

# ==========================================
# 3. Banco de Dados (PostgreSQL)
# ==========================================
# sudo apt install postgresql postgresql-contrib libpq-dev
# sudo -u postgres createuser -s seu_usuario
# sudo -u postgres psql -c "ALTER USER seu_usuario WITH PASSWORD 'sua_senha';"

# ==========================================
# 4. Servidor Web (Nginx)
# ==========================================
# sudo apt install nginx

# Exemplo de configuração do Nginx (/etc/nginx/sites-available/meu_app):
#
# upstream app {
#   server unix:///home/deploy/meu_app/shared/tmp/sockets/meu_app-puma.sock;
# }
#
# server {
#   listen 80;
#   server_name meu-dominio.com;
#   root /home/deploy/meu_app/current/public;
#
#   location / {
#     try_files $uri @app;
#   }
#
#   location @app {
#     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#     proxy_set_header Host $http_host;
#     proxy_redirect off;
#     proxy_pass http://app;
#   }
# }

# ==========================================
# 5. Servidor de Aplicação (Puma)
# ==========================================
# O Puma geralmente é iniciado via Systemd. 
# Exemplo de arquivo de serviço (/etc/systemd/system/meu_app_puma.service):
#
# [Unit]
# Description=Puma HTTP Server
# After=network.target
#
# [Service]
# Type=simple
# User=deploy
# WorkingDirectory=/home/deploy/meu_app/current
# ExecStart=/home/deploy/.rbenv/bin/rbenv exec bundle exec puma -C /home/deploy/meu_app/shared/config/puma.rb
# Restart=always
#
# [Install]
# WantedBy=multi-user.target

# ==========================================
# 6. Segurança e SSL (Let's Encrypt)
# ==========================================
# sudo apt install certbot python3-certbot-nginx
# sudo certbot --nginx -d meu-dominio.com
