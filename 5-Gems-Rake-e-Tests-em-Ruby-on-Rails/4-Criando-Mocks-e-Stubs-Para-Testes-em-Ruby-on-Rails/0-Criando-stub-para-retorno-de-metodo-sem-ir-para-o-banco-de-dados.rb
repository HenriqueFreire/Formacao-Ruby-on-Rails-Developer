# Criando Stub para Retorno de Método sem ir para o Banco de Dados

# O que é um Stub?
# Um Stub é um objeto que fornece respostas pré-definidas para chamadas de métodos 
# feitas durante um teste. Ao contrário de um Mock, que verifica se um método foi 
# chamado, o Stub apenas "força" um retorno específico para isolar a lógica.

# Por que usar Stubs?
# 1. Velocidade: Evita operações lentas de I/O (Banco de Dados, Redes).
# 2. Isolamento: Garante que o teste falhe por causa da lógica, não por problemas externos.
# 3. Determinismo: Força cenários difíceis (ex: erro de servidor 500 ou queda de conexão).

# --- 1. Exemplo com RSpec (O mais comum) ---

# Imagine uma classe que busca o saldo de uma conta no banco de dados.

class Usuario < Struct.new(:nome)
  def saldo_no_banco
    # Simula uma consulta lenta ao banco de dados
    sleep 5 
    1500.00
  end

  def pode_comprar?(valor)
    saldo_no_banco >= valor
  end
end

# Teste com RSpec usando STUB:
=begin
RSpec.describe Usuario do
  it "permite a compra se o saldo for suficiente (usando Stub)" do
    usuario = Usuario.new("Henrique")
    
    # Criamos o STUB: Forçamos o método saldo_no_banco a retornar 1000.00 imediatamente
    allow(usuario).to receive(:saldo_no_banco).and_return(1000.00)
    
    expect(usuario.pode_comprar?(500)).to be true
    expect(usuario.pode_comprar?(1500)).to be false
  end
end
=end

# --- 2. Exemplo com Minitest e Mocha ---

# Se estiver usando Minitest, a gem 'mocha' é a mais usada para stubs.

=begin
require 'minitest/autorun'
require 'mocha/minitest'

class TestUsuario < Minitest::Test
  def test_pode_comprar_com_stub
    usuario = Usuario.new("Henrique")
    
    # Stubbing com Mocha
    usuario.stubs(:saldo_no_banco).returns(1000.00)
    
    assert usuario.pode_comprar?(500)
  end
end
=end

# --- 3. Quando NÃO usar Stubs? ---

# - Em Testes de Integração: Onde o objetivo é justamente ver se a comunicação 
#   com o banco de dados está funcionando.
# - Em excesso: Stubbar tudo pode esconder problemas reais de arquitetura 
#   ou deixar seus testes "mentirosos" (passam no teste mas quebram na vida real).

# --- CONCLUSÃO ---

# Stubs são ferramentas poderosas para tornar seus testes de unidade ultra-rápidos 
# e focados. Ao "fingir" um retorno do banco de dados, você consegue testar todas 
# as ramificações da sua lógica de negócio em milissegundos.
