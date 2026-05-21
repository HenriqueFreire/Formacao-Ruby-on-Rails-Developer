# Métodos com Interrogação (?) e Exclamação (!) em Ruby

# Ruby permite usar '?' e '!' no final do nome dos métodos. 
# Embora o Ruby não obrigue regras técnicas sobre isso, a comunidade segue 
# convenções fortes que tornam o código muito mais legível.

# --- 1. Métodos com Interrogação (?) - Predicados ---
# Por convenção, métodos que terminam com '?' devem retornar um valor booleano (true ou false).
# Eles são usados para fazer perguntas ao objeto.

nome = "Henrique"
puts nome.empty?   # Pergunta: "Está vazio?" -> false
puts nome.start_with?("H") # Pergunta: "Começa com H?" -> true

# Criando nosso próprio método predicado
class Produto
  attr_reader :nome, :estoque

  def initialize(nome, estoque)
    @nome = nome
    @estoque = estoque
  end

  # Convenção: retorna true se houver estoque
  def disponivel?
    @estoque > 0
  end
end

p1 = Produto.new("Teclado", 10)
puts "O produto está disponível? #{p1.disponivel?}"


# --- 2. Métodos com Exclamação (!) - "Perigosos" ou Mutantes ---
# Métodos que terminam com '!' indicam que o método é "perigoso" ou que 
# ele altera o objeto original (modificação in-place).

texto = "ruby"

# Versão SEM exclamação: Retorna uma CÓPIA modificada, o original continua igual.
texto_maiusculo = texto.upcase
puts "Original: #{texto}"          # "ruby"
puts "Cópia: #{texto_maiusculo}"   # "RUBY"

# Versão COM exclamação: Altera o objeto ORIGINAL permanentemente.
texto.upcase!
puts "Original após upcase!: #{texto}" # "RUBY" (O original foi alterado!)

# Outro uso da exclamação: Métodos que lançam exceções em vez de apenas retornar nil/false.
# Comum no Rails: .save (retorna false se falhar) vs .save! (lança erro se falhar).


# --- 3. Criando Métodos com Exclamação ---

class Usuario
  attr_accessor :nome

  def initialize(nome)
    @nome = nome
  end

  # Versão segura: retorna o nome limpo
  def nome_limpo
    @nome.strip
  end

  # Versão "perigosa": limpa o nome no próprio objeto
  def nome_limpo!
    @nome.strip!
  end
end

user = Usuario.new("   Alice   ")
user.nome_limpo  # Retorna "Alice", mas user.nome ainda tem espaços
puts "Sem !: '#{user.nome}'"

user.nome_limpo! # Modifica a variável @nome internamente
puts "Com !: '#{user.nome}'"


# --- Resumo ---

# | Símbolo | Nome      | O que significa?                                      |
# |---------|-----------|-------------------------------------------------------|
# | ?       | Predicado | Faz uma pergunta e retorna sempre true ou false.      |
# | !       | Bang      | Altera o objeto original ou indica uma ação crítica.  |
