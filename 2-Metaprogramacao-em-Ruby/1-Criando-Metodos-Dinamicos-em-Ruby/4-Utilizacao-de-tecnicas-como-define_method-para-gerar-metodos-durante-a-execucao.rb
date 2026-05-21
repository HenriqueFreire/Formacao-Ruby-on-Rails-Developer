# Geração de Métodos Dinâmicos com define_method

# O 'define_method' é um método privado da classe Module que permite definir 
# métodos de instância programaticamente. É mais seguro e rápido que usar 'eval'.

class Notificador
  # --- 1. Criando métodos a partir de uma lista ---
  # Imagine que queremos métodos para diferentes tipos de alertas.

  TIPOS = [:email, :sms, :push, :whatsapp]

  TIPOS.each do |tipo|
    # define_method recebe o nome do método (símbolo ou string)
    # e um bloco que será o corpo do método.
    define_method("enviar_#{tipo}") do |mensagem|
      puts "Enviando [#{tipo.upcase}]: #{mensagem}"
    end
  end
end

notificador = Notificador.new
notificador.enviar_email("Olá por e-mail!")
notificador.enviar_whatsapp("Olá pelo Zap!")


# --- 2. Captura de Escopo (Closures) ---
# Uma grande vantagem do define_method é que o bloco captura as variáveis 
# do escopo onde foi definido.

class GeradorDeTags
  def self.criar_tag(nome_tag)
    # Aqui, o valor de 'nome_tag' fica "preso" dentro do método definido.
    define_method(nome_tag) do |conteudo|
      "<#{nome_tag}>#{conteudo}</#{nome_tag}>"
    end
  end
end

GeradorDeTags.criar_tag(:titulo)
GeradorDeTags.criar_tag(:paragrafo)

gerador = GeradorDeTags.new
puts gerador.titulo("Metaprogramação em Ruby")
puts gerador.paragrafo("Este método foi gerado dinamicamente.")


# --- 3. Criando métodos com argumentos variáveis ---

class Configurador
  def self.mapear_propriedades(*nomes)
    nomes.each do |nome|
      define_method(nome) do |valor = nil|
        if valor
          instance_variable_set("@#{nome}", valor)
        else
          instance_variable_get("@#{nome}")
        end
      end
    end
  end
end

class AppConfig < Configurador
  mapear_propriedades :versao, :ambiente, :debug
end

app = AppConfig.new
app.versao("2.0") # Funciona como setter
puts "Ambiente: #{app.ambiente("Produção")}" # Funciona como getter/setter


# --- 4. Por que usar define_method? ---
# 1. DRY (Don't Repeat Yourself): Evita escrever métodos quase idênticos manualmente.
# 2. Performance: É processado apenas uma vez na definição da classe, sendo mais 
#    rápido que o 'method_missing' (que é avaliado a cada chamada).
# 3. Legibilidade: Os métodos gerados aparecem em '.instance_methods', facilitando o debug.

# Resumo:
# - define_method permite transformar dados em comportamento.
# - Ele é um método de CLASSE (chamado dentro do corpo da classe ou class_eval).
# - É a ferramenta preferida para criar APIs flexíveis e limpas.
