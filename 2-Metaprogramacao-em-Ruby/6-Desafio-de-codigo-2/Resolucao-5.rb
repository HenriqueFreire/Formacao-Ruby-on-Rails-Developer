class Carta
  attr_reader :naipe, :valor

  def initialize(naipe, valor)
    @naipe = naipe
    @valor = valor
  end
end

module Naipe
  Paus = 0
  Ouros = 1
  Copas = 2
  Espadas = 3
end

module Valor
  As = 1
  Valete = 2
  Dama = 3
  Rei = 4
end

# Input para escolher a carta desejada
valor_escolhido = gets.chomp.to_i
naipe_escolhido = gets.chomp.to_i

# Criação da carta escolhida pelo usuário
carta_escolhida = Carta.new(naipe_escolhido, valor_escolhido)

# Mapeamento para nomes
nomes_valores = {
  Valor::As => "Ás",
  Valor::Valete => "Valete",
  Valor::Dama => "Dama",
  Valor::Rei => "Rei"
}

nomes_naipes = {
  Naipe::Paus => "Paus",
  Naipe::Ouros => "Ouros",
  Naipe::Copas => "Copas",
  Naipe::Espadas => "Espadas"
}

nome_valor = nomes_valores[carta_escolhida.valor]
nome_naipe = nomes_naipes[carta_escolhida.naipe]

puts "Carta escolhida: #{nome_valor} de #{nome_naipe}"
