# Desenvolvimento de Código mais Flexível e Reutilizável com Metaprogramação

A metaprogramação transforma Ruby em uma ferramenta poderosa para criar bibliotecas e componentes que podem ser reutilizados em diferentes partes de um sistema sem a necessidade de duplicar lógica.

## 1. Hooks de Ciclo de Vida (`included`, `extended`)

O uso de `included` permite que um módulo injete métodos de classe e de instância ao mesmo tempo, criando um pacote completo de funcionalidades reutilizáveis.

```ruby
module Auditoria
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def auditar_alteracoes
      puts "Configurando auditoria para a classe #{self}..."
      # Aqui poderíamos definir callbacks dinamicamente
    end
  end

  def log_evento(mensagem)
    puts "[Auditoria - #{Time.now}] #{self.class}: #{mensagem}"
  end
end

class Pedido
  include Auditoria
  auditar_alteracoes
end

pedido = Pedido.new
pedido.log_evento("Pedido criado com sucesso.")
```

## 2. Despacho Dinâmico com `send`

O método `send` permite chamar métodos dinamicamente baseados em strings ou símbolos, o que torna o código muito flexível para lidar com diferentes tipos de entrada ou configurações.

```ruby
class ProcessadorDePagamento
  def pagar_cartao(valor)
    puts "Processando R$ #{valor} no cartão de crédito."
  end

  def pagar_boleto(valor)
    puts "Gerando boleto de R$ #{valor}."
  end

  def processar(metodo, valor)
    metodo_formatado = "pagar_#{metodo}"
    if respond_to?(metodo_formatado)
      send(metodo_formatado, valor)
    else
      puts "Método de pagamento '#{metodo}' não suportado."
    end
  end
end

processador = ProcessadorDePagamento.new
processador.processar("cartao", 150.00)
processador.processar("boleto", 80.00)
```

## 3. Criação de Proxies e Wrappers Reutilizáveis

Podemos criar uma classe "Wrapper" que adiciona funcionalidades a qualquer objeto de forma genérica usando `method_missing` e `send`.

```ruby
class DecoradorSilencioso
  def initialize(objeto)
    @objeto = objeto
  end

  def method_missing(metodo, *args, &bloco)
    puts "Tentando executar: #{metodo}..."
    begin
      @objeto.send(metodo, *args, &bloco)
    rescue => e
      puts "Erro silenciado ao executar #{metodo}: #{e.message}"
    end
  end
end

class Calculadora
  def dividir(a, b)
    a / b
  end
end

calc_segura = DecoradorSilencioso.new(Calculadora.new)
puts calc_segura.dividir(10, 2)
calc_segura.dividir(10, 0) # Não quebra a execução
```

## Conclusão

Ao utilizar essas técnicas, o desenvolvedor consegue:
- **Desacoplar componentes:** O código não precisa conhecer todos os detalhes em tempo de compilação.
- **Aumentar a DRY (Don't Repeat Yourself):** Funcionalidades transversais (como log e auditoria) são facilmente compartilhadas.
- **Criar sistemas plugáveis:** Novas funcionalidades podem ser adicionadas apenas incluindo módulos ou passando novos parâmetros de configuração.
