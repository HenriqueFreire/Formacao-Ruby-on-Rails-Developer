# Configuração de um Projeto Rails com Banco de Dados

A configuração do banco de dados no Ruby on Rails é centralizada no arquivo `config/database.yml`. O Rails suporta diversos bancos de dados como SQLite (padrão), MySQL e PostgreSQL.

## 1. Criando um projeto com um banco específico
Ao criar um novo projeto, você pode especificar qual banco de dados deseja usar com a flag `-d` ou `--database`.

**Exemplos:**
```bash
# Para MySQL
rails new meu_projeto -d mysql

# Para PostgreSQL
rails new meu_projeto -d postgresql

# Para SQLite (padrão, não precisa da flag)
rails new meu_projeto
```

## 2. O arquivo config/database.yml
Este arquivo define as configurações para os diferentes ambientes (development, test, production).

**Exemplo de configuração para PostgreSQL:**
```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: meu_usuario
  password: minha_password
  host: localhost

development:
  <<: *default
  database: meu_projeto_development

test:
  <<: *default
  database: meu_projeto_test

production:
  <<: *default
  database: meu_projeto_production
  username: <%= ENV['DATABASE_USERNAME'] %>
  password: <%= ENV['DATABASE_PASSWORD'] %>
```

## 3. Comandos Essenciais do Rails para Banco de Dados

Uma vez configurado o banco no `database.yml`, utilizamos comandos `bin/rails db:...` para gerenciá-lo.

**Exemplos:**
```bash
# Cria o banco de dados definido no database.yml
bin/rails db:create

# Executa as migrações (cria ou altera tabelas)
bin/rails db:migrate

# Apaga o banco de dados
bin/rails db:drop

# Popula o banco com dados iniciais (definidos em db/seeds.rb)
bin/rails db:seed

# Atalho para apagar, criar, migrar e popular o banco (cuidado!)
bin/rails db:setup
```

## 4. Variáveis de Ambiente
Para segurança, nunca coloque senhas diretamente no `database.yml` em produção. Utilize variáveis de ambiente ou o sistema de `credentials` do Rails.

```yaml
production:
  <<: *default
  database: meu_projeto_production
  password: <%= Rails.application.credentials.dig(:db_password) %>
```
