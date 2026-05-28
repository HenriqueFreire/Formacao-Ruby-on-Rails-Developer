# Callbacks no ActiveRecord

# Callbacks são ganchos (hooks) no ciclo de vida de um objeto do Active Record 
# que permitem executar código em momentos específicos, como antes de salvar, 
# após criar ou antes de validar um registro.

# --- Ciclo de Vida Comum (Simplificado) ---
# 1. Before Validation
# 2. After Validation
# 3. Before Save
# 4. Around Save
# 5. Before Create / Before Update
# 6. Around Create / Around Update
# 7. After Create / After Update
# 8. After Save
# 9. After Commit / After Rollback

# --- Exemplos Práticos ---

class User < ApplicationRecord
  # 1. before_validation: Útil para formatar dados antes de serem validados.
  before_validation :normalize_email

  # 2. before_save: Executado antes de criar ou atualizar.
  before_save :set_default_status

  # 3. after_create: Executado logo após o registro ser inserido no banco.
  after_create :send_welcome_email

  # 4. after_commit: Executado após a transação do banco ser finalizada. 
  # É o lugar ideal para jobs em segundo plano ou interações com APIs externas.
  after_commit :log_user_activity, on: :create

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end

  def set_default_status
    self.status ||= "active"
  end

  def send_welcome_email
    puts "Enviando e-mail de boas-vindas para #{self.email}..."
    # UserMailer.welcome_email(self).deliver_later
  end

  def log_user_activity
    puts "Usuário #{self.id} criado e persistido com sucesso!"
  end
end

# --- Condicionais em Callbacks ---
# Você pode executar callbacks apenas se uma condição for atendida.

class Order < ApplicationRecord
  # Executa apenas se o status mudar para 'pago'
  after_update :notify_shipping, if: :saved_change_to_paid?

  def saved_change_to_paid?
    status == "paid" && saved_change_to_status?
  end

  def notify_shipping
    puts "Notificando setor de logística para o pedido ##{id}..."
  end
end

# --- Boas Práticas ---
# 1. Mantenha os callbacks simples: Se a lógica for complexa, use Service Objects.
# 2. Cuidado com efeitos colaterais: Evite callbacks que alteram outros modelos se possível.
# 3. Use after_commit para ações externas: Isso evita que e-mails sejam enviados 
#    se a transação do banco de dados falhar (Rollback).
# 4. Saiba pular callbacks: Métodos como `update_column`, `update_all`, `touch` 
#    e `delete` pulam os callbacks do ActiveRecord.
