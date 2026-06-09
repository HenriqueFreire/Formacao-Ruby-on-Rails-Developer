# Criando Testes a partir de uma Classe com IA

# O uso de Inteligência Artificial (como Gemini, ChatGPT ou GitHub Copilot) transformou 
# a maneira como escrevemos testes. A IA é excelente para gerar "boilerplate" e 
# identificar casos de borda (edge cases) que poderíamos esquecer.

# --- 1. O Fluxo de Trabalho com IA ---

# 1. Forneça o código da classe para a IA.
# 2. Peça para gerar testes (especificando o framework: Minitest ou RSpec).
# 3. Revise e valide os testes gerados (A IA pode cometer erros de lógica ou alucinar métodos).

# --- 2. Exemplo Prático: Classe de Negócio ---

class ServicoDeAssinatura
  def initialize(plano, ativo)
    @plano = plano
    @ativo = ativo
  end

  def pode_acessar_conteudo_premium?
    @ativo && (@plano == 'premium' || @plano == 'enterprise')
  end

  def dias_de_teste_restantes(data_criacao)
    # Regra: 7 dias de teste grátis
    hoje = Date.today
    expiracao = data_criacao + 7
    [0, (expiracao - hoje).to_i].max
  end
end

# --- 3. Prompt Exemplo para a IA ---

# "Gere uma suíte de testes em RSpec para a classe ServicoDeAssinatura acima. 
# Garanta que todos os planos sejam testados e inclua casos para usuários inativos. 
# Use Mocks para a data atual se necessário."

# --- 4. Resultado Gerado pela IA (Exemplo) ---

=begin
require 'rspec'
require 'date'

RSpec.describe ServicoDeAssinatura do
  describe "#pode_acessar_conteudo_premium?" do
    it "permite acesso para plano premium ativo" do
      servico = ServicoDeAssinatura.new('premium', true)
      expect(servico.pode_acessar_conteudo_premium?).to be true
    end

    it "nega acesso para plano básico mesmo ativo" do
      servico = ServicoDeAssinatura.new('basico', true)
      expect(servico.pode_acessar_conteudo_premium?).to be false
    end

    it "nega acesso para plano premium inativo" do
      servico = ServicoDeAssinatura.new('premium', false)
      expect(servico.pode_acessar_conteudo_premium?).to be false
    end
  end

  describe "#dias_de_teste_restantes" do
    it "retorna 7 dias se a conta foi criada hoje" do
      servico = ServicoDeAssinatura.new('basico', true)
      expect(servico.dias_de_teste_restantes(Date.today)).to eq(7)
    end

    it "retorna 0 dias se a conta foi criada há 10 dias" do
      servico = ServicoDeAssinatura.new('basico', true)
      expect(servico.dias_de_teste_restantes(Date.today - 10)).to eq(0)
    end
  end
end
=end

# --- 5. Benefícios e Cuidados ---

# Benefícios:
# - Velocidade: Cria dezenas de testes em segundos.
# - Cobertura: Sugere testes para valores nulos, negativos ou formatos inesperados.
# - Aprendizado: Ajuda a entender a sintaxe de frameworks novos (ex: migrando para RSpec).

# Cuidados:
# - Verificação Humana: A IA não entende as nuances profundas do seu negócio.
# - Manutenção: Testes gerados por IA podem ser redundantes ou frágeis.
# - Segurança: Nunca envie dados sensíveis ou segredos comerciais para IAs públicas.

# --- CONCLUSÃO ---

# A IA é uma ferramenta de produtividade, não um substituto para o pensamento crítico. 
# Use-a para acelerar o processo, mas a responsabilidade pela qualidade do software 
# continua sendo do desenvolvedor.
