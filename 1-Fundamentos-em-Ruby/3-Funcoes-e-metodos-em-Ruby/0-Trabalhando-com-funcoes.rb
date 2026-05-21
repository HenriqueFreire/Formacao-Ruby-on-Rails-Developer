# Trabalhando com Funções (Métodos) em Ruby

# Em Ruby, definimos funções usando a palavra-chave 'def'. 
# Embora tecnicamente chamados de métodos (já que quase tudo em Ruby é um objeto), 
# eles funcionam como as funções de outras linguagens.

# 1. Definição Básica
def saudar
  puts "Olá! Bem-vindo ao mundo Ruby."
end

saudar # Chamada do método

# 2. Parâmetros e Argumentos
def saudar_pessoa(nome)
  puts "Olá, #{nome}! Como você está?"
end

saudar_pessoa("Henrique")

# 3. Parâmetros com Valores Padrão (Default)
def configurar_conexao(host = "localhost", porta = 3306)
  puts "Conectando a #{host} na porta #{porta}..."
end

configurar_conexao              # Usa os padrões: localhost, 3306
configurar_conexao("127.0.0.1") # Usa 127.0.0.1 e porta 3306
configurar_conexao("db.com", 5432)

# 4. Retorno de Valores
# Em Ruby, o método sempre retorna a última expressão avaliada (retorno implícito).
def soma(a, b)
  a + b # Não precisa da palavra 'return'
end

resultado = soma(10, 5)
puts "O resultado da soma é: #{resultado}"

# Retorno Explícito (útil para interrupções prematuras)
def verificar_idade(idade)
  return "Menor de idade" if idade < 18
  "Maior de idade"
end

puts verificar_idade(16)
puts verificar_idade(21)

# 5. Argumentos Variáveis (Splat Operator *)
# Permite passar um número indefinido de argumentos, que são recebidos como um Array.
def imprimir_lista(titulo, *itens)
  puts "--- #{titulo} ---"
  itens.each { |item| puts "- #{item}" }
end

imprimir_lista("Compras", "Arroz", "Feijão", "Carne", "Macarrão")

# 6. Keyword Arguments (Argumentos Nomeados)
# Melhora a legibilidade e permite passar argumentos em qualquer ordem.
def criar_usuario(nome:, idade:, email: "não informado")
  puts "Usuário: #{nome}, Idade: #{idade}, Email: #{email}"
end

criar_usuario(idade: 25, nome: "Alice")
criar_usuario(nome: "Bob", idade: 30, email: "bob@email.com")

# 7. Blocos como Parâmetros (&block)
# Métodos podem receber blocos de código para serem executados.
def executar_com_mensagem
  puts "Iniciando execução..."
  yield if block_given? # Executa o bloco passado
  puts "Execução finalizada."
end

executar_com_mensagem do
  puts "Processando dados dentro do bloco..."
end
