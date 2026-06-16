# Guia: Configurando o Estágio de Teste de Comportamento (BDD) no Pipeline

# O estágio de teste de comportamento (ou System Tests) valida a aplicação do 
# ponto de vista do usuário final. Ele simula interações reais no navegador 
# para garantir que todas as partes do sistema funcionam juntas.

# ==========================================
# 1. O que são Testes de Comportamento?
# ==========================================
# - Foco no Usuário: "Como usuário, quero clicar em X e ver Y".
# - Integração Total: Testa desde a interface (HTML/JS) até o banco de dados.
# - Ferramentas Comuns: Cucumber, Capybara, Selenium, Playwright.

# ==========================================
# 2. Desafios em CI/CD: O Navegador
# ==========================================
# Servidores de CI não possuem interface gráfica. Por isso, usamos navegadores 
# em modo "Headless" (sem interface). No Rails com Capybara, isso geralmente 
# requer a instalação do ChromeDriver ou o uso de um serviço Selenium.

# ==========================================
# 3. Exemplo: Configurando Cucumber no GitLab CI
# ==========================================
# cucumber_tests:
#   stage: test
#   image: ruby:3.3
#   services:
#     - postgres:15
#     - selenium/standalone-chrome:latest # Serviço de navegador externo
#   variables:
#     SELENIUM_REMOTE_URL: "http://selenium__standalone-chrome:4444/wd/hub"
#   script:
#     - bundle install
#     - bundle exec rails db:prepare
#     - bundle exec cucumber

# ==========================================
# 4. Configuração do Capybara (Rails Side)
# ==========================================
# Você precisa dizer ao Capybara para usar o Selenium remoto quando estiver no CI.
# Exemplo no spec_helper.rb ou env.rb:
#
# if ENV['SELENIUM_REMOTE_URL']
#   Capybara.register_driver :remote_chrome do |app|
#     Capybara::Selenium::Driver.new(app,
#       browser: :remote,
#       url: ENV['SELENIUM_REMOTE_URL'],
#       capabilities: :chrome)
#   end
#   Capybara.javascript_driver = :remote_chrome
# end

# ==========================================
# 5. Capturando Screenshots de Erros
# ==========================================
# Uma das melhores partes dos testes de sistema no CI é ver o que deu errado.
# Configure o GitLab para salvar prints das falhas como artefatos.
#
# behavior_tests:
#   script:
#     - bundle exec rails test:system
#   artifacts:
#     when: on_failure # Só salva se o teste falhar
#     paths:
#       - tmp/screenshots/
#     expire_in: 1 week

# ==========================================
# 6. Exemplo: Rodando System Tests do Rails (Minitest)
# ==========================================
# system_tests:
#   stage: test
#   script:
#     - apt-get update && apt-get install -y chromium-driver
#     - bundle exec rails test:system

# ==========================================
# 7. Considerações Finais
# ==========================================
# Testes de comportamento são mais lentos e "frágeis" que os de unidade. 
# Recomenda-se:
# - Rodá-los apenas em estágios posteriores ou em branches específicas.
# - Usar 'Retry' em caso de falhas intermitentes de rede/navegador.
