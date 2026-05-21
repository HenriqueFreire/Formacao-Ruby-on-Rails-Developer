# Singleton em Ruby: Padrão de Projeto e Eigenclass

# O termo "Singleton" em Ruby pode se referir a duas coisas diferentes, mas relacionadas:
# 1. O Padrão de Projeto Singleton (Garantir uma única instância).
# 2. A Singleton Class (Eigenclass) - Uma classe oculta vinculada a um único objeto.

# --- 1. O Padrão de Projeto Singleton ---
# Usado quando você precisa que uma classe tenha exatamente UMA instância em todo o sistema.
# Exemplo: Configurações do sistema, Logs, Conexão única com Banco de Dados.

require 'singleton'

class ConfiguracaoApp
  include Singleton # Este módulo faz a mágica

  attr_accessor :tema, :idioma

  def initialize
    @tema = "Escuro"
    @idioma = "PT-BR"
  end
end

# Não podemos fazer ConfiguracaoApp.new (Gera erro)
# Usamos .instance para acessar a única instância existente.

config1 = ConfiguracaoApp.instance
config1.tema = "Claro"

config2 = ConfiguracaoApp.instance
puts "Tema do config2: #{config2.tema}" # Saída: "Claro" (É o mesmo objeto!)
puts "São o mesmo objeto? #{config1.object_id == config2.object_id}"


# --- 2. Singleton Class (Eigenclass) ---
# Em Ruby, cada objeto tem uma "classe oculta" exclusiva para ele.
# Isso permite adicionar métodos apenas a UM objeto específico, sem alterar a classe original.

texto = "Olá mundo"

# Adicionando um método apenas ao objeto 'texto'
def texto.gritar
  self.upcase + "!!!"
end

puts texto.gritar # Funciona para este objeto

outro_texto = "Ruby"
# puts outro_texto.gritar # ERRO: NoMethodError (método existe apenas no objeto 'texto')


# --- 3. Acessando a Singleton Class explicitamente ---
# Podemos usar a sintaxe 'class << self' dentro de um objeto ou classe.

class << texto
  def inverter_e_gritar
    self.reverse.upcase + "???"
  end
end

puts texto.inverter_e_gritar


# --- 4. Por que isso é importante? ---
# 1. Métodos de Classe: No Ruby, métodos de classe (def self.metodo) são, na verdade, 
#    métodos definidos na Singleton Class da própria Classe.
# 2. Flexibilidade Extrema: Permite modificar o comportamento de objetos em tempo 
#    de execução, técnica usada extensivamente por frameworks como o RSpec para criar Mocks.

# Resumo:
# - Módulo Singleton: Garante que só exista um objeto daquela classe (use include Singleton).
# - Singleton Class (Eigenclass): É o lugar onde moram os métodos exclusivos de um objeto.
