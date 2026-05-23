  # O método method_missing em Ruby
  #
  # O 'method_missing' é um "hook method" (método de gancho) que o Ruby chama automaticamente
  # quando você tenta invocar um método que não existe em um objeto.
  # Ele é uma das ferramentas mais poderosas da metaprogramação em Ruby.

  # 1. Exemplo Básico: Capturando qualquer chamada
  class SaudadorDinamico
    def method_missing(nome_metodo, *args)
      puts "Você tentou chamar o método '#{nome_metodo}' com os argumentos: #{args.join(', ')}"
      puts "Mas esse método não existe! Vou te cumprimentar de qualquer jeito."
    end
  end

s = SaudadorDinamico.new
s.ola("Joaquim", "Maria")
# Saída:
# Você tentou chamar o método 'ola' com os argumentos: Joaquim, Maria
# Mas esse método não existe! Vou te cumprimentar de qualquer jeito.


# 2. Exemplo Prático: Criando um "Hash-like" Object
# Útil para APIs onde você quer acessar chaves como se fossem métodos.
class Configuracao
  def initialize
    @dados = { status: "ativo", versao: "1.0.2" }
  end

  def method_missing(nome_metodo, *args)
    # Verificamos se a chave existe no nosso hash interno
    if @dados.key?(nome_metodo)
      @dados[nome_metodo]
    else
      # Se não existe, chamamos o 'super' para manter o comportamento padrão (erro)
      super
    end
  end

  # IMPORTANTE: Sempre que implementar method_missing, implemente respond_to_missing?
  def respond_to_missing?(nome_metodo, incluir_privado = false)
    @dados.key?(nome_metodo) || super
  end
end

config = Configuracao.new
puts "Status: #{config.status}" # Chama method_missing e retorna "ativo"
# puts config.usuario           # Lançará NoMethodError (comportamento padrão via super)


# 3. Boas Práticas e Cuidados
#
# - Sempre use 'super': Se você não souber lidar com o método, chame 'super' para que 
#   o Ruby continue a busca na cadeia de herança ou lance o erro NoMethodError original.
#
# - Performance: O 'method_missing' é mais lento que métodos definidos normalmente,
#   pois o Ruby precisa percorrer toda a árvore de herança antes de decidir chamá-lo.
#
# - respond_to_missing?: Sem isso, métodos como 'respond_to?' retornarão 'false' 
#   mesmo que o seu objeto saiba lidar com a chamada via 'method_missing'.

# Exemplo de respond_to? funcionando:
puts "Responde a status? #{config.respond_to?(:status)}" # true
puts "Responde a usuario? #{config.respond_to?(:usuario)}" # false
