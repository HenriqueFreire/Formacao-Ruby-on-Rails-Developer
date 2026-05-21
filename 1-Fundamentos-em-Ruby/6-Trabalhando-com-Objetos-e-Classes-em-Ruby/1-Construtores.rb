# Construtores em Ruby: O Método 'initialize'

# Em Ruby, o construtor é sempre um método chamado 'initialize'.
# Ele é o coração da criação de objetos, responsável por definir o estado inicial.

# --- 1. Construtor Básico ---
class Livro
  attr_reader :titulo, :autor

  # Quando chamamos Livro.new("O Hobbit", "Tolkien"), o Ruby executa este método:
  def initialize(titulo, autor)
    @titulo = titulo
    @autor = autor
    puts "Novo livro criado: '#{@titulo}' de #{@autor}"
  end
end

livro1 = Livro.new("Dom Casmurro", "Machado de Assis")


# --- 2. Construtor com Valores Padrão (Default) ---
class Carro
  attr_accessor :marca, :ligado

  # Podemos definir valores padrão para os argumentos do construtor
  def initialize(marca = "Genérica")
    @marca = marca
    @ligado = false # Todo carro novo começa desligado por padrão
  end
end

carro_da_fiat = Carro.new("Fiat")
carro_generico = Carro.new # Usa o valor "Genérica"
puts "Marca do carro: #{carro_generico.marca}"


# --- 3. Construtor com Keyword Arguments (Argumentos Nomeados) ---
# Muito comum em Ruby moderno e no Rails, melhora a legibilidade.
class Usuario
  attr_reader :nome, :email, :admin

  def initialize(nome:, email:, admin: false)
    @nome = nome
    @email = email
    @admin = admin
  end
end

# A ordem não importa e o código fica mais explicativo:
user = Usuario.new(email: "henrique@email.com", nome: "Henrique")
puts "Usuário: #{user.nome}, Admin: #{user.admin}"


# --- 4. Construtor com Lógica e Validação ---
# O construtor não serve apenas para atribuir valores, ele pode processar dados.
class Produto
  attr_reader :nome, :preco

  def initialize(nome, preco)
    raise "O preço não pode ser negativo!" if preco < 0
    
    @nome = nome.capitalize
    @preco = preco
  end
end

begin
  produto_erro = Produto.new("Celular", -100)
rescue => e
  puts "Erro ao criar produto: #{e.message}"
end


# --- 5. O papel do 'new' vs 'initialize' ---
# Tecnicamente, 'new' é um método de classe que:
# 1. Aloca memória para o objeto.
# 2. Chama o método 'initialize' da instância.
# 3. Retorna o objeto recém-criado.
