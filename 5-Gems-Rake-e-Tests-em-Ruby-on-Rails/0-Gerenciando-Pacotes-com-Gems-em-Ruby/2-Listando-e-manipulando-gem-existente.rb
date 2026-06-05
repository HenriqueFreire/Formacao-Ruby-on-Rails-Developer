# Listando e Manipulando Gems Existentes

# Este arquivo detalha como gerenciar as bibliotecas (Gems) já instaladas no seu
# ambiente ou disponíveis no repositório remoto.

# =============================================================================
# 1. COMANDOS DE LISTAGEM E BUSCA (Terminal)
# =============================================================================

# Listar todas as gems instaladas localmente:
# $ gem list

# Listar gems instaladas que começam com um nome específico:
# $ gem list rails

# Buscar uma gem no repositório remoto (RubyGems.org):
# $ gem search httparty --remote

# =============================================================================
# 2. INFORMAÇÕES DETALHADAS
# =============================================================================

# Ver detalhes sobre uma gem específica (versão, autor, caminho de instalação):
# $ gem info nome_da_gem

# =============================================================================
# 3. ATUALIZAÇÃO E MANUTENÇÃO
# =============================================================================

# Verificar quais gems estão desatualizadas:
# $ gem outdated

# Atualizar uma gem específica:
# $ gem update nome_da_gem

# Atualizar todas as gems do sistema:
# $ gem update

# Limpar versões antigas das gems instaladas:
# $ gem cleanup

# =============================================================================
# 4. REMOÇÃO (UNINSTALL)
# =============================================================================

# Desinstalar uma gem:
# $ gem uninstall nome_da_gem

# Se houver múltiplas versões, o terminal perguntará qual remover.

# =============================================================================
# 5. MANIPULAÇÃO VIA CÓDIGO RUBY
# =============================================================================

# Você pode interagir com o sistema de gems programaticamente:

puts "--- Gems carregadas neste script ---"
Gem.loaded_specs.each do |nome, spec|
  puts "Nome: #{nome.ljust(15)} | Versão: #{spec.version}"
end

# Verificar se uma gem específica está instalada via código:
puts "\nVerificando instalação de 'bundler'..."
if Gem::Specification.find_all_by_name('bundler').any?
  puts "O Bundler está instalado no sistema."
else
  puts "Bundler não encontrado."
end

puts "\nGuia de manipulação de Gems carregado!"
