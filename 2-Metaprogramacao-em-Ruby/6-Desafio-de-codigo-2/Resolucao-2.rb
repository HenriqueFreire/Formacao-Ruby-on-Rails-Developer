class Robo
  attr_accessor :velocidade_atual
  attr_reader :velocidade_maxima, :velocidade_minima

  def initialize(vmin, vmax)
    @velocidade_minima = vmin
    @velocidade_maxima = vmax
    @velocidade_atual = vmin # Inicialmente Vmin para alinhar com os testes
  end

  def acelerar
    @velocidade_atual += 1 if @velocidade_atual < @velocidade_maxima
  end

  def desacelerar
    @velocidade_atual -= 1 if @velocidade_atual > @velocidade_minima
  end
end

vmin, vmax = gets.chomp.split.map(&:to_i)
comandos = gets.chomp

robo = Robo.new(vmin, vmax)

comandos.each_char do |comando|
  case comando
  when 'A'
    robo.acelerar
  when 'D'
    robo.desacelerar
  end
end

puts robo.velocidade_atual
