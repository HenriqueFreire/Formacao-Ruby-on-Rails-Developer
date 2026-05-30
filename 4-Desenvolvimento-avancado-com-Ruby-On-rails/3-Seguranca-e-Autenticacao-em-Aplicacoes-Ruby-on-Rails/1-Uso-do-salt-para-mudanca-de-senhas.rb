# Uso do Salt para Mudança de Senhas no Ruby on Rails

No contexto de criptografia de senhas, o **salt** (sal) é uma sequência de caracteres aleatórios que é adicionada à senha antes de ela passar pelo processo de hashing. O `bcrypt`, utilizado pelo Rails via `has_secure_password`, gerencia isso de forma automática e transparente.

## 1. O que é o Salt?

O Salt resolve um problema crítico: se dois usuários escolherem a mesma senha (ex: "123456"), o hash resultante seria idêntico sem o salt. Isso permitiria ataques de **Tabelas Arco-Íris** (Rainbow Tables), onde atacantes pré-calculam hashes de senhas comuns.

Com o salt:
1.  Cada usuário recebe um salt único e aleatório.
2.  O salt é combinado com a senha.
3.  O hash é gerado a partir dessa combinação.
4.  Mesmo senhas iguais geram hashes completamente diferentes.

---

## 2. Como o bcrypt armazena o Salt?

Diferente de sistemas antigos que guardavam o salt em uma coluna separada, o `bcrypt` inclui o salt dentro da própria string gerada no `password_digest`.

Uma string do `bcrypt` segue este formato:
`$2a$12$KIX6zth.SgZdbI.XvT5a.O...`
- `$2a$`: O algoritmo utilizado.
- `$12$`: O custo (cost) ou fator de trabalho.
- `KIX6zth.SgZdbI.XvT5a.O...`: Os primeiros 22 caracteres após o custo são o **Salt**. O restante é o hash da senha.

---

## 3. Exemplo Prático com a Gem BCrypt

Você pode testar isso no console do Rails (`rails c`):

```ruby
require 'bcrypt'

# Gerando dois hashes para a MESMA senha
senha = "minha_senha_123"

hash1 = BCrypt::Password.create(senha)
hash2 = BCrypt::Password.create(senha)

puts hash1 # Ex: $2a$12$jR8.g/XWvL6...
puts hash2 # Ex: $2a$12$V9kP1Q7R5F2...

# Os hashes são diferentes porque os salts gerados automaticamente foram diferentes!
```

---

## 4. Mudança de Senha e o Salt

Sempre que um usuário altera sua senha no Rails, o `bcrypt` gera um **novo salt**.

```ruby
admin = Admin.find_by(email: "admin@example.com")
digest_antigo = admin.password_digest

# Alterando a senha (mesmo que fosse para a mesma senha anterior)
admin.update(password: "nova_senha_456")
digest_novo = admin.password_digest

if digest_antigo != digest_novo
  puts "O digest mudou completamente devido ao novo salt!"
end
```

### Por que isso é importante na mudança de senha?
Mesmo que um usuário mude de "senha1" para "senha2" e depois volte para "senha1", o hash será diferente da primeira vez. Isso garante que:
- O histórico de hashes vazados não sirva para prever hashes futuros.
- Atacantes não consigam identificar padrões de troca de senha.

## 5. Resumo
O uso do salt pelo `has_secure_password` garante que cada senha armazenada seja única a nível de bits, proporcionando uma camada robusta de segurança contra ataques de força bruta e dicionário.
