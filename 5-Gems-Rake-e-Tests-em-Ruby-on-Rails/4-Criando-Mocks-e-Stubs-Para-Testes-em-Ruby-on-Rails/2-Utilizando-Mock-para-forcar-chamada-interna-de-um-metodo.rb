# Utilizando Mock para Forçar Chamada Interna de um Método

# Enquanto o STUB é usado para simular um ESTADO (o que o método retorna), 
# o MOCK é usado para verificar um COMPORTAMENTO (se o método foi chamado).

# O Mock garante que um efeito colateral esperado realmente aconteceu.

# --- 1. Exemplo de Comportamento com Efeito Colateral ---

class NotificadorDePedido
  def enviar_confirmacao(pedido)
    # Lógica complexa de envio de e-mail...
    EmailService.enviar(pedido.usuario.email, "Seu pedido foi recebido!")
  end
end

class ServicoDeCheckout
  def initialize(notificador)
    @notificador = notificador
  end

  def finalizar(pedido)
    # Lógica de persistência no banco...
    
    # Queremos garantir que, ao finalizar, o notificador seja acionado.
    @notificador.enviar_confirmacao(pedido)
  end
end

# --- 2. Testando com RSpec (Usando Mocks) ---

=begin
RSpec.describe ServicoDeCheckout do
  it "deve chamar o notificador ao finalizar um pedido" do
    notificador_mock = double("Notificador")
    servico = ServicoDeCheckout.new(notificador_mock)
    pedido  = double("Pedido")

    # EXPECTATIVA (MOCK): O teste só passará se o método for chamado exatamente 1 vez.
    expect(notificador_mock).to receive(:enviar_confirmacao).with(pedido).once

    servico.finalizar(pedido)
  end
end
=end

# --- 3. Diferenças entre expect().to receive (Mock) e allow().to receive (Stub) ---

# - allow(...).to receive(...): "Se chamarem este método, retorne isso." (Opcional)
# - expect(...).to receive(...): "Você PRECISA chamar este método com estes argumentos." (Obrigatório)

# --- 4. Verificando Quantidade de Chamadas ---

# O RSpec permite ser bem específico:
# - expect(obj).to receive(:metodo).twice          # 2 vezes
# - expect(obj).to receive(:metodo).exactly(3).times # Exatamente 3 vezes
# - expect(obj).to receive(:metodo).at_least(:once)  # Pelo menos uma vez
# - expect(obj).not_to receive(:metodo)              # NUNCA deve ser chamado

# --- 5. Quando usar Mocks? ---

# - Quando a ação é o objetivo do teste: Enviar um e-mail, disparar um log, 
#   limpar um cache ou chamar uma API externa de terceiros.
# - Para isolar dependências: Garante que o teste não envie um e-mail real a cada execução.

# --- CONCLUSÃO ---

# Mocks são essenciais para validar que o contrato entre diferentes objetos 
# está sendo respeitado. Eles não se importam com o "como" a ação é feita, 
# mas sim com o "fato" de que ela foi solicitada.
