# Verificando Dados Cadastrados no Servidor

Após realizar o deploy e rodar as migrações, é comum precisarmos verificar se os dados foram inseridos corretamente ou debugar algum comportamento inesperado diretamente no servidor de produção.

## 1. Utilizando o Rails Console (A forma mais poderosa)

O `rails console` permite interagir com os modelos da sua aplicação e o banco de dados de produção usando a sintaxe Ruby.

### Acessando o Console:
```bash
# No seu servidor VPS
rails console -e production

# No Heroku
heroku run rails console

# No Docker
docker-compose exec web rails console
```

### Exemplos de Verificação:

```ruby
# Contar quantos administradores existem
Admin.count

# Buscar o último administrador cadastrado
admin = Admin.last
puts "Nome: #{admin.name}, Email: #{admin.email}"

# Verificar se um email específico existe
Admin.exists?(email: 'admin@sistema.com')

# Listar todos os nomes de categorias
Category.pluck(:name)
```

## 2. Utilizando o Banco de Dados Diretamente (SQL)

Às vezes, é necessário rodar queries SQL puras para verificar índices ou estruturas que o ActiveRecord abstrai.

### Acessando o Client do Banco:
```bash
# Para PostgreSQL no Heroku
heroku pg:psql

# Para MySQL/MariaDB no Linux
mysql -u usuario -p nome_do_banco
```

### Exemplos de Queries:
```sql
SELECT count(*) FROM admins;
SELECT * FROM categories WHERE created_at > '2023-01-01';
```

## 3. Verificando via Logs da Aplicação

Os logs mostram as transações em tempo real e podem confirmar se um registro foi criado com sucesso durante uma requisição HTTP.

```bash
# No Linux (Visualizando as últimas 100 linhas e acompanhando)
tail -f log/production.log

# No Heroku
heroku logs --tail
```

Busque por linhas que contenham `INSERT INTO` ou `COMMIT` para confirmar a persistência.

## 4. Dicas de Segurança ao Verificar Dados

1. **Cuidado com Alterações**: No console de produção, evite usar métodos que alteram dados (`update`, `destroy`, `save`) a menos que seja estritamente necessário.
2. **Modo Read-Only**: Se possível, use o console em modo sandbox para garantir que nenhuma alteração seja persistida:
   ```bash
   rails console -e production --sandbox
   ```
3. **Privacidade**: Nunca exiba dados sensíveis (como hashes de senhas ou documentos de usuários) em telas compartilhadas ou logs públicos.

## 5. Resumo das Ferramentas
- **Rails Console**: Melhor para depuração lógica e consultas rápidas usando modelos.
- **DB Client (psql/mysql)**: Melhor para performance de queries pesadas e verificação de esquema.
- **Logs**: Melhor para entender o fluxo que levou à criação do dado.
