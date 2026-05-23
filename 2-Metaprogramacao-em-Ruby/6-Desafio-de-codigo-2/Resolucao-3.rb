class Robo
  def initialize(nome, modelo, ano_fabricacao)
    @nome = nome
    @modelo = modelo
    @ano_fabricacao = ano_fabricacao
  end

  def exibir_informacoes
    puts "O robô #{@nome}, modelo #{@modelo}, foi fabricado em #{@ano_fabricacao}."
  end
end

nome = gets.chomp
modelo = gets.chomp
ano = gets.chomp.to_i

meu_robo = Robo.new(nome, modelo, ano)
meu_robo.exibir_informacoes
