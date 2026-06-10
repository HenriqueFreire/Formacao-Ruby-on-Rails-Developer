# Configurando Migrate e Seed em Produção

Em uma aplicação Ruby on Rails, o gerenciamento do banco de dados em produção exige cuidados extras para evitar perda de dados e garantir que a estrutura esteja sincronizada com o código.

## 1. Executando Migrations em Produção

Diferente do ambiente de desenvolvimento, em produção você deve garantir que o comando seja executado apontando explicitamente para o ambiente correto (embora o Rails geralmente detecte isso via variáveis de ambiente).

### Comando Padrão:
```bash
rails db:migrate RAILS_ENV=production
```

### No Heroku:
```bash
heroku run rails db:migrate
```

### No Docker:
```bash
docker-compose exec web rails db:migrate
```

## 2. O Uso de Seeds em Produção

O arquivo `db/seeds.rb` é usado para popular o banco de dados com dados iniciais (como categorias fixas, estados, ou um usuário administrador inicial).

**Atenção:** Tome muito cuidado ao rodar seeds em produção para não duplicar dados ou sobrescrever informações existentes.

### Executando o Seed:
```bash
rails db:seed RAILS_ENV=production
```

### Exemplo de um `db/seeds.rb` Seguro:
É recomendado usar métodos que verifiquem a existência do registro antes de criar (como `find_or_create_by`).

```ruby
# db/seeds.rb

puts "Populando banco de dados..."

# Criando um administrador padrão apenas se ele não existir
Admin.find_or_create_by!(email: 'admin@sistema.com') do |admin|
  admin.name = 'Administrador Geral'
  admin.password = 'mudar123'
  admin.password_confirmation = 'mudar123'
end

# Criando categorias iniciais
['Tecnologia', 'Saúde', 'Educação'].each do |nome_categoria|
  Category.find_or_create_by!(name: nome_categoria)
end

puts "Seed finalizado com sucesso!"
```

## 3. Verificando o Status das Migrations

Antes de rodar qualquer comando, verifique quais migrations ainda não foram aplicadas:

```bash
rails db:migrate:status RAILS_ENV=production
```

## 4. Rollback em Produção

Se algo der errado, você pode desfazer a última migration, mas faça isso com cautela:

```bash
rails db:rollback RAILS_ENV=production
```

## 5. Melhores Práticas

1. **Backup antes de migrar**: Sempre faça um dump do banco de dados antes de rodar migrações estruturais pesadas.
2. **Migrations sem Downtime**: Evite remover colunas ou renomear tabelas que ainda estão sendo usadas pela versão antiga do código durante o processo de deploy.
3. **Logs**: Monitore os logs de saída do comando migrate para identificar erros de constraints ou tipos de dados incompatíveis.
4. **Idempotência no Seed**: Seus scripts de seed devem ser capazes de rodar múltiplas vezes sem causar erros ou dados duplicados.
