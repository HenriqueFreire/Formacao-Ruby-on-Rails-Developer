# Introdução à Metaprogramação em Ruby

# Metaprogramação é, de forma simples, "código que escreve ou manipula código".
# No Ruby, isso é possível porque a linguagem é extremamente dinâmica e 
# permite modificar sua própria estrutura em tempo de execução.

# --- 1. Open Classes (Classes Abertas) ---
# Você pode reabrir qualquer classe (inclusive as nativas) e adicionar novos métodos.

class String
  def inverter_e_gritar
    self.reverse.upcase + "!!!"
  end
end

puts "ruby".inverter_e_gritar # Saída: "YBUR!!!"


# --- 2. O Método 'send' (Chamada Dinâmica) ---
# Permite chamar um método através de um símbolo ou string. 
# Útil quando você só sabe qual método chamar em tempo de execução.

class Calculadora
  def somar(a, b); a + b; end
  def subtrair(a, b); a - b; end
end

calc = Calculadora.new
operacao = "somar" # Isso poderia vir de um input do usuário ou banco de dados
puts calc.send(operacao, 10, 5) # Chama calc.somar(10, 5)


# --- 3. 'define_method' (Criação Dinâmica de Métodos) ---
# Define métodos programaticamente dentro de uma classe.

class Atendente
  ["ola", "bom_dia", "boa_noite"].each do |saudacao|
    define_method(saudacao) do |nome|
      "#{saudacao.capitalize.gsub('_', ' ')}, #{nome}!"
    end
  end
end

atendente = Atendente.new
puts atendente.bom_dia("Henrique")
puts atendente.boa_noite("Alice")


# --- 4. 'method_missing' (Captura de Métodos Inexistentes) ---
# O Ruby chama este método quando você tenta invocar algo que não existe.
# É a base para criar "métodos fantasmas".

class TradutorMagico
  def method_missing(nome_metodo, *args)
    if nome_metodo.to_s.start_with?("falar_em_")
      idioma = nome_metodo.to_s.split("_").last
      puts "Traduzindo '#{args.first}' para o idioma: #{idioma.capitalize}..."
    else
      super # Se não for o que queremos, deixa o Ruby dar o erro padrão
    end
  end
end

tradutor = TradutorMagico.new
tradutor.falar_em_ingles("Olá")
tradutor.falar_em_japones("Bom dia")


# --- 5. Por que usar Metaprogramação? ---
# 1. Redução de código repetitivo (DRY - Don't Repeat Yourself).
# 2. Criação de DSLs (Domain Specific Languages) - ex: as rotas do Rails.
# 3. Flexibilidade extrema em frameworks.

# AVISO: Com grandes poderes vêm grandes responsabilidades. 
# Metaprogramação em excesso pode tornar o código difícil de debugar e entender.
