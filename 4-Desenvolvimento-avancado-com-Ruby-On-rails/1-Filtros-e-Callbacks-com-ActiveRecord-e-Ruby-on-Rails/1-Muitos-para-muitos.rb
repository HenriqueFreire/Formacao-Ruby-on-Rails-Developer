# Relacionamentos Muitos-para-Muitos no ActiveRecord

# No Ruby on Rails, existem duas formas principais de implementar relacionamentos muitos-para-muitos:
# 1. has_many :through
# 2. has_and_belongs_to_many (HABTM)

# --- 1. has_many :through ---
# Esta é a abordagem mais recomendada quando você precisa de um modelo intermediário
# (join model) que pode conter atributos extras ou validações.

# Exemplo: Médicos (Physicians) e Pacientes (Patients) através de Consultas (Appointments).

class Physician < ApplicationRecord
  has_many :appointments
  has_many :patients, through: :appointments
end

class Appointment < ApplicationRecord
  belongs_to :physician
  belongs_to :patient
  # Aqui você pode ter campos extras como :data_consulta, :diagnostico, etc.
end

class Patient < ApplicationRecord
  has_many :appointments
  has_many :physicians, through: :appointments
end

# Uso Prático:
# medico = Physician.create(name: "Dr. House")
# paciente = Patient.create(name: "John Doe")
# consulta = Appointment.create(physician: medico, patient: paciente, appointment_date: Time.now)

# medico.patients # Retorna os pacientes do médico
# paciente.physicians # Retorna os médicos do paciente

# --- 2. has_and_belongs_to_many (HABTM) ---
# Esta abordagem é mais simples e não requer um modelo para a tabela intermediária.
# É usada quando você NÃO precisa armazenar informações extras na tabela de ligação.

# Exemplo: Assembleias (Assemblies) e Peças (Parts).

class Assembly < ApplicationRecord
  has_and_belongs_to_many :parts
end

class Part < ApplicationRecord
  has_and_belongs_to_many :assemblies
end

# Observação: Para HABTM, você deve criar uma tabela de migração manual chamada `assemblies_parts`
# que contenha apenas as chaves estrangeiras `assembly_id` e `part_id`.

# --- Quando usar cada um? ---

# - Use `has_many :through` se:
#   - Você precisa validar os dados na tabela intermediária.
#   - Você precisa de atributos extras na tabela intermediária (ex: data, observações).
#   - Você quer tratar a relação como um objeto independente.

# - Use `has_and_belongs_to_many` se:
#   - A relação é muito simples e você nunca precisará de nada além dos IDs.
#   - Você quer economizar a criação de um arquivo de modelo extra.

# Dica: Na dúvida, prefira `has_many :through`, pois ele é mais flexível para mudanças futuras.
