# Arrays em Ruby

# Arrays são coleções ordenadas de objetos, que podem ser de qualquer tipo.
# Os índices começam em 0.

# --- 1. Criando Arrays ---
frutas = ["Maçã", "Banana", "Morango"]
numeros = Array.new(3, 0) # Cria [0, 0, 0]
misto = ["Texto", 10, true, :simbolo]

# --- 2. Acessando Elementos ---
puts "Primeira fruta: #{frutas[0]}"
puts "Última fruta: #{frutas[-1]}"
puts "Intervalo: #{frutas[0..1].inspect}" # ["Maçã", "Banana"]

# --- 3. Adicionando Elementos ---
frutas << "Uva"             # Operador shovel (mais comum)
frutas.push("Manga")        # Adiciona no final
frutas.unshift("Abacaxi")   # Adiciona no início
print "Array atualizado: #{frutas}\n"

# --- 4. Removendo Elementos ---
frutas.pop                  # Remove o último ("Manga")
frutas.shift                # Remove o primeiro ("Abacaxi")
frutas.delete_at(1)         # Remove pelo índice
frutas.delete("Banana")     # Remove pelo valor
print "Após remoções: #{frutas}\n"

# --- 5. Métodos Úteis ---
numeros = [5, 2, 8, 1, 9]

puts "Tamanho: #{numeros.length}"
puts "Está vazio? #{numeros.empty?}"
puts "Inclui o número 8? #{numeros.include?(8)}"
puts "Array ordenado: #{numeros.sort.inspect}"
puts "Array invertido: #{numeros.reverse.inspect}"

# --- 6. Transformações e Iteração ---
# .map (ou .collect) cria um NOVO array com os resultados
dobro = numeros.map { |n| n * 2 }
print "Dobro: #{dobro}\n"

# .select filtra elementos
pares = numeros.select { |n| n.even? }
print "Pares: #{pares}\n"

# .each apenas percorre
frutas.each_with_index do |fruta, indice|
  puts "#{indice}: #{fruta}"
end

# --- 7. Unindo Arrays ---
a = [1, 2]
b = [3, 4]
c = a + b # [1, 2, 3, 4]
print "União: #{c}\n"
