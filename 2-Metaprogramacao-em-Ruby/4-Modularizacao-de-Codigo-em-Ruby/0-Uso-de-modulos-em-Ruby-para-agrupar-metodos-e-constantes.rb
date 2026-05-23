# Uso de Módulos em Ruby
#
# Módulos em Ruby têm duas funções principais:
# 1. Namespacing (Espaço de Nomes): Agrupar métodos, classes e constantes relacionadas para evitar colisões de nomes.
# 2. Mixins: Compartilhar funcionalidade entre classes (Ruby não suporta herança múltipla).

# --- 1. Namespacing (Espaço de Nomes) ---
# Usado para organizar o código e evitar que nomes de classes ou constantes iguais entrem em conflito.

module Pagamentos
  VERSAO = "1.0.0"

  class Cartao
    def processar
      puts "Processando pagamento via Cartão..."
    end
  end

  module Gateway
    def self.conectar
      puts "Conectando ao gateway de pagamentos..."
    end
  end
end

# Acessando constantes e classes do módulo
puts "Versão do Módulo: #{Pagamentos::VERSAO}"

pagamento = Pagamentos::Cartao.new
pagamento.processar

Pagamentos::Gateway.conectar


# --- 2. Agrupando Métodos (Métodos de Módulo) ---
# Módulos podem conter métodos que podem ser chamados diretamente (como métodos estáticos).

module MatematicaFisica
  PI = 3.14159

  # Usamos 'self' para definir métodos que pertencem ao módulo
  def self.calcular_area_circulo(raio)
    PI * (raio ** 2)
  end
end

puts "Área do círculo: #{MatematicaFisica.calcular_area_circulo(10)}"


# --- 3. Mixins (Compartilhamento de código) ---
# Quando incluímos um módulo em uma classe, ela ganha os métodos do módulo.

module Loggable
  def log(mensagem)
    puts "[LOG - #{Time.now}]: #{mensagem}"
  end
end

class ServicoVendas
  include Loggable # Os métodos tornam-se métodos de INSTÂNCIA

  def vender(produto)
    log("Iniciando venda do produto: #{produto}")
    # ... lógica de venda
    log("Venda finalizada com sucesso.")
  end
end

servico = ServicoVendas.new
servico.vender("Notebook")


# --- DIFERENÇAS ENTRE MODULE E CLASS ---
# 1. Módulos NÃO podem ser instanciados (não existe Module.new no sentido de criar um objeto).
# 2. Módulos NÃO possuem herança (não podem herdar de outro módulo ou classe).
# 3. Classes podem herdar de UMA classe, mas podem incluir VÁRIOS módulos (Mixins).
