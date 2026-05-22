# Aplicação da Metaprogramação para Criar Abstrações Poderosas

A metaprogramação em Ruby permite que o código escreva código, permitindo a criação de abstrações que seriam repetitivas ou impossíveis de outra forma. 
Abaixo, exploramos como criar uma abstração poderosa inspirada em ORMs (como ActiveRecord) e DSLs.

## 1. Definição Dinâmica de Atributos (Simulando attr_accessor)

Podemos usar `define_method` para criar métodos de leitura e escrita dinamicamente baseados em uma lista de campos.

```ruby
class AtributosDinamicos
  def self.mapear_campos(*campos)
    campos.each do |campo|
      # Define o getter
      define_method(campo) do
        instance_variable_get("@#{campo}")
      end

      # Define o setter
      define_method("#{campo}=") do |valor|
        instance_variable_set("@#{campo}", valor)
      end
    end
  end

  mapear_campos :nome, :email, :telefone
end

usuario = AtributosDinamicos.new
usuario.nome = "Guilherme"
puts "Nome do usuário: #{usuario.nome}"
```

## 2. Capturando Métodos Inexistentes com method_missing

O `method_missing` permite que um objeto responda a métodos que não foram explicitamente definidos, ideal para criar "Dynamic Finders".

```ruby
class BuscadorDinamico
  def method_missing(nome_metodo, *args)
    if nome_metodo.to_s.start_with?("buscar_por_")
      campo = nome_metodo.to_s.gsub("buscar_por_", "")
      puts "Executando consulta SQL: SELECT * FROM tabela WHERE #{campo} = '#{args.first}'"
    else
      super
    end
  end

  def respond_to_missing?(nome_metodo, include_private = false)
    nome_metodo.to_s.start_with?("buscar_por_") || super
  end
end

busca = BuscadorDinamico.new
busca.buscar_por_nome("João")
busca.buscar_por_email("joao@email.com")
```

## 3. Criando uma DSL (Domain Specific Language) com class_eval

Podemos usar `class_eval` para injetar comportamentos em classes que herdam de uma classe base ou que incluem um módulo.

```ruby
module Validador
  def validar_presenca_de(*atributos)
    atributos.each do |attr|
      define_method("validar_#{attr}") do
        valor = instance_variable_get("@#{attr}")
        puts "Validando #{attr}: #{valor ? 'OK' : 'ERRO - Vazio'}"
      end
    end
  end
end

class Produto
  extend Validador
  
  attr_accessor :nome, :preco
  validar_presenca_de :nome, :preco

  def initialize(nome, preco)
    @nome = nome
    @preco = preco
  end
end

p = Produto.new("Teclado", nil)
p.validar_nome
p.validar_preco
```

## Conclusão

Essas técnicas permitem:
- **Redução de boilerplate:** Menos código repetitivo.
- **Flexibilidade:** O código se adapta a diferentes contextos sem mudanças estruturais pesadas.
- **Expressividade:** Cria interfaces (APIs internas) muito mais amigáveis e legíveis.
