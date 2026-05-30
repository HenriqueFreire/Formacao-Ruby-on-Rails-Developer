class ContaBancaria
  attr_reader :numero, :titular, :saldo

  def initialize(numero, titular, saldo)
    @numero = numero
    @titular = titular
    @saldo = saldo
  end

  def exibir_informacoes
    puts "Informacoes:"
    puts "Conta: #{@numero}"
    puts "Titular: #{@titular}"
    puts "Saldo: R$ #{@saldo}"
  end
end

# Execução do programa
if __FILE__ == $0
  # Leitura e higienização de dados
  numero_conta = gets.to_s.chomp
  nome_titular = gets.to_s.chomp
  saldo_inicial = gets.to_f

  # Instanciação e exibição conforme contrato do desafio
  conta = ContaBancaria.new(numero_conta, nome_titular, saldo_inicial)
  conta.exibir_informacoes
end
