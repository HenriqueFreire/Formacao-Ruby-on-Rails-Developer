# Criando uma Gem em Ruby

# Este arquivo detalha o processo de criação de um pacote (Gem) reutilizável em Ruby.

# =============================================================================
# 1. O QUE É UMA GEM?
# =============================================================================
# Uma Gem é um pacote de código Ruby. Ela segue uma estrutura de diretórios 
# padrão e contém um arquivo .gemspec com metadados.

# =============================================================================
# 2. INICIANDO A ESTRUTURA (VIA BUNDLER)
# =============================================================================
# A melhor forma de criar uma gem é usando o comando:
# $ bundle gem nome_da_minha_gem

# Isso gera a estrutura:
# - lib/                # Código fonte
# - nome_da_gem.gemspec # Configurações da Gem
# - Rakefile            # Tarefas de automação
# - Gemfile             # Dependências de desenvolvimento

# =============================================================================
# 3. CONFIGURANDO O .GEMSPEC
# =============================================================================
# É obrigatório preencher o arquivo .gemspec antes de compilar.
# Exemplo básico:

# Gem::Specification.new do |spec|
#   spec.name          = "minha_calculadora"
#   spec.version       = "0.1.0"
#   spec.authors       = ["Seu Nome"]
#   spec.summary       = "Uma gem de exemplo"
#   spec.files         = Dir["lib/**/*.rb"]
#   spec.require_paths = ["lib"]
# end

# =============================================================================
# 4. IMPLEMENTAÇÃO DO CÓDIGO
# =============================================================================
# O código principal deve residir em lib/nome_da_gem.rb

module MinhaCalculadora
  def self.somar(a, b)
    a + b
  end
end

# =============================================================================
# 5. COMPILAÇÃO E INSTALAÇÃO LOCAL
# =============================================================================
# No terminal, dentro da pasta da gem:

# 1. Compilar a Gem (gera o arquivo .gem):
# $ gem build minha_calculadora.gemspec

# 2. Instalar localmente:
# $ gem install ./minha_calculadora-0.1.0.gem

# 3. Testar no IRB:
# $ irb
# > require 'minha_calculadora'
# > MinhaCalculadora.somar(2, 2) # => 4

# =============================================================================
# 6. PUBLICANDO NO RUBYGEMS
# =============================================================================
# Para disponibilizar para a comunidade:
# $ gem push minha_calculadora-0.1.0.gem

puts "Guia de criação de Gems carregado!"
