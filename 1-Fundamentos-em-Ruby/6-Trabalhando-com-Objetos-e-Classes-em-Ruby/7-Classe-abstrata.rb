# Classes Abstratas em Ruby

# Em linguagens como Java ou C#, uma classe abstrata é uma classe que não pode ser 
# instanciada e serve apenas como base para outras classes. 
# O Ruby não possui uma palavra-chave 'abstract', mas podemos simular esse 
# comportamento usando convenções e exceções.

# --- 1. Por que usar uma Classe Abstrata? ---
# Usamos classes abstratas quando queremos definir um modelo geral para um grupo 
# de objetos, mas esse modelo por si só é incompleto. Por exemplo: "Animal" 
# é um conceito abstrato, enquanto "Cachorro" é algo concreto que podemos criar.

# --- 2. Implementando uma Classe Abstrata ---

class FormaGeometrica
  def initialize
    # Impedindo a instanciação direta da classe base
    if self.instance_of?(FormaGeometrica)
      raise "Erro: FormaGeometrica é uma classe abstrata e não pode ser instanciada diretamente!"
    end
  end

  # Método Abstrato: Deve ser implementado pelas subclasses
  def calcular_area
    raise NotImplementedError, "#{self.class} deve implementar o método 'calcular_area'"
  end
end

# --- 3. Criando as Subclasses Concretas ---

class Quadrado < FormaGeometrica
  def initialize(lado)
    @lado = lado
    # Não chamamos super aqui para não disparar a validação de instância do pai,
    # ou podemos ajustar a lógica do pai para permitir subclasses.
  end

  def calcular_area
    @lado * @lado
  end
end

class Circulo < FormaGeometrica
  def initialize(raio)
    @raio = raio
  end

  def calcular_area
    Math::PI * (@raio ** 2)
  end
end

# --- 4. Testando o Comportamento ---

begin
  # Tentar criar a classe abstrata gera um erro
  forma = FormaGeometrica.new
rescue => e
  puts e.message
end

quadrado = Quadrado.new(5)
puts "Área do Quadrado: #{quadrado.calcular_area}"

circulo = Circulo.new(3)
puts "Área do Círculo: #{'%.2f' % circulo.calcular_area}"


# --- Resumo das Regras para Classes Abstratas em Ruby ---

# 1. Não instanciar: Adicione uma verificação no 'initialize' ou no método 'new'.
# 2. Métodos Obrigatórios: Use 'raise NotImplementedError' para garantir que as 
#    subclasses definam seus próprios comportamentos.
# 3. Modelagem: Use para definir comportamentos comuns (como um método 'cor' ou 'nome') 
#    que todas as subclasses terão, mas deixe os cálculos específicos para as filhas.

# Dica: Em projetos grandes, o uso de classes abstratas ajuda a documentar 
# o código e evitar bugs, deixando claro quais métodos são necessários para 
# que uma nova funcionalidade seja adicionada corretamente.
