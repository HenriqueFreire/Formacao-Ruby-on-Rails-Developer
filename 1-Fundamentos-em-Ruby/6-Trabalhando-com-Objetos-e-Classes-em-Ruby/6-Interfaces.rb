# Interfaces e Duck Typing em Ruby

# Ao contrário de linguagens como Java ou C#, o Ruby NÃO possui a palavra-chave 'interface'.
# O Ruby utiliza um conceito chamado Duck Typing e o uso de Módulos para atingir os 
# mesmos objetivos de design.

# --- 1. Duck Typing ---
# "Se caminha como um pato e grasna como um pato, então é um pato."
# Em Ruby, não importa o TIPO (classe) do objeto, mas sim se ele RESPONDE ao método chamado.

class Pato
  def quack
    "Quack! Quack!"
  end
end

class Pessoa
  def quack
    "Eu estou imitando um pato: Quack!"
  end
end

def fazer_quack(objeto)
  # Não verificamos se objeto é da classe Pato. 
  # Apenas chamamos o método. Se ele existir, funciona.
  puts objeto.quack
end

fazer_quack(Pato.new)
fazer_quack(Pessoa.new)


# --- 2. Simulando Interfaces com NotImplementedError ---
# Uma forma comum de criar um "contrato" em Ruby é definir uma classe base 
# onde os métodos lançam uma exceção se não forem sobrescritos.

class RepositorioBase
  def salvar(dados)
    raise NotImplementedError, "Você deve implementar o método 'salvar' na sua classe!"
  end
end

class RepositorioArquivo < RepositorioBase
  def salvar(dados)
    puts "Salvando dados no arquivo TXT..."
  end
end

repo = RepositorioArquivo.new
repo.salvar({nome: "Teste"})

# repo_base = RepositorioBase.new
# repo_base.salvar({}) # ERRO: NotImplementedError


# --- 3. Módulos como Interfaces (Mixins) ---
# Módulos são a forma mais idiomática de garantir que diferentes classes 
# compartilhem uma mesma interface de comportamento.

module Autenticavel
  def login(usuario, senha)
    puts "Realizando login para #{usuario}..."
  end

  def logout
    puts "Saindo do sistema..."
  end
end

class Admin
  include Autenticavel # "Herda" os métodos do módulo
end

class Cliente
  include Autenticavel
end

# Ambos agora seguem a "interface" Autenticavel
Admin.new.login("admin", "123")
Cliente.new.login("cliente_01", "456")


# --- 4. Por que isso é importante? ---
# 1. Flexibilidade: Você pode trocar uma classe por outra facilmente, 
#    desde que elas implementem os mesmos métodos.
# 2. Desacoplamento: Seu código depende de comportamentos, não de nomes de classes.
# 3. Reuso: Módulos permitem injetar comportamentos em classes totalmente diferentes.

# Resumo:
# - Ruby não tem interfaces formais.
# - Duck Typing é o padrão: foque no que o objeto FAZ.
# - Use NotImplementedError para forçar a implementação em subclasses.
# - Use Módulos para padronizar comportamentos entre classes distintas.
