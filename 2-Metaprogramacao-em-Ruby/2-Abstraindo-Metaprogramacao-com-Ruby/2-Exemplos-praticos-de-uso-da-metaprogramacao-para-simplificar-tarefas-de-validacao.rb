# Exemplos Práticos: Simplificando Validações com Metaprogramação

A metaprogramação é amplamente utilizada para criar sistemas de validação elegantes, como os encontrados no ActiveRecord. Em vez de escrever métodos manuais de validação para cada atributo, podemos declarar o que queremos validar.

## 1. Criando um Motor de Validação Genérico

Podemos usar um módulo para rastrear quais validações devem ser executadas em uma classe.

```ruby
module Validavel
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validacoes
      @validacoes ||= []
    end

    def validar_presenca(*atributos)
      atributos.each do |attr|
        validacoes << { atributo: attr, tipo: :presenca }
      end
    end

    def validar_tamanho(atributo, opcoes = {})
      validacoes << { atributo: atributo, tipo: :tamanho, opcoes: opcoes }
    end
  end

  def erros
    @erros ||= []
  end

  def valido?
    @erros = []
    self.class.validacoes.each do |v|
      valor = send(v[:atributo])
      
      case v[:tipo]
      when :presenca
        if valor.nil? || (valor.is_a?(String) && valor.strip.empty?)
          erros << "O campo #{v[:atributo]} não pode estar vazio"
        end
      when :tamanho
        min = v[:opcoes][:minimo]
        if valor.nil? || valor.to_s.length < min
          erros << "O campo #{v[:atributo]} deve ter no mínimo #{min} caracteres"
        end
      end
    end
    erros.empty?
  end
end

class Usuario
  include Validavel
  attr_accessor :nome, :senha

  validar_presenca :nome
  validar_tamanho :senha, minimo: 6

  def initialize(nome, senha)
    @nome = nome
    @senha = senha
  end
end

# Teste 1: Inválido
u1 = Usuario.new("", "123")
unless u1.valido?
  puts "Erros de u1: #{u1.erros.join(', ')}"
end

# Teste 2: Válido
u2 = Usuario.new("Guilherme", "senha_segura123")
if u2.valido?
  puts "Usuário u2 é válido!"
end
```

## 2. Validações com Tipagem Dinâmica

Podemos usar metaprogramação para garantir que um atributo pertença a um tipo específico.

```ruby
module ValidadorDeTipo
  def validar_tipo(atributo, tipo_esperado)
    define_method("validar_#{atributo}_tipo") do
      valor = instance_variable_get("@#{atributo}")
      unless valor.is_a?(tipo_esperado)
        puts "AVISO: #{atributo} deveria ser #{tipo_esperado}, mas é #{valor.class}"
      end
    end
  end
end

class ContaBancaria
  extend ValidadorDeTipo
  attr_accessor :saldo

  validar_tipo :saldo, Numeric

  def initialize(saldo)
    @saldo = saldo
    validar_saldo_tipo
  end
end

ContaBancaria.new(100)    # OK
ContaBancaria.new("100")  # Exibe aviso
```

## Conclusão

Esses exemplos mostram que a metaprogramação permite:
- **Declaratividade:** Você diz *o que* validar, não *como* validar repetidamente.
- **Centralização:** A lógica de validação reside em um único lugar (o módulo), facilitando manutenções.
- **Limpeza:** O código das classes de negócio (como `Usuario`) fica focado nos dados e não em algoritmos de validação.
