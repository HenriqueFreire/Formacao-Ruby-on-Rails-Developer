# Onde o TDD e o BDD entram em uma Pipeline de CI/CD?

# Em um fluxo de desenvolvimento moderno, o TDD e o BDD não são apenas práticas locais,
# eles são a base da Integração Contínua (CI) e Entrega Contínua (CD).

# --- 1. O Fluxo na Pipeline ---

# Uma pipeline típica segue estes passos:
# 1. Commit/Push: O desenvolvedor envia o código para o repositório.
# 2. Build: O ambiente é montado (instalação de Gems, Node modules, etc).
# 3. Test (Onde o TDD/BDD brilha): A pipeline executa automaticamente todos os testes.
# 4. Deploy: Se os testes passarem, o código vai para Staging ou Produção.

# --- 2. TDD na Pipeline (Testes de Unidade/Integração) ---
# Os testes criados via TDD garantem que a lógica interna está correta. 
# Se uma alteração quebrar um cálculo ou uma validação, a pipeline falha e impede o deploy.

# Exemplo de comando executado na Pipeline:
# bundle exec rake test   # Executa Minitest
# ou
# bundle exec rspec       # Executa RSpec

# --- 3. BDD na Pipeline (Testes de Sistema/E2E) ---
# Os testes de BDD (usando Capybara ou Selenium) simulam o usuário no navegador.
# Eles garantem que, mesmo que o código técnico esteja correto, o fluxo do usuário (comportamento) funciona.

# --- 4. Exemplo de Configuração (GitHub Actions) ---

# Imagine um arquivo '.github/workflows/ci.yml':
=begin
name: CI Pipeline
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'
      - name: Install dependencies
        run: bundle install
      - name: Run Tests (TDD/BDD)
        run: bundle exec rake test  # Se algum teste falhar aqui, o deploy é cancelado!
=end

# --- CONCLUSÃO ---

# - O TDD/BDD servem como um "Portão de Qualidade" (Quality Gate).
# - Sem eles, a automação de deploy seria perigosa, pois não haveria garantia de que 
#   o novo código não quebrou funcionalidades existentes.
# - Em resumo: A pipeline é o lugar onde a confiança gerada pelos testes se torna automatizada.
