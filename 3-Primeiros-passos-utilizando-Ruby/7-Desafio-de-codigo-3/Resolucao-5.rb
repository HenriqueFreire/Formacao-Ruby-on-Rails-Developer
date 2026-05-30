require 'singleton'

# Classe que representa o modelo de Usuário
class User
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end

# Gerenciador de Usuários implementando o padrão Singleton
class UserManager
  include Singleton

  def initialize
    @users = []
  end

  # Adiciona um novo usuário gerando um ID incremental baseado na ordem de inserção
  def add_user(name)
    id = @users.length + 1
    new_user = User.new(id, name)
    @users << new_user
  end

  # Lista todos os usuários seguindo o formato: "ID - Nome"
  def list_users
    @users.each do |user|
      puts "#{user.id} - #{user.name}"
    end
  end
end

# Ponto de entrada do programa
if __FILE__ == $0
  # Lê a quantidade de usuários
  input_quantity = gets
  exit if input_quantity.nil?
  
  quantity = input_quantity.to_i
  manager = UserManager.instance

  # Processa as entradas de nomes
  quantity.times do
    name = gets.to_s.chomp
    manager.add_user(name)
  end

  # Exibe a lista final
  manager.list_users
end
