# Utilizando Stub para Mudar Retorno de Método Interno

# Muitas vezes, um método que queremos testar chama outro método dentro da mesma classe. 
# Se esse método interno for complexo, lento ou depender de recursos externos, 
# podemos usar um stub para simplificar o teste do método principal.

# --- 1. Exemplo de Lógica Interna ---

class ProcessadorDePedido
  def processar(pedido)
    if estoque_disponivel?(pedido)
      finalizar_venda(pedido)
      "Pedido Processado"
    else
      "Estoque Insuficiente"
    end
  end

  # Imagine que este método faz uma consulta complexa a um WebService de estoque
  def estoque_disponivel?(pedido)
    # Lógica complexa aqui...
    raise "Erro: Conexão com WebService de Estoque falhou!"
  end

  def finalizar_venda(pedido)
    # Lógica de salvar no banco...
  end
end

# --- 2. Testando com RSpec ---

# Queremos testar a lógica do método 'processar' sem disparar o erro do 'estoque_disponivel?'.

=begin
RSpec.describe ProcessadorDePedido do
  let(:processador) { ProcessadorDePedido.new }
  let(:pedido) { { item: "Teclado", qtd: 1 } }

  it "retorna 'Pedido Processado' quando o estoque está disponível (usando Stub interno)" do
    # STUB INTERNO: Forçamos o método da PRÓPRIA instância a retornar true
    allow(processador).to receive(:estoque_disponivel?).with(pedido).and_return(true)
    
    # Garantimos que o finalizar_venda não faça nada (opcional, para isolamento)
    allow(processador).to receive(:finalizar_venda)

    expect(processador.processar(pedido)).to eq("Pedido Processado")
  end

  it "retorna 'Estoque Insuficiente' quando o estoque não está disponível" do
    # STUB INTERNO: Forçamos o retorno false
    allow(processador).to receive(:estoque_disponivel?).and_return(false)

    expect(processador.processar(pedido)).to eq("Estoque Insuficiente")
  end
end
=end

# --- 3. Por que stubbar métodos da própria classe? ---

# 1. Decomposição: Permite testar a "orquestração" de um método separadamente da 
#    implementação dos seus ajudantes (helper methods).
# 2. Simulação de Estados: Facilita testar caminhos de erro (como o else do if) 
#    sem ter que configurar todo o estado do sistema para que o método interno retorne falso.
# 3. Foco: O teste foca apenas na responsabilidade do método 'processar'.

# --- CUIDADO: O Perigo dos "Testes Mentirosos" ---

# Abusar de stubs em métodos internos pode levar a testes que passam mas que, 
# na realidade, estão testando uma lógica que não existe mais ou que está 
# desconectada da implementação real. 
# Use com moderação e garanta que os métodos internos também tenham seus próprios testes de unidade.

# --- CONCLUSÃO ---

# Stubbar métodos internos é uma técnica essencial para lidar com dependências 
# dentro da própria classe, garantindo que você possa testar fluxos lógicos 
# complexos de forma isolada, rápida e previsível.
