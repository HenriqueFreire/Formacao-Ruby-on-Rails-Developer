# Gems, Gemfile e Debugger em Ruby

# --- 1. O que são Gems? ---
# Gems são bibliotecas ou pacotes de terceiros que adicionam funcionalidades ao Ruby.
# Você pode instalá-las via terminal: gem install nome_da_gem

# Exemplo de uso de uma gem instalada (ex: 'faker' para gerar dados falsos):
# require 'faker'
# puts Faker::Name.name

# --- 2. O que é o Gemfile? ---
# É um arquivo usado pelo 'Bundler' para gerenciar as dependências do seu projeto.
# Ele garante que todos os desenvolvedores usem as mesmas versões das gems.

=begin
Exemplo de conteúdo de um arquivo 'Gemfile':

source 'https://rubygems.org'

gem 'rails', '~> 7.0'
gem 'pg'              # Banco de dados PostgreSQL
gem 'pry'             # Ferramenta de debug alternativa
gem 'debug'           # Debugger padrão do Ruby 3.1+
=end

# Comandos principais do Bundler:
# bundle install -> Instala as gems listadas no Gemfile
# bundle update  -> Atualiza as gems para as versões mais recentes permitidas

# --- 3. O que é o Gemfile.lock? ---
# Gerado automaticamente após o 'bundle install'. 
# Ele registra a versão EXATA de cada gem instalada, garantindo consistência.

# --- 4. Debugger (Depurador) ---
# O debugger permite pausar a execução do código para inspecionar variáveis e encontrar erros.
# No Ruby 3.1+, usamos a gem 'debug'.

require 'debug'

def calcular_bonus(salario)
  puts "Iniciando cálculo..."
  
  # A linha abaixo pausa a execução
  # No terminal, você pode digitar os nomes das variáveis para ver seus valores
  # binding.break 
  
  bonus = salario * 0.10
  
  if bonus > 500
    bonus = 500
  end
  
  bonus
end

# Exemplo de uso:
resultado = calcular_bonus(6000)
puts "O bônus é: #{resultado}"

# Comandos comuns no Debugger:
# c (continue) -> Continua a execução até o próximo breakpoint ou fim do script
# n (next)     -> Vai para a próxima linha
# s (step)     -> Entra dentro de um método
# q (quit)     -> Encerra a depuração
