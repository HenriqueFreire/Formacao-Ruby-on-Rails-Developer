# Métodos de Classe (Estáticos) em Ruby

# Em linguagens como Java ou C#, existem métodos "estáticos". No Ruby, chamamos de 
# "Métodos de Classe". Eles pertencem à classe em si, e não a uma instância (objeto).

# --- 1. Definindo Métodos de Classe com 'self' ---
# A forma mais comum de definir um método de classe é prefixando o nome com 'self.'.

class Configuracao
  # Variável de classe (compartilhada por todas as instâncias e pela classe)
  @@versao = "1.0.0"

  # Método de Classe
  def self.exibir_versao
    puts "A versão atual do sistema é: #{@@versao}"
  end

  # Outro Método de Classe (Utilitário)
  def self.limpar_cache
    puts "Limpando todos os arquivos temporários..."
  end
end

# Chamamos o método diretamente na Classe, sem usar .new
Configuracao.exibir_versao
Configuracao.limpar_cache


# --- 2. Quando usar Métodos de Classe? ---
# 1. Métodos utilitários que não dependem do estado de um objeto específico.
# 2. Fábricas (Factories) para criar objetos de formas específicas.
# 3. Gerenciamento de configurações globais da classe.

class Usuario
  attr_accessor :nome, :papel

  def initialize(nome, papel)
    @nome = nome
    @papel = papel
  end

  # Padrão Factory: Cria um usuário admin de forma simplificada
  def self.criar_admin(nome)
    Usuario.new(nome, "Administrador")
  end

  # Padrão Factory: Cria um usuário visitante
  def self.criar_visitante(nome)
    Usuario.new(nome, "Visitante")
  end
end

admin = Usuario.criar_admin("Henrique")
visitante = Usuario.criar_visitante("João")

puts "Usuário: #{admin.nome}, Papel: #{admin.papel}"


# --- 3. Variáveis de Classe (@@) vs Variáveis de Instância (@) ---
# Variáveis de classe são úteis para manter estados globais dentro da classe.

class Contador
  @@total_objetos = 0

  def initialize
    @@total_objetos += 1
  end

  def self.total
    @@total_objetos
  end
end

Contador.new
Contador.new
Contador.new

puts "Total de objetos criados: #{Contador.total}" # Saída: 3


# --- 4. Diferença Crucial ---

# class Exemplo
#   def instancia
#     "Precisa de Exemplo.new para me chamar"
#   end
#
#   def self.classe
#     "Chamado diretamente em Exemplo.classe"
#   end
# end


# --- Resumo ---
# - Métodos de classe usam 'self.' na definição.
# - São chamados diretamente no nome da Classe.
# - Não têm acesso às variáveis de instância (@) de um objeto específico, 
#   pois não há 'objeto' no contexto da classe.
