# Utilização do alias_method em Ruby
#
# O 'alias_method' permite criar um "apelido" para um método existente. 
# Após criar o alias, o método original e o novo apelido apontam para a mesma implementação.

# 1. Exemplo Básico: Criando um apelido simples
class Humano
  def falar
    puts "Olá!"
  end

  # Sintaxe: alias_method :novo_nome, :nome_original
  alias_method :cumprimentar, :falar
end

h = Humano.new
h.falar         # Saída: Olá!
h.cumprimentar  # Saída: Olá!


# 2. Exemplo Prático: Redefinindo um método mas mantendo o original (Aumentando funcionalidade)
# Esta é uma técnica comum em metaprogramação para "envelopar" um método.
class Calculadora
  def somar(a, b)
    a + b
  end
end

class Calculadora
  # 1. Criamos um alias para o método original para não perdê-lo
  alias_method :somar_original, :somar

  # 2. Redefinimos o método original
  def somar(a, b)
    puts "Realizando uma soma de #{a} e #{b}..."
    resultado = somar_original(a, b) # Chamamos o original via alias
    puts "Resultado: #{resultado}"
    resultado
  end
end

calc = Calculadora.new
calc.somar(5, 10)
# Saída:
# Realizando uma soma de 5 e 10...
# Resultado: 15


# 3. Diferença entre 'alias' e 'alias_method'
#
# - 'alias': É uma palavra-chave do Ruby. Trabalha com identificadores diretamente.
#   Ex: alias novo_nome nome_antigo (sem vírgulas)
#
# - 'alias_method': É um método da classe Module. Trabalha com símbolos ou strings.
#   Pode ser usado dinamicamente e é afetado pelo escopo de herança.
#   É a escolha preferida em metaprogramação.


# 4. Caso de Uso: Internacionalização ou Compatibilidade
class Usuario
  attr_accessor :nome

  def initialize(nome)
    @nome = nome
  end

  def full_name
    @nome
  end

  # Criando apelidos para compatibilidade com diferentes convenções
  alias_method :nome_completo, :full_name
end

u = Usuario.new("Felipe")
puts u.full_name      # Felipe
puts u.nome_completo  # Felipe


# BOAS PRÁTICAS:
# - Use 'alias_method' quando precisar criar nomes alternativos que façam mais sentido 
#   em contextos diferentes.
# - Tome cuidado ao redefinir métodos originais para não causar loops infinitos 
#   (sempre garanta que o alias aponte para a versão que você deseja preservar).
