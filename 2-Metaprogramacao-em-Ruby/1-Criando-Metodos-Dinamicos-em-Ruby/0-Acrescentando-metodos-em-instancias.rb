# Metaprogramação: Acrescentando Métodos em Instâncias Específicas

# No Ruby, cada objeto possui uma "Singleton Class" (ou Eigenclass), que é uma 
# classe oculta exclusiva daquela instância. Isso nos permite injetar 
# comportamentos em um único objeto sem alterar sua classe original.

class Carro
  def buzinar
    puts "Beep beep!"
  end
end

carro_popular = Carro.new
carro_esportivo = Carro.new

# --- 1. Adição Direta (Singleton Method) ---
# O método 'ativar_nitro' existirá APENAS para o objeto 'carro_esportivo'.

def carro_esportivo.ativar_nitro
  puts "VELOCIDADE MÁXIMA ATIVADA! 🏎️💨"
end

carro_esportivo.buzinar      # Método da classe Carro
carro_esportivo.ativar_nitro # Método da Singleton Class de carro_esportivo

carro_popular.buzinar
# carro_popular.ativar_nitro # Isso causaria um NoMethodError


# --- 2. Injeção via instance_eval ---
# Ideal para definir múltiplos métodos ou acessar o estado interno do objeto.

carro_popular.instance_eval do
  # Definindo uma variável de instância 'na hora'
  @modelo = "Fusca"

  def exibir_modelo
    puts "Eu sou um #{@modelo} econômico!"
  end
end

carro_popular.exibir_modelo


# --- 3. Introspecção: Onde vivem esses métodos? ---
# Podemos visualizar os métodos que foram criados especificamente para o objeto.

puts "Métodos exclusivos do carro_esportivo: #{carro_esportivo.singleton_methods}"
puts "A classe oculta é: #{carro_esportivo.singleton_class}"


# --- 4. Por que refatorar e usar essa técnica? ---
# - Flexibilidade: Você não precisa criar uma nova classe 'CarroComNitro' para apenas um objeto.
# - Desacoplamento: Útil para decorar objetos em tempo de execução.
# - Testabilidade: Permite criar comportamentos específicos em Mocks sem afetar o sistema global.

# Resumo:
# O Ruby trata objetos como entidades vivas que podem aprender novas 
# habilidades individualmente a qualquer momento da execução.
