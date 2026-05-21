# Visibilidade de Métodos em Ruby: Public, Private e Protected

# O encapsulamento é um dos pilares da POO. No Ruby, controlamos o acesso 
# aos métodos para esconder detalhes de implementação e proteger o estado do objeto.

# --- 1. Métodos Públicos (Public) ---
# São acessíveis de qualquer lugar, por qualquer um que tenha a instância do objeto.
# Por padrão, todos os métodos em Ruby são públicos (exceto o 'initialize').

class ServicoEmail
  def enviar_email(mensagem)
    puts "Preparando para enviar..."
    formatar_mensagem(mensagem) # Chama um método privado internamente
    conectar_servidor          # Chama outro método privado
    puts "E-mail enviado com sucesso: #{mensagem}"
  end

  # --- 2. Métodos Privados (Private) ---
  # Só podem ser chamados de dentro da própria classe. 
  # Não podem ser chamados com um receptor explícito (ex: objeto.metodo_privado falha).

  private

  def formatar_mensagem(msg)
    puts "Formatando mensagem para HTML..."
  end

  def conectar_servidor
    puts "Autenticando no servidor SMTP..."
  end
end

servico = ServicoEmail.new
servico.enviar_email("Olá, Ruby!")
# servico.formatar_mensagem("Erro") # ERRO: NoMethodError (private method called)


# --- 3. Métodos Protegidos (Protected) ---
# Semelhantes aos privados, mas com uma diferença crucial: 
# Um objeto pode chamar um método 'protected' de OUTRO objeto da mesma classe.
# Útil para comparações entre instâncias.

class Usuario
  attr_reader :nome
  
  def initialize(nome, senha)
    @nome = nome
    @senha = senha
  end

  def comparar_senha(outro_usuario)
    # Aqui podemos acessar @senha de outro objeto porque o método é protected
    if self.senha_encriptada == outro_usuario.senha_encriptada
      puts "As senhas são iguais!"
    else
      puts "As senhas são diferentes."
    end
  end

  protected

  def senha_encriptada
    # Simulação de uma senha protegida
    @senha.reverse 
  end
end

user1 = Usuario.new("Alice", "secret123")
user2 = Usuario.new("Bob", "secret123")

user1.comparar_senha(user2) # Funciona!
# puts user1.senha_encriptada # ERRO: continua inacessível de fora da classe


# --- Resumo de Visibilidade ---

# | Nível     | Onde pode ser chamado?                                     |
# |-----------|------------------------------------------------------------|
# | Public    | Em qualquer lugar.                                         |
# | Private   | Apenas internamente (sem usar 'self.' ou 'objeto.').       |
# | Protected | Internamente e por outras instâncias da mesma classe/sub.  |


# --- Dica de Ruby Moderno ---
# Você também pode definir a visibilidade de um método específico assim:
# def meu_metodo; end
# private :meu_metodo
