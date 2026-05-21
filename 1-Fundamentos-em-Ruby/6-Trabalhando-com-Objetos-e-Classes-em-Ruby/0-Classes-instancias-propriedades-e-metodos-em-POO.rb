# Programação Orientada a Objetos (POO) em Ruby

# Ruby é uma linguagem puramente orientada a objetos. Tudo em Ruby é um objeto.
# Uma classe é como um "molde" ou "planta" para criar objetos.

# --- 1. Definição de Classe e Instância ---
class Cachorro
  # O método 'initialize' é o construtor da classe.
  # Ele é executado automaticamente quando fazemos Cachorro.new
  def initialize(nome, raca)
    @nome = nome # @ indica uma variável de instância (propriedade do objeto)
    @raca = raca
  end

  # Método de instância: define o comportamento do objeto
  def latir
    puts "#{@nome} diz: Au Au!"
  end
end

# Criando instâncias (objetos) da classe Cachorro
meu_dog = Cachorro.new("Rex", "Labrador")
outro_dog = Cachorro.new("Bolinha", "Poodle")

meu_dog.latir
outro_dog.latir


# --- 2. Propriedades e Acessores (Getter e Setter) ---
# Por padrão, as variáveis de instância (@) são privadas.
# Para acessá-las ou modificá-las, usamos 'attr_accessor', 'attr_reader' ou 'attr_writer'.

class Pessoa
  # attr_reader: gera apenas o método de leitura (getter)
  # attr_writer: gera apenas o método de escrita (setter)
  # attr_accessor: gera ambos (leitura e escrita)
  attr_accessor :nome, :idade

  def initialize(nome, idade)
    @nome = nome
    @idade = idade
  end

  def apresentar
    puts "Olá, meu nome é #{@nome} e tenho #{@idade} anos."
  end
end

pessoa = Pessoa.new("Alice", 25)
pessoa.apresentar

# Alterando propriedades graças ao attr_accessor
pessoa.nome = "Alice Silva"
pessoa.idade = 26
puts "Nome atualizado: #{pessoa.nome}"


# --- 3. Métodos de Classe vs Métodos de Instância ---
class Calculadora
  # Método de Instância: Precisa de um objeto criado com .new
  def somar(a, b)
    a + b
  end

  # Método de Classe: Chamado diretamente na Classe (usa 'self.')
  def self.descricao
    "Eu sou uma classe de cálculos matemáticos."
  end
end

# Chamada de método de classe
puts Calculadora.descricao

# Chamada de método de instância
calc = Calculadora.new
puts "Soma: #{calc.somar(10, 5)}"


# --- 4. Encapsulamento (Public, Private, Protected) ---
# Controla quem pode acessar os métodos da classe.

class ContaBancaria
  def initialize(saldo_inicial)
    @saldo = saldo_inicial
  end

  # Público por padrão
  def exibir_saldo
    puts "Seu saldo é: R$ #{@saldo}"
    verificar_limite # Posso chamar um método privado internamente
  end

  private # Tudo abaixo de 'private' só pode ser chamado dentro da própria classe

  def verificar_limite
    puts "Verificando limites de segurança..."
  end
end

conta = ContaBancaria.new(1000)
conta.exibir_saldo
# conta.verificar_limite # ERRO: método privado!
