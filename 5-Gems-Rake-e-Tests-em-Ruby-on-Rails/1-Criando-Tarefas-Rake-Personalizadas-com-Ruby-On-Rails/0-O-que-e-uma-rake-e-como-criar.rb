# O que é Rake e como criar tarefas personalizadas

# Rake (Ruby Make) é uma ferramenta de automação de tarefas para Ruby. 
# Ela permite definir fluxos de trabalho, scripts de manutenção e automações 
# que podem ser executados facilmente pelo terminal.

# =============================================================================
# 1. CONCEITOS BÁSICOS
# =============================================================================
# As tarefas Rake são geralmente definidas em arquivos com extensão .rake 
# dentro da pasta lib/tasks/ de um projeto Rails, ou em um arquivo Rakefile na raiz.

# --- Exemplo de uma tarefa simples ---
# desc "Uma descrição clara do que a tarefa faz"
# task :ola_mundo do
#   puts "Olá! Esta é minha primeira tarefa Rake."
# end

# Para executar no terminal:
# $ rake ola_mundo
# (ou no Rails: $ rails ola_mundo)

# =============================================================================
# 2. NAMESPACES (Organização)
# =============================================================================
# Namespaces ajudam a agrupar tarefas relacionadas e evitar conflitos de nomes.

namespace :sistema do
  desc "Limpa os arquivos temporários do sistema"
  task :limpar do
    puts "Limpando arquivos temporários..."
    # Código para deletar arquivos
    puts "Limpeza concluída!"
  end

  desc "Exibe o status do servidor"
  task :status do
    puts "Servidor está online e operando normalmente."
  end
end

# Para executar:
# $ rake sistema:limpar
# $ rake sistema:status

# =============================================================================
# 3. DEPENDÊNCIAS DE TAREFAS
# =============================================================================
# Você pode definir que uma tarefa só deve ser executada após outra.

task :preparar do
  puts "Preparando o terreno..."
end

desc "Executa a tarefa principal após a preparação"
task :principal => :preparar do
  puts "Executando a tarefa principal agora!"
end

# Ao rodar 'rake principal', o Rake executará primeiro 'preparar'.

# =============================================================================
# 4. ACESSANDO O AMBIENTE DO RAILS
# =============================================================================
# No Ruby on Rails, se sua tarefa precisar acessar Models ou o Banco de Dados,
# você deve adicionar a dependência :environment.

# namespace :db_utils do
#   desc "Conta quantos usuários existem no banco"
#   task :contar_usuarios => :environment do
#     quantidade = User.count
#     puts "Existem #{quantidade} usuários cadastrados."
#   end
# end

# =============================================================================
# 5. PASSANDO PARÂMETROS
# =============================================================================
# Embora existam formas complexas, a forma mais simples é usar variáveis de ambiente:

# desc "Tarefa que recebe um nome"
# task :saudacao do
#   nome = ENV['NOME'] || 'Visitante'
#   puts "Olá, #{nome}!"
# end
# Execução: $ rake saudacao NOME=Henrique

puts "Documentação sobre Rake carregada com sucesso!"

