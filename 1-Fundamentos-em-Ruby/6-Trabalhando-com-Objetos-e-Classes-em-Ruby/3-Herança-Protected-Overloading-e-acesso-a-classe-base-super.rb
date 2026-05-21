# Herança, Super e Sobrescrita de Métodos em Ruby

# A herança permite que uma classe (filha) herde características e comportamentos 
# de outra classe (pai ou base). Isso promove o reuso de código.

# --- 1. Herança Básica ---
class Animal
  attr_reader :nome

  def initialize(nome)
    @nome = nome
  end

  def comer
    puts "#{@nome} está comendo..."
  end

  def emitir_som
    puts "O animal emite um som genérico."
  end
end

# A classe Cachorro herda de Animal usando o símbolo '<'
class Cachorro < Animal
  def emitir_som
    puts "#{@nome} diz: Au Au!"
  end
end

rex = Cachorro.new("Rex")
rex.comer      # Herdado de Animal
rex.emitir_som # Sobrescrito em Cachorro


# --- 2. O uso do 'super' ---
# O 'super' invoca o método de mesmo nome da classe pai (base).

class Gato < Animal
  def emitir_som
    super # Chama o emitir_som de Animal
    puts "Mas na verdade, #{@nome} diz: Miau!"
  end
end

felix = Gato.new("Felix")
felix.emitir_som


# --- 3. Super no Construtor (initialize) ---
# Muito comum para inicializar atributos da classe base.

class Passaro < Animal
  attr_reader :cor
  
  def initialize(nome, cor)
    super(nome) # Passa o nome para o construtor de Animal
    @cor = cor
  end
end

piu_piu = Passaro.new("Piu-piu", "Amarelo")
puts "Pássaro: #{piu_piu.nome}, Cor: #{piu_piu.cor}"


# --- 4. Sobrescrita vs Overloading ---
# NOTA: Ruby NÃO suporta Overloading (múltiplos métodos com mesmo nome e argumentos diferentes).
# Se você definir o mesmo método duas vezes, o segundo substituirá o primeiro.

class Calculadora
  # Em Ruby, usamos argumentos opcionais para simular overloading
  def somar(a, b, c = 0)
    a + b + c
  end
end

calc = Calculadora.new
puts "Soma de 2: #{calc.somar(5, 5)}"
puts "Soma de 3: #{calc.somar(5, 5, 5)}"


# --- 5. Protected na Herança ---
# Métodos protegidos podem ser chamados por instâncias de classes filhas.

class Veiculo
  protected
  def ligar_motor
    puts "Motor roncando..."
  end
end

class Moto < Veiculo
  def dar_partida
    ligar_motor # Filha acessa o método protected da mãe
  end
end

biz = Moto.new
biz.dar_partida
# biz.ligar_motor # ERRO: Inacessível de fora
