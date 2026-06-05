# Instalando e Utilizando uma Gem em uma Aplicação

# Este arquivo explica como integrar uma Gem (seja ela pública ou local) 
# em um projeto Ruby ou Ruby on Rails.

# =============================================================================
# 1. ADICIONANDO AO GEMFILE
# =============================================================================
# O Gemfile é onde você declara todas as dependências do seu projeto.

# --- Exemplo de Gem do RubyGems.org (Pública) ---
# gem 'httparty'
# gem 'devise', '~> 4.8'

# --- Exemplo de Gem Local (Desenvolvimento) ---
# Se você está criando sua própria gem e quer testá-la em outro projeto:
# gem 'minha_gem_util', path: '../caminho/para/minha_gem_util'

# --- Exemplo de Gem via GitHub ---
# gem 'rails', github: 'rails/rails', branch: 'main'

# =============================================================================
# 2. INSTALANDO AS DEPENDÊNCIAS
# =============================================================================
# Após editar o Gemfile, rode o comando no terminal:
#
# $ bundle install
#
# Isso criará ou atualizará o arquivo 'Gemfile.lock', que garante que todos
# os desenvolvedores do projeto usem as mesmas versões das gems.

# =============================================================================
# 3. UTILIZANDO EM UM SCRIPT RUBY PURO
# =============================================================================
# Em scripts fora do Rails, você precisa carregar o bundler e a gem:

require 'bundler/setup' # Configura o load path baseado no Gemfile
require 'minha_gem_util'

# Agora você pode usar as classes da Gem:
# puts MinhaGemUtil::Formatador.cpf("12345678901")

# =============================================================================
# 4. UTILIZANDO NO RUBY ON RAILS
# =============================================================================
# No Rails, as gems listadas no Gemfile são carregadas automaticamente.
# Você pode usá-las diretamente em Models, Controllers ou Helpers.

# Exemplo em um Model:
# class Cliente < ApplicationRecord
#   before_save :formatar_documento
#
#   private
#
#   def formatar_documento
#     # Usando a lógica da nossa gem customizada
#     self.cpf = MinhaGemUtil::Formatador.cpf(self.cpf)
#   end
# end

# =============================================================================
# 5. RESOLUÇÃO de PROBLEMAS
# =============================================================================
# - Erro 'cannot load such file': Verifique se a gem está no Gemfile e se 
#   você rodou 'bundle install'.
# - Conflito de Versão: Tente rodar 'bundle update nome_da_gem' para resolver
#   dependências incompatíveis.
# - Gem Local não atualiza: Se usar 'path:', as mudanças no código da gem são
#   refletidas imediatamente, mas mudanças no .gemspec exigem um novo 'bundle install'.

puts "Guia de instalação e uso de Gems em aplicações carregado!"
