# Configuração de Servidor para App Rails com Docker

# O Docker permite empacotar uma aplicação Rails com todas as suas dependências 
# (Ruby, bibliotecas do sistema, banco de dados) em um contêiner isolado.

# 1. Dockerfile
# O Dockerfile define a imagem da nossa aplicação. 
# Exemplo de um Dockerfile para Rails 7:

# --- EXEMPLO DE DOCKERFILE ---
# FROM ruby:3.2.2
# 
# # Instala dependências do sistema
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# 
# # Define o diretório de trabalho
# WORKDIR /myapp
# 
# # Copia o Gemfile e instala as gems
# COPY Gemfile /myapp/Gemfile
# COPY Gemfile.lock /myapp/Gemfile.lock
# RUN bundle install
# 
# # Copia o restante do código
# COPY . /myapp
# 
# # Script de entrada para corrigir problemas de PID do servidor
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000
# 
# # Inicia o servidor principal
# CMD ["rails", "server", "-b", "0.0.0.0"]
# --- FIM DO EXEMPLO ---

# 2. Docker Compose
# O Docker Compose é usado para rodar múltiplos contêineres (Ex: App + PostgreSQL).

# --- EXEMPLO DE docker-compose.yml ---
# version: '3'
# services:
#   db:
#     image: postgres
#     volumes:
#       - ./tmp/db:/var/lib/postgresql/data
#     environment:
#       POSTGRES_PASSWORD: password
#   web:
#     build: .
#     command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
#     volumes:
#       - .:/myapp
#     ports:
#       - "3000:3000"
#     depends_on:
#       - db
#     environment:
#       DATABASE_URL: postgresql://postgres:password@db:5432/myapp_development
# --- FIM DO EXEMPLO ---

# 3. Comandos Úteis
# Para construir a imagem:
# $ docker-compose build

# Para subir os serviços:
# $ docker-compose up

# Para rodar migrações:
# $ docker-compose run web rake db:create db:migrate

# 4. Configuração do Banco de Dados (config/database.yml)
# No Docker, o host do banco de dados é o nome do serviço definido no docker-compose.yml (no caso, 'db').

# --- EXEMPLO database.yml ---
# default: &default
#   adapter: postgresql
#   encoding: unicode
#   host: db
#   username: postgres
#   password: password
#   pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
# 
# development:
#   <<: *default
#   database: myapp_development
# --- FIM DO EXEMPLO ---
