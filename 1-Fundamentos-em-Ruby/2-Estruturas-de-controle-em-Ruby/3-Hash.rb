# Hashes em Ruby

# Um Hash é uma coleção de pares chave-valor. 
# É semelhante a um dicionário em outras linguagens.

# --- 1. Criando Hashes ---

# Sintaxe antiga (Hash Rocket) - Permite qualquer tipo de chave
carro_antigo = { 
  :marca => "Ford", 
  :modelo => "Mustang", 
  "ano" => 1967 
}

# Sintaxe moderna (JSON style) - Usa Símbolos como chaves (mais comum)
carro = { 
  marca: "Toyota", 
  modelo: "Corolla", 
  ano: 2024 
}

# --- 2. Acessando Valores ---
puts "Marca: #{carro[:marca]}"
puts "Modelo: #{carro[:modelo]}"
puts "Ano (String): #{carro_antigo["ano"]}"

# --- 3. Adicionando e Alterando ---
carro[:cor] = "Prata"     # Adiciona nova chave-valor
carro[:ano] = 2025        # Altera valor existente
puts "Carro atualizado: #{carro.inspect}"

# --- 4. Removendo Elementos ---
carro.delete(:cor)
puts "Após deletar cor: #{carro.inspect}"

# --- 5. Métodos Úteis ---
puts "Chaves: #{carro.keys}"
puts "Valores: #{carro.values}"
puts "Tamanho: #{carro.size}"
puts "Possui a chave :marca? #{carro.key?(:marca)}"

# --- 6. Mesclando Hashes (.merge) ---
detalhes = { portas: 4, combustivel: "Flex" }
carro_completo = carro.merge(detalhes)
puts "Carro Completo: #{carro_completo}"

# --- 7. Iteração em Hashes ---
puts "\n--- Percorrendo o Hash ---"
carro_completo.each do |chave, valor|
  puts "#{chave.capitalize}: #{valor}"
end

# --- 8. Valor Padrão ---
# Por padrão, acessar uma chave inexistente retorna nil.
# Podemos mudar isso:
dicionario = Hash.new("Não encontrado")
puts "Chave inexistente: #{dicionario[:teste]}" # "Não encontrado"
