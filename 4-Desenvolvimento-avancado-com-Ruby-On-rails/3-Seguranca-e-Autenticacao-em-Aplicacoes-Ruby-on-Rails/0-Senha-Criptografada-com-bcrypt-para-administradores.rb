# Senha Criptografada com bcrypt para Administradores no Ruby on Rails

Segurança é um pilar fundamental em qualquer aplicação. No Ruby on Rails, a forma padrão e mais recomendada de armazenar senhas de forma segura é utilizando a gem `bcrypt` através do método `has_secure_password`.

## 1. O que é o bcrypt?

O `bcrypt` é uma função de hashing de senha baseada no cifrador Blowfish. Ele inclui um "salt" (sal) para proteger contra ataques de dicionário e tabelas arco-íris (rainbow tables), e é intencionalmente lento para dificultar ataques de força bruta.

---

## 2. Configuração Inicial

Para começar, você deve garantir que a gem `bcrypt` esteja no seu `Gemfile`:

```ruby
# Gemfile
gem 'bcrypt', '~> 3.1.7'
```

Após adicionar, execute `bundle install`.

---

## 3. Preparando o Banco de Dados

Para usar o `has_secure_password`, sua tabela (ex: `admins`) deve ter uma coluna chamada `password_digest`.

### Exemplo de Migration:
```ruby
class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email, null: false
      t.string :password_digest # Esta coluna armazenará a senha criptografada

      t.timestamps
    end
    add_index :admins, :email, unique: true
  end
end
```

---

## 4. Implementando no Model

No model `Admin`, basta adicionar o método `has_secure_password`. Isso adicionará automaticamente métodos para definir e autenticar senhas, além de validações de presença e confirmação.

```ruby
# app/models/admin.rb
class Admin < ApplicationRecord
  # Adiciona métodos para definir password e password_confirmation
  # Adiciona o método .authenticate(password)
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?
end
```

---

## 5. Como Funciona na Prática

### Criando um Administrador:
```ruby
admin = Admin.create(
  name: "Super Admin",
  email: "admin@example.com",
  password: "senha_segura_123",
  password_confirmation: "senha_segura_123"
)

# No banco de dados, o campo password_digest será algo como:
# "$2a$12$KIX6zth.SgZdbI.XvT5a.O..."
```

### Autenticando:
O método `authenticate` compara a senha fornecida com o hash armazenado. Se estiver correta, retorna o objeto; caso contrário, retorna `false`.

```ruby
admin = Admin.find_by(email: "admin@example.com")

if admin && admin.authenticate("senha_segura_123")
  puts "Login realizado com sucesso!"
else
  puts "Email ou senha inválidos."
end
```

---

## 6. Por que usar `has_secure_password`?

1.  **Proteção contra vazamentos**: Se o banco de dados for comprometido, as senhas reais não estarão expostas.
2.  **Facilidade**: O Rails cuida de toda a lógica de hashing e salting para você.
3.  **Segurança embutida**: Impede o armazenamento de senhas em texto puro por engano.
