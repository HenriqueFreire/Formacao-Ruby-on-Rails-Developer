# Criação de um Novo Projeto em Rails 7
#
# Criar um projeto em Rails 7 é um processo simples, mas o framework oferece 
# diversas opções para customizar sua aplicação desde o primeiro comando.

# --- 1. O Comando Básico ---
# Para criar uma aplicação padrão (usando SQLite e Import Maps):
#
# $ rails new meu_projeto


# --- 2. Opções Comuns de Customização ---
#
# A) Definindo o Banco de Dados:
# O Rails usa SQLite por padrão, mas você pode escolher PostgreSQL, MySQL, etc.
# $ rails new meu_projeto --database=postgresql
#
# B) Escolhendo o Framework de CSS:
# O Rails 7 facilita a integração com CSS moderno.
# $ rails new meu_projeto --css=tailwind
# $ rails new meu_projeto --css=bootstrap
#
# C) Criando uma API (Sem Views):
# Ideal para backends que serão consumidos por apps Mobile ou React/Vue/Angular.
# $ rails new minha_api --api


# --- 3. A Estrutura de Diretórios Gerada ---
#
# Após rodar o comando, o Rails cria uma estrutura organizada:
#
# /app          -> Onde vive o código da sua aplicação (Models, Views, Controllers).
# /bin          -> Scripts auxiliares do Rails.
# /config       -> Configurações de rotas, banco de dados e ambiente.
# /db           -> Esquema do banco de dados e migrações.
# /public       -> Arquivos estáticos (imagens, páginas de erro 404).
# /test         -> Seus testes automatizados.
# Gemfile       -> Lista de dependências (Gems) do projeto.


# --- 4. Primeiros Passos após a Criação ---
#
# 1. Entre na pasta do projeto:
#    $ cd meu_projeto
#
# 2. Crie o banco de dados inicial:
#    $ rails db:create
#
# 3. Inicie o servidor:
#    $ rails server  (ou apenas 'rails s')
#
# Agora, ao acessar http://localhost:3000, você verá a página "Yay! You’re on Rails!".


# --- 5. Exemplo Completo de Criação ---
# Criando um blog com PostgreSQL e Tailwind CSS:
#
# $ rails new blog_moderno -d postgresql -c tailwind
