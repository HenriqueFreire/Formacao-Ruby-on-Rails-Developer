# Módulos e Mixins: Compartilhando Funcionalidades em Ruby

# Como Ruby não suporta herança múltipla (uma classe não pode herdar de duas pais), 
# usamos Módulos para compartilhar comportamentos entre classes diferentes. 
# Quando um módulo é incluído em uma classe, ele é chamado de 'Mixin'.

# --- 1. include: Adicionando Métodos de Instância ---
# O uso mais comum. Os métodos do módulo tornam-se disponíveis para os objetos da classe.

module Loggable
  def log(mensagem)
    puts "[LOG - #{Time.now}]: #{mensagem}"
  end
end

class Pagamento
  include Loggable
  def processar
    log("Iniciando processamento de pagamento...")
  end
end

class Usuario
  include Loggable
  def atualizar_perfil
    log("Perfil do usuário atualizado.")
  end
end

Pagamento.new.processar
Usuario.new.atualizar_perfil


# --- 2. extend: Adicionando Métodos de Classe ---
# Os métodos do módulo tornam-se métodos estáticos da classe.

module Validacoes
  def validar_presenca(valor)
    puts "Validando se o valor está presente..."
    !valor.nil? && !valor.empty?
  end
end

class Produto
  extend Validacoes # Os métodos entram como self.metodo
end

puts "Produto é válido? #{Produto.validar_presenca("Teclado")}"


# --- 3. prepend: Alterando a Ordem de Busca (Hierarquia) ---
# Diferente do 'include', o 'prepend' coloca o módulo ANTES da própria classe.
# Útil para decorar métodos existentes sem usar super.

module Debugger
  def realizar_acao
    puts "DEBUG: Antes da ação..."
    super
    puts "DEBUG: Depois da ação..."
  end
end

class Pedido
  prepend Debugger
  def realizar_acao
    puts "Processando pedido no sistema..."
  end
end

Pedido.new.realizar_acao


# --- 4. Módulos como Namespaces (Organização) ---
# Evita conflitos de nomes em projetos grandes.

module Financeiro
  class Calculadora
    def self.calcular_imposto(valor); valor * 0.1; end
  end
end

module Engenharia
  class Calculadora
    def self.calcular_resistencia(peso); peso / 2; end
  end
end

puts Financeiro::Calculadora.calcular_imposto(100)
puts Engenharia::Calculadora.calcular_resistencia(100)


# --- Resumo Técnico ---

# | Comando | Tipo de Método Injetado | Posição na Hierarquia (Ancestors) |
# |---------|-------------------------|-----------------------------------|
# | include | Instância               | Logo ACIMA da classe              |
# | extend  | Classe (Singleton)      | Na Singleton Class da classe      |
# | prepend | Instância               | Logo ABAIXO da classe (prioridade)|

# Dica: No Ruby on Rails, Mixins são usados o tempo todo (ex: o módulo 'Enumerable' 
# traz métodos como .map e .select para qualquer classe que implemente .each).
