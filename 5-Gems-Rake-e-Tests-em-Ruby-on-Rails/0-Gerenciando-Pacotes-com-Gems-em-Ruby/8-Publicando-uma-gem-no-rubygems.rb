# Publicando uma Gem no RubyGems.org

# Este arquivo detalha o processo final de compartilhar sua biblioteca com a
# comunidade global através do repositório oficial de Gems do Ruby.

# =============================================================================
# 1. PREPARAÇÃO DA CONTA
# =============================================================================
# Antes de publicar, você precisa de uma conta no site https://rubygems.org
#
# Após criar a conta, você deve autenticar seu terminal:
# $ gem signin
#
# (Isso solicitará seu e-mail e senha do RubyGems.org e salvará uma chave de API
# localmente em ~/.gem/credentials)

# =============================================================================
# 2. CONFERÊNCIA FINAL DO .GEMSPEC
# =============================================================================
# Certifique-se de que os seguintes campos não são os padrões do Bundler:
# - spec.summary
# - spec.description
# - spec.homepage
#
# Se houver placeholders como "TODO", a publicação falhará.

# =============================================================================
# 3. COMPILANDO A GEM (BUILD)
# =============================================================================
# Gere o arquivo .gem (o pacote compactado):
#
# $ gem build minha_gem.gemspec
#
# Saída esperada: "Successfully built RubyGem" e a criação de 'minha_gem-0.1.0.gem'.

# =============================================================================
# 4. PUBLICANDO (PUSH)
# =============================================================================
# Envie o pacote para o servidor:
#
# $ gem push minha_gem-0.1.0.gem
#
# Saída esperada: "Successfully registered gem: minha_gem (0.1.0)"

# =============================================================================
# 5. GERENCIANDO PROPRIETÁRIOS (OWNERS)
# =============================================================================
# Se você trabalha em equipe, pode adicionar outros usuários como donos:
#
# $ gem owner minha_gem --add colega@email.com

# =============================================================================
# 6. SEGURANÇA (MFA/2FA)
# =============================================================================
# É altamente recomendado ativar a Autenticação de Dois Fatores (MFA) no RubyGems.
# Ao publicar com MFA ativo, o terminal solicitará um código OTP:
#
# $ gem push minha_gem-0.1.0.gem
# Enter OTP code: 123456

# =============================================================================
# 7. REMOVENDO UMA VERSÃO (YANK)
# =============================================================================
# Se você publicou algo com um bug crítico, pode remover a versão (YANK):
#
# $ gem yank minha_gem -v 0.1.0
#
# Nota: Isso não remove a gem permanentemente, apenas impede que novos usuários
# a instalem via 'gem install' ou 'bundle install'.

puts "Guia de publicação no RubyGems carregado!"
