# Configurando App Rails com Docker Compose

# O Docker Compose é uma ferramenta para definir e rodar aplicações multi-contêiner.
# Com ele, usamos um arquivo YAML para configurar os serviços da aplicação.

# 1. Estrutura do docker-compose.yml
# O arquivo geralmente fica na raiz do projeto.

# --- EXEMPLO DE docker-compose.yml COMPLETO ---
# version: '3.8' # Versão da especificação do Compose
#
# services:
#   # Serviço do Banco de Dados
#   db:
#     image: postgres:15-alpine
#     volumes:
#       - postgres_data:/var/lib/postgresql/data # Persistência de dados
#     environment:
#       POSTGRES_USER: postgres
#       POSTGRES_PASSWORD: password
#     healthcheck: # Garante que o banco esteja pronto antes da app
#       test: ["CMD-SHELL", "pg_isready -U postgres"]
#       interval: 5s
#       timeout: 5s
#       retries: 5
#
#   # Serviço Redis (opcional, para Cache/Sidekiq)
#   redis:
#     image: redis:7-alpine
#     volumes:
#       - redis_data:/data
#
#   # Serviço da Aplicação Rails
#   web:
#     build: . # Constrói a imagem a partir do Dockerfile local
#     command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
#     volumes:
#       - .:/myapp # Sincroniza o código local com o contêiner
#     ports:
#       - "3000:3000" # Mapeia porta local:contêiner
#     depends_on:
#       db:
#         condition: service_healthy # Espera o banco passar no healthcheck
#       redis:
#         condition: service_started
#     environment:
#       DATABASE_URL: postgresql://postgres:password@db:5432/myapp_development
#       REDIS_URL: redis://redis:6379/1
#       RAILS_ENV: development
#
# # Definição de volumes nomeados para persistência
# volumes:
#   postgres_data:
#   redis_data:
# --- FIM DO EXEMPLO ---

# 2. Conceitos Importantes
# - services: Define os contêineres que compõem sua stack.
# - build: Indica o caminho para o Dockerfile (normalmente '.' para o diretório atual).
# - volumes: Mapeia pastas locais para dentro do contêiner. Essencial para desenvolvimento (hot reload).
# - ports: Expõe portas do contêiner para a máquina host.
# - depends_on: Define a ordem de inicialização. No exemplo, 'web' espera 'db' e 'redis'.

# 3. Gerenciamento com Docker Compose
# - Iniciar todos os serviços em segundo plano:
#   $ docker-compose up -d
#
# - Ver logs dos serviços:
#   $ docker-compose logs -f
#
# - Parar e remover contêineres:
#   $ docker-compose down
#
# - Executar um comando dentro do contêiner rodando (ex: console):
#   $ docker-compose exec web rails console
#
# - Rodar um comando pontual (ex: migrations):
#   $ docker-compose run --rm web rails db:migrate

# 4. Benefícios do Docker Compose no Rails
# - Ambiente Idêntico: Todos os desenvolvedores usam a mesma versão de Ruby, PG, Redis, etc.
# - Isolamento: Não polui sua máquina local com instalações de bancos de dados.
# - Facilidade de Setup: Um novo dev no projeto só precisa de 'docker-compose up' para começar.
