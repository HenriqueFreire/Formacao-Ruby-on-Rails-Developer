# Implementação de Mixins em Ruby
#
# Mixins são módulos que contêm um conjunto de métodos que podem ser 
# compartilhados por múltiplas classes. Eles resolvem o problema da 
# falta de herança múltipla no Ruby, permitindo que classes "misturem" 
# funcionalidades de diferentes fontes.

# --- 1. O Problema: Classes diferentes precisando de comportamentos iguais ---
# Imagine que temos uma classe 'Usuario' e uma classe 'Pedido'.
# Ambas precisam de uma funcionalidade para gerar um Log formatado em JSON.

module JsonSerializable
  def to_json
    puts "Gerando representação JSON para #{self.class}..."
    # Simulando a conversão dos atributos para JSON
    atributos = self.instance_variables.map do |var|
      "\"#{var.to_s.delete('@')}\": \"#{self.instance_variable_get(var)}\""
    end
    "{ #{atributos.join(', ')} }"
  end
end

class Usuario
  include JsonSerializable
  def initialize(nome, email)
    @nome = nome
    @email = email
  end
end

class Pedido
  include JsonSerializable
  def initialize(id, total)
    @id = id
    @total = total
  end
end

# Testando o compartilhamento de comportamento
user = Usuario.new("Alice", "alice@email.com")
puts user.to_json

order = Pedido.new(101, 250.50)
puts order.to_json


# --- 2. Mixins com Múltiplos Módulos ---
# Uma classe pode incluir quantos mixins desejar, ganhando superpoderes de várias fontes.

module Autenticavel
  def login
    puts "Usuário logado no sistema."
  end
end

module Auditoria
  def registrar_alteracao(campo, antigo, novo)
    puts "[AUDITORIA]: O campo '#{campo}' mudou de '#{antigo}' para '#{novo}'"
  end
end

class Admin
  include Autenticavel
  include Auditoria
  include JsonSerializable
  
  def initialize(login)
    @login = login
  end
end

puts "\n--- Testando Admin com múltiplos Mixins ---"
admin = Admin.new("admin_root")
admin.login
admin.registrar_alteracao("senha", "123", "abc")
puts admin.to_json


# --- 3. Mixins Famosos do Ruby (Exemplo Real) ---
# O Ruby já vem com mixins poderosos, como o 'Comparable'.
# Ao incluir 'Comparable' e definir o método '<=>' (espaçonave), 
# sua classe ganha os métodos <, <=, ==, >, >= e between?.

class Produto
  include Comparable
  attr_reader :nome, :preco

  def initialize(nome, preco)
    @nome = nome
    @preco = preco
  end

  # Definindo a lógica de comparação para o mixin Comparable
  def <=>(outro_produto)
    @preco <=> outro_produto.preco
  end
end

p1 = Produto.new("Teclado", 150)
p2 = Produto.new("Mouse", 80)

puts "\n--- Usando Mixin Comparable ---"
puts "Teclado é mais caro que Mouse? #{p1 > p2}" # true
puts "Preço do Mouse está entre 50 e 100? #{p2.preco.between?(50, 100)}" # true


# RESUMO:
# - Mixins promovem a REUTILIZAÇÃO de código.
# - Permitem composição de objetos de forma FLEXÍVEL.
# - Evitam a complexidade e a ambiguidade da herança múltipla tradicional.
