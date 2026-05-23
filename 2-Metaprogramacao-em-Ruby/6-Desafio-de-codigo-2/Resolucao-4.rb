class Personagem
  attr_accessor :nome, :mana

  def initialize(nome, mana)
    @nome = nome
    @mana = mana
  end
end

class Subclasse < Personagem
  attr_accessor :dano_base

  def initialize(nome, mana, dano_base)
    super(nome, mana)
    @dano_base = dano_base
  end

  def calcular_dano
    puts "#{@nome} atacou e causou #{@dano_base * @mana} de dano!"
  end
end

nome = gets.chomp

mana = gets.chomp.to_i

dano_base = gets.chomp.to_i

personagem = Subclasse.new(nome, mana, dano_base)
personagem.calcular_dano
