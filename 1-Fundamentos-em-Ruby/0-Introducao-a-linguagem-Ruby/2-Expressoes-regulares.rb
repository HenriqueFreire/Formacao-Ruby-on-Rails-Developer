# Expressões Regulares (Regex) em Ruby

# O que são?
# Expressões Regulares são padrões usados para encontrar ou manipular sequências de caracteres em strings.
# Em Ruby, elas são objetos da classe Regexp e geralmente são delimitadas por barras: /padrao/

# --- 1. Definindo uma Regex ---
padrao_simples = /ruby/
puts "Encontrou 'ruby'?" if "Eu amo ruby" =~ padrao_simples

# --- 2. Operador de Correspondência (=~) ---
# Retorna a posição inicial da primeira ocorrência ou nil se não encontrar.
frase = "A linguagem Ruby é incrível"
posicao = frase =~ /Ruby/
puts "Posição do 'Ruby': #{posicao}" # 12

# --- 3. Caracteres Especiais e Metacaracteres ---
# \d - Qualquer dígito (0-9)
# \w - Qualquer caractere alfanumérico (a-z, A-Z, 0-9, _)
# \s - Espaço em branco (espaço, tab, nova linha)
# .  - Qualquer caractere exceto nova linha
# ^  - Início da linha
# $  - Fim da linha

# Exemplo: Validar formato de telefone simples (9 dígitos)
telefone = "98888-7777"
if telefone =~ /^\d{5}-\d{4}$/
  puts "Formato de telefone válido!"
end

# --- 4. Quantificadores ---
# *     - 0 ou mais vezes
# +     - 1 ou mais vezes
# ?     - 0 ou 1 vez
# {n,m} - De n a m vezes

# Exemplo: Encontrar números em uma string
texto = "O ano é 2024 e o preço é 150 reais."
numeros = texto.scan(/\d+/)
print "Números encontrados: #{numeros}\n" # ["2024", "150"]

# --- 5. Métodos Úteis com Regex ---

# .scan -> Retorna um array com todas as ocorrências
emails = "contato@teste.com, suporte@web.com.br".scan(/\w+@\w+\.\w+(\.\w+)?/)
# Nota: scan com grupos de captura () retorna sub-arrays, cuidado com a lógica.

# .match -> Retorna um objeto MatchData (detalhes da primeira ocorrência)
match = "Protocolo: 12345".match(/(\w+): (\d+)/)
if match
  puts "Chave: #{match[1]}"  # Protocolo
  puts "Valor: #{match[2]}"  # 12345
end

# .gsub -> Substituição global
string_limpa = "Ruby on Rails".gsub(/\s+/, "-")
puts "Substituição: #{string_limpa}" # Ruby-on-Rails

# --- 6. Validando um E-mail (Exemplo Prático) ---
email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
email = "usuario.teste@gmail.com"

if email.match?(email_regex)
  puts "E-mail válido!"
else
  puts "E-mail inválido!"
end
