require 'date'

# Classe que representa uma análise individual com data e descrição
class Analise
  attr_reader :data, :descricao

  def initialize(data, descricao)
    @data = data
    @descricao = descricao
  end
end

class SistemaAcionistas
  def obter_analises_desempenho(data_inicial_str, data_final_str)
    # Parsing seguro das datas utilizando o formato brasileiro
    inicio = parse_data(data_inicial_str)
    fim    = parse_data(data_final_str)

    # Base de dados (Mock) conforme os requisitos do desafio.
    # Nota: Mantido o erro ortográfico "Analises Comporativas" para compatibilidade com o desafio.
    analises = [
      Analise.new(parse_data("01/01/2023"), "Analise de Desempenho Financeiro"),
      Analise.new(parse_data("15/02/2023"), "Analise de Riscos e Exposicoes"),
      Analise.new(parse_data("31/03/2023"), "Analises Corporativas"),
      Analise.new(parse_data("01/04/2023"), "Analise de Politicas e Regulamentacoes"),
      Analise.new(parse_data("15/05/2023"), "Analise de Ativos"),
      Analise.new(parse_data("30/06/2023"), "Analise de Inovacao e Tecnologia")
    ]

    # Filtragem utilizando lógica de intervalo e extração da descrição
    analises
      .select { |a| a.data >= inicio && a.data <= fim }
      .map(&:descricao)
  end

  private

  def parse_data(data_str)
    # Date.strptime é a forma mais robusta e idiomática de lidar com datas em formatos específicos
    Date.strptime(data_str, '%d/%m/%Y')
  rescue ArgumentError
    nil
  end
end

# Execução do Programa
if __FILE__ == $0
  # Leitura das entradas do usuário
  data_inicio_str = gets.to_s.chomp
  data_fim_str    = gets.to_s.chomp

  sistema = SistemaAcionistas.new
  
  # Processamento e exibição dos resultados linha a linha
  resultados = sistema.obter_analises_desempenho(data_inicio_str, data_fim_str)
  resultados.each { |desc| puts desc }
end
