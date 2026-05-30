# Classe Base representando o contrato genérico de um cofre
class Cofre
  attr_reader :tipo, :metodo_abertura

  def initialize(tipo, metodo_abertura)
    @tipo = tipo
    @metodo_abertura = metodo_abertura
  end

  def imprimir_informacoes
    puts "Tipo: #{@tipo}"
    puts "Metodo de abertura: #{@metodo_abertura}"
  end
end

# Subclasse especializada para cofres digitais com senha
class CofreDigital < Cofre
  def initialize(senha, confirmacao_senha)
    super("Cofre Digital", "Senha")
    @senha = senha
    @confirmacao_senha = confirmacao_senha
  end

  def validar_senha
    if @senha == @confirmacao_senha
      puts "Cofre aberto!"
    else
      puts "Senha incorreta!"
    end
  end
end

# Subclasse especializada para cofres físicos com chave
class CofreFisico < Cofre
  def initialize
    super("Cofre Fisico", "Chave")
  end
end

# Execução do programa seguindo as regras de negócio
if __FILE__ == $0
  tipo_cofre = gets.to_s.chomp

  if tipo_cofre.downcase == "digital"
    senha = gets.to_s.chomp
    confirmacao = gets.to_s.chomp
    
    cofre = CofreDigital.new(senha, confirmacao)
    cofre.imprimir_informacoes
    cofre.validar_senha
  else
    cofre = CofreFisico.new
    cofre.imprimir_informacoes
  end
end
