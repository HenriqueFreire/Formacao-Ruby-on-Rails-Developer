# Compreensão da Importância dos Testes em Desenvolvimento de Software

# O que são testes de software?
# Testes são processos que verificam se o software funciona conforme o esperado. 
# No Ruby on Rails, a cultura de testes é muito forte, sendo parte essencial do fluxo de desenvolvimento.

# Por que os testes são importantes?

# 1. Confiança para Refatorar
# Com uma boa suíte de testes, você pode alterar o código interno (refatorar) 
# sem medo de quebrar funcionalidades existentes.

# 2. Prevenção de Regressões
# Garante que novos bugs não sejam introduzidos ao adicionar novas funcionalidades.

# 3. Documentação Viva
# Os testes descrevem como o código deve se comportar, servindo como uma 
# documentação técnica sempre atualizada.

# 4. Economia de Tempo e Custo
# Encontrar um bug durante o desenvolvimento é muito mais barato do que 
# encontrá-lo em produção.

# --- EXEMPLO PRÁTICO ---

# Imagine uma classe que calcula descontos:

class CalculadoraDeDesconto
  def calcular(valor, porcentagem)
    return 0 if valor <= 0
    valor * (porcentagem / 100.0)
  end
end

# Sem testes, teríamos que rodar o programa manualmente para verificar cada caso.
# Com testes (usando Minitest, que vem no Ruby), fazemos assim:

require 'minitest/autorun'

class TestCalculadoraDeDesconto < Minitest::Test
  def setup
    @calculadora = CalculadoraDeDesconto.new
  end

  def test_deve_calcular_desconto_corretamente
    resultado = @calculadora.calcular(100, 10)
    assert_equal 10.0, resultado
  end

  def test_deve_retornar_zero_para_valor_negativo
    resultado = @calculadora.calcular(-50, 10)
    assert_equal 0, resultado
  end

  def test_deve_retornar_zero_para_valor_zero
    resultado = @calculadora.calcular(0, 10)
    assert_equal 0, resultado
  end
end

# Ao executar este arquivo, o Minitest validará automaticamente todos os cenários.
# Isso garante que, se alguém mudar a lógica de 'calcular' no futuro, 
# os testes avisarão imediatamente se algo quebrar.
