# Outros Pontos Importantes em Metaprogramação

# Além de definir métodos dinamicamente, Ruby oferece ferramentas para manipular
# o escopo de execução e responder corretamente a introspecções do sistema.

# --- 1. instance_eval vs class_eval ---
# Esses métodos permitem "entrar" no escopo de um objeto ou classe para executar código.

class Pessoa; end

pessoa = Pessoa.new

# instance_eval: Executa código no contexto da INSTÂNCIA (pode acessar variáveis @)
pessoa.instance_eval do
  @nome = "Henrique"
  def saudar
    "Olá, eu sou #{@nome}!"
  end
end

puts pessoa.saudar

# class_eval: Executa código no contexto da CLASSE (adiciona métodos a todas as instâncias)
Pessoa.class_eval do
  def rir
    "Haha!"
  end
end

puts Pessoa.new.rir


# --- 2. respond_to_missing? ---
# SEMPRE que usar 'method_missing', você deve implementar 'respond_to_missing?'.
# Isso garante que métodos como 'respond_to?' e 'method' funcionem corretamente.

class ConsultorMagico
  def method_missing(nome, *args)
    if nome.to_s.end_with?("_pergunta")
      "Eu não sei a resposta para #{nome}..."
    else
      super
    end
  end

  def respond_to_missing?(nome, incluir_privado = false)
    nome.to_s.end_with?("_pergunta") || super
  end
end

magico = ConsultorMagico.new
puts "Ele responde a 'clima_pergunta'? #{magico.respond_to?(:clima_pergunta)}"


# --- 3. eval (Execução de Strings) ---
# O 'eval' interpreta uma string como código Ruby puro.
# CUIDADO: É perigoso se usado com inputs de usuários (Risco de Injeção de Código).

codigo = "2 + 2 * 10"
puts "Resultado do eval: #{eval(codigo)}"


# --- 4. Hooks (Ganchos de Ciclo de Vida) ---
# Métodos especiais que o Ruby chama quando eventos de metaprogramação ocorrem.

module MeuModulo
  def self.included(base)
    puts "O módulo #{self} foi incluído na classe #{base}!"
  end

  def self.extended(objeto)
    puts "O módulo #{self} estendeu o objeto #{objeto}!"
  end
end

class Teste
  include MeuModulo # Dispara self.included
end


# --- 5. Constantes Dinâmicas ---
# Você pode acessar e definir constantes usando strings ou símbolos.

module AppConfig
  VERSAO = "2.5.1"
end

nome_constante = "VERSAO"
puts "Versão via const_get: #{AppConfig.const_get(nome_constante)}"


# --- Resumo ---
# - instance_eval/class_eval: Mudam o 'self' para injetar comportamento.
# - respond_to_missing?: Mantém a integridade do objeto ao usar métodos fantasmas.
# - Hooks: Permitem reagir a inclusões de módulos ou heranças em tempo real.
# - eval: Poder total (e perigoso) para executar strings como código.
