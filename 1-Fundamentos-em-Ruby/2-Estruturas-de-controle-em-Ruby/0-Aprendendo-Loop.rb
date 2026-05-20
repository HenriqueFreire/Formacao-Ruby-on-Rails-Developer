# Estruturas de Repetição (Loops) em Ruby

# Ruby oferece várias formas de repetir um bloco de código.

# --- 1. Loop Básico (loop do) ---
# Executa infinitamente até encontrar a palavra 'break'.
puts "--- Loop do ---"
contador = 1
loop do
  puts "Contagem: #{contador}"
  break if contador == 3 # Para o loop quando chegar em 3
  contador += 1
end

# --- 2. WHILE (Enquanto) ---
# Executa enquanto a condição for VERDADEIRA.
puts "\n--- While ---"
i = 0
while i < 3
  puts "i é: #{i}"
  i += 1
end

# --- 3. UNTIL (Até que) ---
# Executa enquanto a condição for FALSA (até que se torne verdadeira).
puts "\n--- Until ---"
j = 0
until j == 3
  puts "j é: #{j}"
  j += 1
end

# --- 4. FOR ---
# Usado geralmente para percorrer coleções ou intervalos.
puts "\n--- For ---"
for k in 1..3
  puts "k é: #{k}"
end

# --- 5. Iterador .EACH (O mais comum em Ruby) ---
# É a forma preferida para percorrer arrays e hashes.
puts "\n--- Each (Array) ---"
frutas = ["Maçã", "Banana", "Uva"]
frutas.each do |fruta|
  puts "Fruta: #{fruta}"
end

# --- 6. TIMES ---
# Executa um bloco um número específico de vezes.
puts "\n--- Times ---"
3.times { |n| puts "Execução número #{n}" }

# --- Comandos de Controle de Loop ---
# break -> Sai do loop imediatamente
# next  -> Pula para a próxima iteração
# redo  -> Repete a iteração atual desde o início (sem reavaliar a condição)

puts "\n--- Exemplo com Next ---"
(1..5).each do |numero|
  next if numero == 3 # Pula o número 3
  puts "Número: #{numero}"
end
