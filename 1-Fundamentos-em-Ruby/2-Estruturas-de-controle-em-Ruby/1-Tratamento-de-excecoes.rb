# Tratamento de Exceções em Ruby

# Exceções são erros que ocorrem durante a execução do programa. 
# Ruby usa o bloco begin/rescue para capturar e tratar esses erros.

# --- 1. Estrutura Básica (begin / rescue) ---
puts "--- Exemplo 1: Divisão por Zero ---"
begin
  resultado = 10 / 0
rescue StandardError => e
  puts "Erro capturado: #{e.message}"
  puts "Classe do erro: #{e.class}"
end

# --- 2. Múltiplos Rescues ---
# Você pode tratar diferentes tipos de erro de formas diferentes.
puts "\n--- Exemplo 2: Múltiplos Erros ---"
begin
  # lista = [1, 2, 3]
  # lista["chave"] # Isso causaria um TypeError
  10 / 0          # Isso causa ZeroDivisionError
rescue ZeroDivisionError
  puts "Ops! Você tentou dividir por zero."
rescue TypeError => e
  puts "Erro de tipo: #{e.message}"
rescue => e
  puts "Ocorreu um erro genérico: #{e.message}"
end

# --- 3. Else e Ensure ---
# else: Executado apenas se NENHUMA exceção ocorrer.
# ensure: Executado SEMPRE, ocorrendo erro ou não (ideal para fechar arquivos/conexões).
puts "\n--- Exemplo 3: Else e Ensure ---"
begin
  puts "Tentando realizar uma operação..."
  operacao = 10 / 2
rescue
  puts "Deu erro!"
else
  puts "Sucesso! O resultado é #{operacao}"
ensure
  puts "Fim da operação (sempre executado)."
end

# --- 4. Levando (Raising) suas próprias exceções ---
# Você pode forçar a ocorrência de um erro usando 'raise'.
puts "\n--- Exemplo 4: Raise ---"
def verificar_idade(idade)
  if idade < 0
    raise "A idade não pode ser negativa!" # Gera um RuntimeError por padrão
  end
  puts "Idade válida: #{idade}"
end

begin
  verificar_idade(-5)
rescue => e
  puts "Erro customizado: #{e.message}"
end

# --- 5. Retry ---
# O comando 'retry' permite repetir o bloco 'begin' desde o início.
# CUIDADO: Pode gerar um loop infinito se não for controlado.
puts "\n--- Exemplo 5: Retry ---"
tentativas = 0
begin
  tentativas += 1
  puts "Tentativa #{tentativas}..."
  raise "Erro de conexão" if tentativas < 3
rescue
  retry if tentativas < 3
  puts "Falha após 3 tentativas."
end

