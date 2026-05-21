# Yield, Proc e Lambda em Ruby

# Estes conceitos permitem trabalhar com blocos de código como objetos, 
# tornando o Ruby extremamente flexível e poderoso para programação funcional.

# --- 1. Yield ---
# O 'yield' é usado dentro de um método para executar um bloco de código que foi 
# passado para ele no momento da chamada.

def metodo_com_yield
  puts "Início do método"
  yield if block_given? # Executa o bloco aqui
  puts "Fim do método"
end

metodo_com_yield { puts ">> Estou dentro do bloco executado pelo yield!" }

# Passando parâmetros para o yield
def calcular_area(base, altura)
  area = base * altura
  yield(area) if block_given?
end

calcular_area(10, 5) { |resultado| puts "A área calculada foi: #{resultado}" }


# --- 2. Proc (Procedure) ---
# Um Proc é um objeto que encapsula um bloco de código, permitindo salvá-lo 
# em uma variável e passá-lo para outros métodos.

meu_proc = Proc.new { |nome| puts "Olá, #{nome} (vindo de um Proc)" }

meu_proc.call("Henrique") # Chamando o Proc
meu_proc.call             # Procs não reclamam se faltar argumentos (nome será nil)


# --- 3. Lambda ---
# Lambdas são muito parecidos com Procs, mas com duas diferenças cruciais.
# Sintaxe: lambda { ... } ou -> { ... }

minha_lambda = -> (nome) { puts "Olá, #{nome} (vindo de uma Lambda)" }

minha_lambda.call("Ruby")
# minha_lambda.call # ERRO: Lambdas verificam o número de argumentos!


# --- 4. Diferenças Principais: Proc vs Lambda ---

# Diferença A: Argumentos
# Proc: Ignora argumentos extras ou faltantes.
# Lambda: Lança um erro se o número de argumentos estiver incorreto.

# Diferença B: O comando 'return'
# Em uma Lambda, o 'return' volta o controle para o método que a chamou.
# Em um Proc, o 'return' tenta sair de todo o escopo onde o Proc foi definido.

def teste_retorno
  # Exemplo com Lambda
  fazer_lambda = -> { return "Retorno da Lambda" }
  resultado = fazer_lambda.call
  puts "Após lambda: #{resultado}"

  # Exemplo com Proc
  fazer_proc = Proc.new { return "Retorno do Proc" }
  fazer_proc.call
  puts "Este código NUNCA será executado" # O return do Proc sai do método 'teste_retorno'
end

puts teste_retorno


# --- 5. Transformando Blocos em Procs (&) ---
# O símbolo '&' no parâmetro de um método transforma o bloco recebido em um Proc.

def receber_bloco(&meu_bloco_proc)
  puts "Vou executar o bloco agora..."
  meu_bloco_proc.call
end

receber_bloco { puts "Bloco transformado em Proc e executado!" }
