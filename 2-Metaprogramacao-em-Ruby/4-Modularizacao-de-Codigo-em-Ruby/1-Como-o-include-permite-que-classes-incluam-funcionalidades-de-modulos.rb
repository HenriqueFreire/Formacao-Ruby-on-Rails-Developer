# Como o 'include' funciona em Ruby
#
# O 'include' é a forma mais comum de utilizar Mixins em Ruby.
# Quando você inclui um módulo em uma classe:
# 1. Os métodos do módulo tornam-se métodos de INSTÂNCIA da classe.
# 2. O módulo é inserido na cadeia de herança (ancestors) logo ACIMA da classe.

# --- 1. Exemplo Básico de Mixin com include ---

module Voador
  def decolar
    puts "#{self.class}: Iniciando voo..."
  end

  def pousar
    puts "#{self.class}: Pousando com segurança."
  end
end

class Passaro
  include Voador
  
  def cantar
    puts "Piu piu!"
  end
end

class Aviao
  include Voador
  
  def ligar_motores
    puts "Motores ligados. Vrummmm!"
  end
end

# Testando as instâncias
passaro = Passaro.new
passaro.decolar  # Método do módulo
passaro.cantar   # Método da própria classe

aviao = Aviao.new
aviao.ligar_motores # Método da própria classe
aviao.decolar       # Método do módulo


# --- 2. Entendendo a Cadeia de Herança (Ancestors) ---
# O Ruby procura métodos primeiro na classe, depois nos módulos incluídos, e depois na superclasse.

puts "\nCadeia de herança de Passaro:"
puts Passaro.ancestors.inspect
# Resultado esperado: [Passaro, Voador, Object, Kernel, BasicObject]


# --- 3. Sobrescrita de Métodos ---
# Como o módulo está "acima" da classe na busca, a classe pode sobrescrever métodos do módulo.

module Trabalhador
  def trabalhar
    puts "Trabalhando normalmente..."
  end
end

class Programador
  include Trabalhador

  def trabalhar
    super # Chama a implementação do módulo
    puts "...mas escrevendo código Ruby!"
  end
end

dev = Programador.new
dev.trabalhar


# --- 4. Quando usar 'include'? ---
# Use include quando quiser que TODAS as instâncias de uma classe compartilhem o mesmo comportamento.
# É ideal para capacidades transversais (cross-cutting concerns) como:
# - Loggable (capacidade de logar)
# - Serializable (capacidade de transformar em JSON/XML)
# - Validatable (capacidade de validar dados)
