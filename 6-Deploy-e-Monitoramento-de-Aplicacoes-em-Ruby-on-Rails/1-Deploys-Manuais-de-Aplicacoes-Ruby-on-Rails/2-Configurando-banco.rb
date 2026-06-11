# Guia de Configuração de Banco de Dados no Servidor (PostgreSQL)

# O PostgreSQL é o banco de dados mais recomendado para aplicações Ruby on Rails 
# devido à sua robustez, performance e compatibilidade com recursos avançados do ActiveRecord.

# ==========================================
# 1. Instalação do PostgreSQL (Ubuntu)
# ==========================================
# sudo apt update
# sudo apt install postgresql postgresql-contrib libpq-dev

# 'libpq-dev' é essencial para que a gem 'pg' possa ser compilada no servidor.

# ==========================================
# 2. Criação de Usuário e Banco de Dados
# ==========================================
# O ideal é criar um usuário exclusivo para a aplicação, sem privilégios de superusuário.

# Passo 1: Acesse o console do Postgres
# sudo -u postgres psql

# Passo 2: Comandos SQL no console (psql):
# CREATE USER meu_usuario WITH PASSWORD 'uma_senha_muito_forte';
# CREATE DATABASE meu_app_production OWNER meu_usuario;
# \q (para sair)

# ==========================================
# 3. Configuração do database.yml (No App)
# ==========================================
# Em produção, nunca escreva a senha diretamente no arquivo. Use variáveis de ambiente.

# Exemplo de config/database.yml:
#
# production:
#   adapter: postgresql
#   encoding: unicode
#   pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
#   database: <%= ENV['DATABASE_NAME'] %>
#   username: <%= ENV['DATABASE_USER'] %>
#   password: <%= ENV['DATABASE_PASSWORD'] %>
#   host: <%= ENV['DATABASE_HOST'] || 'localhost' %>

# ==========================================
# 4. Ajustes de Segurança (pg_hba.conf)
# ==========================================
# Por padrão, o Postgres permite conexões locais via "peer" (usuário do sistema).
# Para usar senha, você pode precisar alterar o método para "md5" ou "scram-sha-256".

# Localização comum: /etc/postgresql/16/main/pg_hba.conf
# Alterar:
# local   all             all                                     peer
# Para:
# local   all             all                                     md5

# Após alterar, reinicie o serviço:
# sudo systemctl restart postgresql

# ==========================================
# 5. Backup Automático (Dica)
# ==========================================
# Use o utilitário 'pg_dump' para criar backups.
# Exemplo de comando:
# pg_dump -U meu_usuario meu_app_production > backup_data.sql

# ==========================================
# 6. Comandos Rails Úteis no Servidor
# ==========================================
# RAILS_ENV=production bundle exec rails db:create
# RAILS_ENV=production bundle exec rails db:migrate
# RAILS_ENV=production bundle exec rails db:seed
