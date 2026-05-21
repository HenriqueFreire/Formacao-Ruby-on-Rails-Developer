# Uso de class_eval e instance_eval para Adição Dinâmica

# Estes dois métodos são os pilares para mudar o contexto de execução em Ruby.
# A regra de ouro é: 
# - instance_eval: Muda o 'self' para o OBJETO (cria métodos de instância no objeto ou métodos de classe na classe).
# - class_eval: Muda o 'self' para a CLASSE (cria métodos de instância para todas as futuras instâncias).

class Carro
end

# --- 1. instance_eval aplicado a uma CLASSE ---
# Quando usamos instance_eval em uma classe, estamos tratando a classe como um OBJETO.
# Portanto, os métodos criados serão MÉTODOS DE CLASSE.

Carro.instance_eval do
  def descricao
    "Eu sou a classe Carro!"
  end
end

puts Carro.descricao


# --- 2. class_eval aplicado a uma CLASSE ---
# Aqui, entramos no escopo de definição da classe. É como se estivéssemos 
# escrevendo código dentro do bloco 'class Carro ... end'.
# Portanto, os métodos criados serão MÉTODOS DE INSTÂNCIA.

Carro.class_eval do
  def buzinar
    "Beep Beep!"
  end
  
  # Também podemos adicionar atributos dinamicamente
  attr_accessor :cor
end

meu_carro = Carro.new
meu_carro.cor = "Vermelho"
puts "Cor do carro: #{meu_carro.cor}"
puts "Som: #{meu_carro.buzinar}"


# --- 3. instance_eval aplicado a uma INSTÂNCIA ---
# Quando aplicado a um objeto específico, ele cria métodos exclusivos para aquele objeto.

fusca = Carro.new
fusca.instance_eval do
  def heranca_cultural
    "Sou um clássico!"
  end
end

puts fusca.heranca_cultural
# Carro.new.heranca_cultural # ERRO: método não existe para outros carros


# --- 4. Diferença Visual e Contextual ---

# | Método        | Aplicado a | Resultado                          | Contexto (self)   |
# |---------------|------------|------------------------------------|-------------------|
# | instance_eval | Classe     | Método de Classe (Estático)        | A própria Classe  |
# | class_eval    | Classe     | Método de Instância + Atributos    | A própria Classe  |
# | instance_eval | Objeto     | Método de Instância Único          | O próprio Objeto  |


# --- Exemplo Prático: Injetando Atributos Dinamicamente ---

def adicionar_campo(classe, nome_campo)
  classe.class_eval do
    attr_accessor nome_campo
  end
end

class Usuario; end

adicionar_campo(Usuario, :cpf)
u = Usuario.new
u.cpf = "123.456.789-00"
puts "CPF do usuário: #{u.cpf}"


# Resumo:
# Use 'class_eval' quando quiser que TODAS as instâncias ganhem novos métodos ou atributos.
# Use 'instance_eval' quando quiser adicionar métodos de classe ou métodos a um único objeto.
