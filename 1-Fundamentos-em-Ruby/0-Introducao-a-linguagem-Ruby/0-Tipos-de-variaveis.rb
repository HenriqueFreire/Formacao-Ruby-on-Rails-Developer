# Tipos de Variáveis em Ruby

# 1. Variáveis Locais
# Começam com letra minúscula ou sublinhado (_). 
# Seu escopo é restrito ao lugar onde foram declaradas (método, bloco, etc).
nome = "João"
_idade = 25
puts "Local: #{nome}, #{_idade}"

# 2. Variáveis de Instância
# Começam com '@'. 
# São exclusivas de uma instância específica de um objeto.
class Pessoa
  def initialize(nome)
    @nome = nome # Variável de instância
  end
  
  def imprimir_nome
    puts "Instância: #{@nome}"
  end
end

# 3. Variáveis de Classe
# Começam com '@@'. 
# São compartilhadas entre todas as instâncias de uma classe e suas subclasses.
class Carro
  @@quantidade_de_rodas = 4 # Variável de classe
  
  def exibir_rodas
    puts "Classe: Rodas = #{@@quantidade_de_rodas}"
  end
end

# 4. Variáveis Globais
# Começam com '$'. 
# Podem ser acessadas de qualquer lugar do programa (use com cautela).
$versao_do_sistema = "1.0.0"
puts "Global: #{$versao_do_sistema}"

# 5. Constantes
# Começam com uma letra MAIÚSCULA. 
# Seu valor não deve ser alterado após a definição inicial.
PI = 3.1415
ESTADO = "São Paulo"
puts "Constante: PI = #{PI}"
