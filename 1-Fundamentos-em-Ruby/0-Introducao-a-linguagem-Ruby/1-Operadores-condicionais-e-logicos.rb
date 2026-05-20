# Operadores Condicionais e Lógicos em Ruby

# --- Operadores de Comparação ---
# Usados para comparar valores e retornar um booleano (true ou false).
a = 10
b = 20

puts "Igual (==): #{a == b}"        # false
puts "Diferente (!=): #{a != b}"    # true
puts "Maior (>): #{a > b}"          # false
puts "Menor (<): #{a < b}"          # true
puts "Maior ou igual (>=): #{a >= 10}" # true
puts "Menor ou igual (<=): #{b <= 20}" # true

# Operador Spaceship (<=>)
# Retorna 0 se forem iguais, 1 se o primeiro for maior, -1 se o segundo for maior.
puts "Spaceship: #{10 <=> 20}"      # -1

# --- Operadores Lógicos ---
# Usados para combinar expressões booleanas.
tem_dinheiro = true
tem_tempo = false

# E (&& ou and) - Ambas devem ser verdadeiras
puts "Pode viajar (&&)? #{tem_dinheiro && tem_tempo}" # false

# OU (|| ou or) - Pelo menos uma deve ser verdadeira
puts "Pode viajar (||)? #{tem_dinheiro || tem_tempo}" # true

# NEGAÇÃO (! ou not) - Inverte o valor booleano
puts "Não tem tempo (!)? #{!tem_tempo}" # true

# --- Estruturas Condicionais ---

# 1. IF / ELSIF / ELSE
idade = 18

if idade < 16
  puts "Não pode votar"
elsif idade >= 16 && idade < 18
  puts "Voto facultativo"
else
  puts "Voto obrigatório"
end

# 2. UNLESS (A menos que)
# É o oposto do IF. Executa se a condição for FALSA.
chovendo = false
unless chovendo
  puts "Vou caminhar!" # Executa porque chovendo é false
end

# 3. Operador Ternário
# Condição ? Verdadeiro : Falso
resultado = idade >= 18 ? "Maior de idade" : "Menor de idade"
puts "Ternário: #{resultado}"

# 4. CASE (Semelhante ao switch)
nota = 8
case nota
when 0..4
  puts "Reprovado"
when 5..6
  puts "Recuperação"
when 7..10
  puts "Aprovado"
else
  puts "Nota inválida"
end
