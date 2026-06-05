# Exemplos de Rake Tasks em Projetos Reais

# Em aplicações profissionais, as tarefas Rake são usadas para manutenção, 
# migração de dados, integração com APIs e tarefas agendadas (cron jobs).

# =============================================================================
# 1. LIMPEZA E MANUTENÇÃO DE DADOS
# =============================================================================
# Útil para remover registros órfãos ou limpar logs antigos sem travar a aplicação.

namespace :limpeza do
  desc "Remove carrinhos de compra abandonados há mais de 30 dias"
  task :carrinhos_abandonados => :environment do
    puts "Iniciando limpeza de carrinhos..."
    total = Cart.where("updated_at < ?", 30.days.ago).delete_all
    puts "Foram removidos #{total} carrinhos abandonados."
  end
end

# =============================================================================
# 2. SINCRONIZAÇÃO COM APIs EXTERNAS
# =============================================================================
# Frequentemente executado de forma agendada para buscar dados externos.

namespace :sync do
  desc "Busca cotações de moedas atualizadas via API externa"
  task :moedas => :environment do
    puts "Buscando cotações..."
    # Exemplo hipotético:
    # response = HTTParty.get("https://api.exemplo.com/cotacao")
    # Moeda.update_all_rates(response.parsed_response)
    puts "Cotações atualizadas com sucesso!"
  end
end

# =============================================================================
# 3. GERAÇÃO DE RELATÓRIOS E EXPORTAÇÃO
# =============================================================================
# Usado para gerar CSVs ou planilhas pesadas que não devem ser processadas no Request.

namespace :relatorios do
  desc "Gera CSV com as vendas do mês anterior"
  task :vendas_mensais => :environment do
    require 'csv'
    nome_arquivo = "relatorio_vendas_#{Time.now.strftime('%Y_%m')}.csv"
    
    puts "Gerando relatório: #{nome_arquivo}..."
    # Lógica para escrever o CSV
    puts "Relatório gerado na pasta /tmp!"
  end
end

# =============================================================================
# 4. MIGRAR DADOS (AD-HOC)
# =============================================================================
# Diferente das migrations de banco, estas tasks movem dados entre colunas ou tabelas.

namespace :migracao do
  desc "Formata todos os telefones de usuários no novo padrão (DDI + DDD)"
  task :formatar_telefones => :environment do
    User.find_each do |user|
      next if user.telefone.blank?
      # Lógica de formatação
      # user.update(telefone: novo_telefone)
      print "."
    end
    puts "\nTelefones formatados!"
  end
end

# =============================================================================
# 5. COMO EXECUTAR PERIODICAMENTE?
# =============================================================================
# No Linux, usamos o 'Crontab'. Em Rails, a gem 'Whenever' é a mais usada:
#
# Exemplo de schedule.rb (Gem Whenever):
# every 1.day, at: '4:30 am' do
#   rake "limpeza:carrinhos_abandonados"
# end
#
# every :hour do
#   rake "sync:moedas"
# end

puts "Exemplos de Rake Tasks reais carregados!"
