# Deploy via Git em Aplicações Ruby on Rails

O deploy via Git é uma das formas mais simples e eficientes de publicar uma aplicação. Ele se baseia no princípio de que "o que está no repositório é o que deve estar em produção".

## 1. O Conceito de Remote

Quando fazemos deploy via Git, geralmente enviamos nosso código para um "remote" (servidor remoto) que possui um "hook" (gatilho). Esse gatilho detecta o novo código e inicia o processo de build e deploy automaticamente.

## 2. Exemplo com Heroku

O Heroku é o exemplo clássico de deploy via Git.

### Passo 1: Login e Criação do App
```bash
heroku login
heroku create nome-do-meu-app
```

### Passo 2: Adicionando o Remote
Ao criar o app, o Heroku automaticamente adiciona um remote chamado `heroku` ao seu git local. Você pode verificar com:
```bash
git remote -v
```

### Passo 3: Fazendo o Deploy
Para enviar seu código e disparar o deploy:
```bash
git push heroku main
```

## 3. Exemplo com Servidor Próprio (Bare Repository)

Se você tem um VPS (Linux), pode configurar seu próprio deploy via Git.

### No Servidor:
1. Crie um repositório "bare":
   ```bash
   mkdir -p /var/repo/meu-app.git
   cd /var/repo/meu-app.git
   git init --bare
   ```
2. Configure um hook `post-receive` em `/var/repo/meu-app.git/hooks/post-receive`:
   ```bash
   #!/bin/bash
   GIT_WORK_TREE=/var/www/meu-app git checkout -f
   cd /var/www/meu-app
   bundle install
   rails db:migrate
   # Reiniciar o servidor (ex: Puma ou Nginx)
   ```

### Na sua Máquina Local:
1. Adicione o seu servidor como um remote:
   ```bash
   git remote add production usuario@meu-servidor.com:/var/repo/meu-app.git
   ```
2. Faça o deploy:
   ```bash
   git push production main
   ```

## 4. Melhores Práticas para Deploy via Git

### Nunca envie credenciais
Certifique-se de que seu arquivo `config/database.yml` ou `.env` NÃO está sendo enviado. Use variáveis de ambiente no servidor.

### Verifique o Branch
Geralmente, fazemos deploy a partir do branch `main` ou `master`. Se estiver em outro branch, use:
```bash
git push production meu-branch:main
```

### Automação de Migrações
Em Rails, o deploy não termina no envio do código. É crucial rodar as migrações:
```bash
# No Heroku
heroku run rails db:migrate

# No seu servidor
ssh usuario@servidor "cd /var/www/meu-app && rails db:migrate"
```

## 5. Resumo do Fluxo

1. **Commit**: Salve suas alterações localmente.
2. **Test**: Rode seus testes (Cucumber/RSpec) para garantir que nada quebrou.
3. **Push**: Envie para o remote de produção.
4. **Migrate**: Execute as migrações de banco de dados no servidor.
