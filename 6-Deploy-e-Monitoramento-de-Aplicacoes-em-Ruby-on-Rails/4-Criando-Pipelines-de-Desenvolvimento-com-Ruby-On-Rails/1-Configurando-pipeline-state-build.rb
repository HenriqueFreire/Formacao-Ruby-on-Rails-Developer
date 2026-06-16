# Guia: Configurando o Estágio de Build no Pipeline (Rails)

# O estágio de 'Build' é geralmente o primeiro ou o segundo passo em um pipeline 
# de CI/CD. Seu objetivo é transformar o código-fonte em algo que possa ser 
# testado ou implantado (ex: instalar dependências, compilar assets ou criar imagens).

# ==========================================
# 1. O que acontece no Build?
# ==========================================
# - Instalação de Gems (bundle install).
# - Instalação de pacotes JavaScript (npm/yarn install).
# - Compilação de CSS e JS (assets:precompile).
# - Criação de imagens Docker (docker build).

# ==========================================
# 2. Exemplo: Build de Dependências e Assets
# ==========================================
# Neste exemplo, preparamos o ambiente e salvamos os resultados para o próximo estágio.
#
# build_assets:
#   stage: build
#   image: ruby:3.3
#   script:
#     - bundle install --deployment --path vendor/bundle
#     - bundle exec rails assets:precompile RAILS_ENV=production
#   artifacts:
#     paths:
#       - public/assets/
#       - vendor/bundle/
#     expire_in: 1 hour

# ==========================================
# 3. O conceito de Artifacts (Artefatos)
# ==========================================
# Artefatos são arquivos gerados por um job que o GitLab guarda para serem 
# usados em jobs posteriores ou para download manual.
# 
# No exemplo acima, a pasta 'public/assets' é salva como um artefato para que 
# o job de 'deploy' não precise compilar tudo de novo.

# ==========================================
# 4. Exemplo: Build de Imagem Docker
# ==========================================
# Se você usa Docker, o "Build" significa gerar a imagem da aplicação.
#
# build_image:
#   stage: build
#   image: docker:latest
#   services:
#     - docker:dind
#   script:
#     - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
#     - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG .
#     - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG

# ==========================================
# 5. Otimização com Cache
# ==========================================
# Para não baixar todas as gems em todo deploy, usamos o 'cache'.
#
# cache:
#   paths:
#     - vendor/bundle
#     - node_modules/

# ==========================================
# 6. Variáveis de Ambiente no Build
# ==========================================
# Algumas gems ou processos de build precisam de chaves. 
# Use as 'Variables' do GitLab (Settings > CI/CD > Variables).
#
# build_job:
#   script:
#     - echo "Usando a chave: $MINHA_API_KEY"
#     - bundle exec rails assets:precompile

# ==========================================
# 7. Verificação
# ==========================================
# Se o build falhar, o pipeline para imediatamente e as etapas de Teste 
# e Deploy não são executadas, garantindo que código "quebrado" não suba.
