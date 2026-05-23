class Pessoa
  attr_accessor :nome, :idade

  def initialize(nome, idade)
    @nome = nome
    @idade = idade
  end
end

class Program
  def self.main
    nome = gets.chomp

    idade = gets.chomp.to_i

    pessoa = Pessoa.new(nome, idade)

    puts "Nome: #{pessoa.nome}, Idade: #{pessoa.idade}"
  end
end

Program.main
