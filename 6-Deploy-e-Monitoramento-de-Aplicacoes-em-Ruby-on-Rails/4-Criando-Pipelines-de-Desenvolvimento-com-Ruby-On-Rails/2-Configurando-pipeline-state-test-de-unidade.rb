# Guia: Configurando o Estágio de Teste (Unidade) no Pipeline (Rails)

# O estágio de 'Test' é crucial para garantir a qualidade do código e evitar 
# regressões. Em uma aplicação Rails, isso geralmente envolve rodar testes 
# de unidade, models, controllers e helpers.

# ==========================================
# 1. Por que rodar testes no Pipeline?
# ==========================================
# - Feedback Rápido: Descubra bugs assim que fizer o push do código.
# - Proteção da Branch Principal: Impeça que código com falhas chegue à produção.
# - Confiança no Refactoring: Altere o código com a segurança de que os testes validarão as mudanças.

# ==========================================
# 2. Configurando o Banco de Dados para Testes
# ==========================================
# Testes do Rails precisam de um banco de dados. No GitLab CI, usamos 'services'.
#
# unit_tests:
#   stage: test
#   image: ruby:3.3
#   services:
#     - postgres:15
#   variables:
#     POSTGRES_DB: rails_test
#     POSTGRES_USER: postgres
#     POSTGRES_PASSWORD: password
#     DATABASE_URL: "postgres://postgres:password@postgres:5432/rails_test"
#   script:
#     - bundle install
#     - bundle exec rails db:prepare
#     - bundle exec rails test

# ==========================================
# 3. Exemplo: Rodando RSpec
# ==========================================
# Se você usa RSpec em vez do Minitest padrão:
#
# rspec_tests:
#   stage: test
#   script:
#     - bundle exec rspec spec/models spec/helpers

# ==========================================
# 4. Coleta de Cobertura (SimpleCov)
# ==========================================
# Você pode configurar o GitLab para ler a porcentagem de cobertura de testes.
# Adicione o SimpleCov ao seu projeto e configure o regex no .gitlab-ci.yml:
#
# test_job:
#   script:
#     - bundle exec rails test
#   artifacts:
#     paths:
#       - coverage/
#   coverage: '/\(\d+.\d+\%\) covered/'

# ==========================================
# 5. Visualização de Resultados (JUnit)
# ==========================================
# O GitLab pode mostrar quais testes falharam diretamente na interface do Merge Request.
# Use a gem 'minitest-reporters' ou configure o RSpec para gerar XML no formato JUnit.
#
# test:
#   script:
#     - bundle exec rails test --reporter junit --output reports/test-results.xml
#   artifacts:
#     reports:
#       junit: reports/test-results.xml

# ==========================================
# 6. Otimização: Paralelismo
# ==========================================
# Para suítes de testes muito grandes, o Rails 6+ suporta testes paralelos.
#
# test_parallel:
#   parallel: 3 # Roda 3 instâncias simultâneas do job
#   script:
#     - bundle exec rails test

# ==========================================
# 7. Verificação
# ==========================================
# Um pipeline bem configurado deve falhar se um único teste falhar. Isso 
# garante que a integridade da aplicação seja mantida em cada commit.
