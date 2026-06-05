# Módulo: Gems, Rake e Tests em Ruby on Rails

# Este módulo introduz as ferramentas essenciais para a gestão, automação e 
# garantia de qualidade em aplicações Ruby on Rails.

# =============================================================================
# 1. GEMS (Gerenciamento de Pacotes)
# =============================================================================
# Gems são bibliotecas que estendem as funcionalidades do Ruby.
# O Bundler gerencia essas dependências através do arquivo 'Gemfile'.

# Exemplo de comando para instalar uma gem:
# $ gem install httparty

# Exemplo de Gemfile:
# source 'https://rubygems.org'
# gem 'rails', '~> 7.0'
# gem 'pg'          # PostgreSQL
# gem 'devise'      # Autenticação

# Para instalar todas as dependências do projeto:
# $ bundle install


# =============================================================================
# 2. RAKE (Ruby Make)
# =============================================================================
# O Rake é um executor de tarefas (Task Runner) usado para automatizar processos.
# No Rails moderno, muitos comandos 'rake' foram incorporados ao comando 'rails'.

# Comandos comuns:
# $ rails db:migrate    # Executa migrações do banco de dados
# $ rails db:seed       # Alimenta o banco com dados iniciais
# $ rails routes        # Lista todas as rotas da aplicação

# Exemplo de criação de uma Task customizada (em lib/tasks/exemplo.rake):
# namespace :setup do
#   desc "Exemplo de tarefa customizada"
#   task :boas_vindas => :environment do
#     puts "Iniciando configuração do ambiente..."
#     # Lógica da tarefa aqui
#   end
# end


# =============================================================================
# 3. TESTES (Garantia de Qualidade)
# =============================================================================
# Testes automatizados garantem que alterações futuras não quebrem funcionalidades existentes.
# O Rails suporta Minitest (padrão) e RSpec (comunidade).

# Exemplo conceitual de teste com RSpec:
# RSpec.describe User, type: :model do
#   it "não deve ser válido sem email" do
#     user = User.new(email: nil)
#     expect(user).to_not be_valid
#   end
# end

# Para rodar os testes:
# $ rails test        # Minitest
# $ bundle exec rspec # RSpec

puts "Conteúdo de Introdução ao Módulo carregado com sucesso!"

