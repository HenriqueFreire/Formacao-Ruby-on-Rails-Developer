# Guia de Comandos Básicos de Terminal e Script Executável

# ==========================================
# 1. Explicação de Comandos Básicos
# ==========================================
# pwd      - Exibe o caminho do diretório atual (Print Working Directory).
# ls       - Lista arquivos e pastas no diretório atual.
# cd <dir> - Entra em um diretório (Change Directory).
# cd ..    - Volta um nível na estrutura de pastas.
# mkdir    - Cria uma nova pasta (Make Directory).
# touch    - Cria um novo arquivo vazio.
# rm <arq> - Remove um arquivo.
# rm -rf   - Remove uma pasta e todo seu conteúdo (CUIDADO!).
# clear    - Limpa a tela do terminal.

# ==========================================
# 2. Script Ruby Interativo
# ==========================================

def mostrar_cabecalho
  puts "=" * 40
  puts "   EXECUTOR DE COMANDOS DE TERMINAL"
  puts "=" * 40
end

def executar_demonstracao
  puts "\n[1] Verificando diretório atual (pwd):"
  system("pwd")

  puts "\n[2] Listando arquivos neste diretório (ls):"
  system("ls")

  puts "\n[3] Informações do Sistema:"
  puts "Sistema Operacional: #{RUBY_PLATFORM}"
  puts "Versão do Ruby: #{RUBY_VERSION}"
end

# Início do script
mostrar_cabecalho
executar_demonstracao

puts "\n" + "=" * 40
puts "Dica: Você pode executar este script com:"
puts "ruby 1-Criando-aplicacoes-pelo-terminal-em-Ruby/0-Comandos-de-terminal.rb"
puts "=" * 40
