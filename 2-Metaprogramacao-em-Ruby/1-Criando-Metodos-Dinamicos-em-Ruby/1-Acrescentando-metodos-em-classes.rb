# Metaprogramação: Acrescentando Métodos em Classes Dinamicamente

# Diferente de adicionar métodos a uma única instância, aqui aprenderemos como 
# modificar uma CLASSE inteira em tempo de execução. Isso afetará todas as 
# instâncias já existentes e as que ainda serão criadas.

class Pessoa
  def falar
    "Olá!"
  end
end

p1 = Pessoa.new

# --- 1. Reabertura de Classe (Open Classes) ---
# Em Ruby, você pode simplesmente "reabrir" a classe a qualquer momento.

class Pessoa
  def andar
    "*Andando...*"
  end
end

puts p1.andar # Mesmo p1 tendo sido criado antes, ele agora sabe andar!


# --- 2. Usando class_eval ---
# O 'class_eval' é a forma mais poderosa de adicionar métodos a uma classe 
# dinamicamente, especialmente quando você não tem acesso direto ao código da classe
# ou quer definir métodos baseados em variáveis.

String.class_eval do
  def rir
    "Hahaha! Eu sou a string: #{self}"
  end
end

puts "Ruby".rir


# --- 3. Definindo Métodos de Classe Dinamicamente ---
# Podemos usar 'instance_eval' sobre a própria Classe (pois Classes são objetos)
# ou a sintaxe 'self.' dentro de um class_eval.

Pessoa.instance_eval do
  def sugerir_nome
    "Sugerimos o nome: Henrique"
  end
end

puts Pessoa.sugerir_nome


# --- 4. Por que usar isso? ---
# 1. Monkey Patching: Adicionar funcionalidades a bibliotecas de terceiros ou ao próprio Ruby.
# 2. Plugins: Frameworks usam isso para injetar comportamentos em classes do usuário.
# 3. DRY: Se você precisa do mesmo método em várias classes, pode injetá-lo dinamicamente.

# --- CUIDADO ---
# Reabrir classes nativas (como String, Array, Hash) deve ser feito com cautela extrema. 
# Isso pode causar efeitos colaterais em outras partes do seu código ou em Gems que 
# você utiliza.

# Resumo:
# - 'class Classe' abre a classe para novas definições.
# - 'class_eval' permite injeção dinâmica de comportamento.
# - Modificar a classe afeta TODO o ecossistema daquela classe no sistema.
