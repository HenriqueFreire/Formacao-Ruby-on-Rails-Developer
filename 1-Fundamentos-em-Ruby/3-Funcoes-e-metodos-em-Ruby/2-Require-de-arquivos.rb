# Organização de Arquivos: Require, Require_relative e Load

# À medida que seu projeto cresce, você precisa dividir seu código em vários arquivos.
# O Ruby oferece três formas principais de carregar código externo.

# --- 1. require ---
# É usado para carregar bibliotecas padrão do Ruby (Standard Library), Gems externas 
# ou arquivos que estão no diretório de busca do Ruby ($LOAD_PATH).
# Carrega o arquivo apenas UMA vez, mesmo se chamado repetidamente.

require 'json' # Carregando uma biblioteca padrão
require 'date'

hoje = Date.today
puts "Hoje é: #{hoje}"


# --- 2. require_relative ---
# É a forma mais comum de carregar arquivos que fazem parte do SEU projeto.
# Ele busca o arquivo a partir da pasta onde o arquivo ATUAL está localizado.

# Exemplo (supondo que exista um arquivo 'utilitarios.rb' na mesma pasta):
# require_relative 'utilitarios'


# --- 3. load ---
# Semelhante ao 'require', mas carrega o arquivo TODA VEZ que é chamado.
# É útil em ambientes de desenvolvimento onde você altera o código e quer 
# ver as mudanças sem reiniciar o programa (ex: consoles interativos).

# load 'configuracoes.rb'


# --- Exemplo Prático de Organização ---

# Imagine que temos o seguinte módulo em outro arquivo:
=begin
# arquivo: helpers.rb
module Calculadora
  def self.somar(a, b)
    a + b
  end
end
=end

# Para usar o código acima no script principal:
# require_relative 'helpers'
# puts Calculadora.somar(5, 5)


# --- Diferenças Resumidas ---

# | Método           | Uso Principal                | Carregamento | Caminho             |
# |------------------|------------------------------|--------------|---------------------|
# | require          | Bibliotecas e Gems           | Único        | $LOAD_PATH          |
# | require_relative | Arquivos do seu projeto      | Único        | Relativo ao arquivo |
# | load             | Arquivos de configuração/dev | Múltiplo     | Caminho completo    |


# Dica: No Ruby on Rails, o carregamento de arquivos é feito automaticamente 
# pelo framework (Autoloading), mas entender esses comandos é essencial 
# para entender como as Gems e o próprio Ruby funcionam "por baixo dos panos".
