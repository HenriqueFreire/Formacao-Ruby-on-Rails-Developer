# Configurando Pipelines de CI/CD para Ruby on Rails

Uma pipeline de CI/CD (Continuous Integration / Continuous Deployment) automatiza o processo de testar e implantar seu código. Isso garante que cada alteração enviada ao repositório seja validada antes de chegar ao usuário final.

## 1. O que é CI/CD?

- **CI (Integração Contínua)**: Automatiza a execução de testes e linters sempre que um novo código é enviado (push) ou um Pull Request é aberto.
- **CD (Entrega/Implantação Contínua)**: Automatiza o deploy para o ambiente de staging ou produção após a aprovação nos testes.

## 2. Exemplo com GitHub Actions

O GitHub Actions é uma das ferramentas mais populares para definir pipelines diretamente no repositório.

### Criando o arquivo da Pipeline: `.github/workflows/ci.yml`

```yaml
name: "Rails CI"

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:11-alpine
        ports:
          - "5432:5432"
        env:
          POSTGRES_DB: rails_test
          POSTGRES_USER: rails
          POSTGRES_PASSWORD: password
    env:
      RAILS_ENV: test
      DATABASE_URL: "postgres://rails:password@localhost:5432/rails_test"
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Install Ruby and gems
        uses: ruby/setup-ruby@v1
        with:
          bundler-cache: true # Roda 'bundle install' e faz cache das gems automaticamente

      - name: Set up database schema
        run: bin/rails db:schema:load

      - name: Run Tests (RSpec/Cucumber)
        run: |
          bundle exec rspec
          bundle exec cucumber
```

## 3. Etapas Essenciais de uma Pipeline Rails

1. **Linting**: Verificar o estilo do código usando ferramentas como `RuboCop`.
   ```bash
   bundle exec rubocop
   ```
2. **Security Audit**: Verificar vulnerabilidades em gems usando `bundler-audit`.
   ```bash
   bundle exec bundle-audit check --update
   ```
3. **Unit & Functional Tests**: Executar RSpec ou Minitest.
4. **Acceptance Tests**: Executar Cucumber para testar a jornada do usuário.
5. **Build de Assets**: Garantir que o `assets:precompile` funciona sem erros.

## 4. Continuous Deployment (CD)

Para o deploy automático (ex: no Heroku), você pode adicionar um job extra que depende do sucesso dos testes:

```yaml
  deploy:
    needs: test # Só roda se o job 'test' passar
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Heroku
        uses: akhileshns/heroku-deploy@v3.12.12
        with:
          heroku_api_key: ${{secrets.HEROKU_API_KEY}}
          heroku_app_name: "meu-app-rails-producao"
          heroku_email: "meu-email@exemplo.com"
```

## 5. Melhores Práticas

- **Fail Fast**: Coloque os testes mais rápidos (unitários) no início da pipeline.
- **Isolamento**: Use serviços (Docker) para bancos de dados e Redis na pipeline para simular o ambiente real.
- **Secrets**: Nunca coloque chaves de API ou senhas diretamente no YAML. Use os `Secrets` do GitHub ou do seu provedor de CI.
- **Cache**: Sempre utilize cache para as gems (`bundle install`) para acelerar a execução da pipeline.

## 6. Resumo do Fluxo Automatizado
1. Desenvolvedor faz o `git push`.
2. Pipeline inicia automaticamente.
3. Linters e Auditorias de Segurança são executados.
4. Banco de dados é configurado e Testes (RSpec/Cucumber) rodam.
5. Se tudo passar, o deploy para Produção é realizado.
