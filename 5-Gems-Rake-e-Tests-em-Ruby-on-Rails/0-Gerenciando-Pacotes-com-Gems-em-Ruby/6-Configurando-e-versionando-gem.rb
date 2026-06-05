# Configurando e Versionando sua Gem

# Este arquivo explica como configurar corretamente os metadados da sua Gem
# e como gerenciar as versões seguindo as melhores práticas da comunidade.

# =============================================================================
# 1. O ARQUIVO .GEMSPEC (Coração da Configuração)
# =============================================================================
# O arquivo .gemspec define o que a sua gem é, quem a fez e do que ela precisa.

# Exemplo detalhado de um arquivo minha_gem.gemspec:
#
# lib = File.expand_path("../lib", __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require "minha_gem/version"
#
# Gem::Specification.new do |spec|
#   spec.name          = "minha_gem"
#   spec.version       = MinhaGem::VERSION  # Puxa a versão de um arquivo separado
#   spec.authors       = ["Seu Nome"]
#   spec.email         = ["seuemail@exemplo.com"]
#
#   spec.summary       = "Resumo curto da Gem."
#   spec.description   = "Descrição longa e detalhada sobre o que a Gem faz."
#   spec.homepage      = "https://github.com/usuario/minha_gem"
#   spec.license       = "MIT"
#
#   # Define quais arquivos serão incluídos no pacote final
#   spec.files         = Dir["lib/**/*.rb", "README.md", "LICENSE.txt"]
#   spec.bindir        = "exe"
#   spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
#   spec.require_paths = ["lib"]
#
#   # Dependências de execução (necessárias para a Gem funcionar)
#   spec.add_dependency "httparty", "~> 0.18"
#
#   # Dependências de desenvolvimento (apenas para quem vai contribuir)
#   spec.add_development_dependency "bundler", "~> 2.0"
#   spec.add_development_dependency "rake", "~> 13.0"
#   spec.add_development_dependency "rspec", "~> 3.0"
# end

# =============================================================================
# 2. VERSIONAMENTO SEMÂNTICO (SemVer)
# =============================================================================
# A comunidade Ruby segue o padrão MAJOR.MINOR.PATCH (ex: 1.4.2)
#
# 1. MAJOR (1.0.0): Mudanças incompatíveis (quebra de API).
# 2. MINOR (0.1.0): Novas funcionalidades que não quebram o código existente.
# 3. PATCH (0.0.1): Correções de bugs (bugfixes) que não alteram a API.

# Dica: Mantenha a versão em um arquivo separado: lib/minha_gem/version.rb
# module MinhaGem
#   VERSION = "0.1.0"
# end

# =============================================================================
# 3. GERENCIANDO VERSÕES COM GIT
# =============================================================================
# É uma boa prática usar Tags do Git para marcar as versões da sua Gem:
#
# $ git add .
# $ git commit -m "Lançamento da versão 0.1.0"
# $ git tag -a v0.1.0 -m "Versão 0.1.0"
# $ git push origin main --tags

# =============================================================================
# 4. REQUISITOS DE SEGURANÇA
# =============================================================================
# Nunca coloque chaves de API ou senhas no .gemspec ou no código da Gem.
# Use arquivos .env ou configurações dinâmicas para isso.

puts "Guia de configuração e versionamento de Gems carregado!"
