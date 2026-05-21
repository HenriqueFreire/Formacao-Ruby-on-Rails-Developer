# Metaprogramação: Acrescentando Métodos de Classe Dinamicamente

# Métodos de classe (estáticos) pertencem à própria classe e não às suas instâncias.
# No Ruby, uma classe é um OBJETO (instância de Class). Portanto, adicionar um 
# método de classe é, tecnicamente, adicionar um método à Singleton Class daquela classe.

class Relatorio
end

# --- 1. Usando instance_eval no Objeto Classe ---
# Como a classe 'Relatorio' é um objeto, usar instance_eval nela define métodos
# que pertencem apenas a ela (ou seja, métodos de classe).

Relatorio.instance_eval do
  def gerar_pdf
    puts "Gerando PDF do relatório global..."
  end
end

Relatorio.gerar_pdf


# --- 2. Usando a Eigenclass (class << self) ---
# Esta é uma das formas mais limpas e comuns em metaprogramação para abrir o 
# escopo da "Singleton Class" da classe.

class << Relatorio
  def gerar_csv
    puts "Gerando CSV do relatório global..."
  end
end

Relatorio.gerar_csv


# --- 3. Usando define_singleton_method ---
# Uma forma programática e direta de definir um único método de classe.

Relatorio.define_singleton_method(:gerar_json) do |usuario|
  puts "Gerando JSON para o usuário #{usuario}..."
end

Relatorio.gerar_json("Henrique")


# --- 4. Usando extend (Injeção via Módulos) ---
# O método 'extend' inclui os métodos de um módulo diretamente na 
# Singleton Class da classe, tornando-os métodos de classe.

module UtilitariosDeBusca
  def buscar_por_id(id)
    puts "Buscando registro #{id} no banco de dados..."
  end
end

class Usuario
  extend UtilitariosDeBusca # Transforma métodos do módulo em métodos de classe
end

Usuario.buscar_por_id(123)


# --- Resumo Técnico ---

# | Técnica                   | Descrição                                              |
# |---------------------------|--------------------------------------------------------|
# | instance_eval             | Abre o escopo do objeto classe para injetar métodos.   |
# | class << self             | Abre a Singleton Class (Eigenclass) da classe.        |
# | define_singleton_method   | Define um método exclusivo para o objeto classe.       |
# | extend Modulo             | Injeta métodos de um módulo como métodos de classe.    |

# Dica: Métodos de classe dinâmicos são fundamentais para criar o que chamamos 
# de "Macros" em Ruby (como o 'attr_accessor', 'has_many' no Rails, etc).
