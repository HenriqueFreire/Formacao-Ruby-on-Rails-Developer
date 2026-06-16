# Guia: Conhecendo o GitLab para o Ciclo de Vida DevOps (Rails)

# O GitLab é muito mais do que apenas um servidor Git. Ele é uma plataforma 
# completa de DevOps que permite gerenciar desde o planejamento do projeto 
# até o monitoramento da aplicação em produção.

# ==========================================
# 1. Por que usar GitLab?
# ==========================================
# - All-in-one: Tudo em um só lugar (Código, Issues, CI/CD, Registry).
# - CI/CD Nativo: Uma das ferramentas mais poderosas para automação de testes e deploys.
# - Auto DevOps: Recursos que tentam configurar automaticamente seu pipeline.

# ==========================================
# 2. Gerenciamento de Código e Repositórios
# ==========================================
# Assim como o GitHub, o GitLab oferece uma interface web para gerenciar 
# seus repositórios, branches e merge requests.
#
# Comandos básicos permanecem os mesmos:
# git remote add origin https://gitlab.com/seu-usuario/seu-projeto.git
# git push -u origin main

# ==========================================
# 3. GitLab CI/CD (.gitlab-ci.yml)
# ==========================================
# Este é o "coração" do GitLab. Você define o pipeline em um arquivo YAML.
#
# Exemplo básico para Rails:
#
# stages:
#   - test
#   - deploy
#
# job_test:
#   stage: test
#   image: ruby:3.3
#   script:
#     - bundle install
#     - bundle exec rails test
#
# job_deploy:
#   stage: deploy
#   script:
#     - echo "Realizando deploy para produção..."
#   only:
#     - main

# ==========================================
# 4. Merge Requests (MR)
# ==========================================
# No GitLab, o que chamamos de "Pull Request" no GitHub é chamado de 
# "Merge Request". É o local onde o código é revisado antes de ser 
# integrado à branch principal.
#
# Dica: Você pode configurar o GitLab para só permitir o Merge se 
# o Pipeline de teste passar com sucesso.

# ==========================================
# 5. GitLab Container Registry
# ==========================================
# O GitLab possui um registro de containers integrado. Você pode buildar 
# sua imagem Docker no pipeline e salvá-la no próprio GitLab.
#
# Exemplo no pipeline:
#
# build_docker:
#   image: docker:latest
#   services:
#     - docker:dind
#   script:
#     - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
#     - docker build -t $CI_REGISTRY_IMAGE .
#     - docker push $CI_REGISTRY_IMAGE

# ==========================================
# 6. Issues e Boards
# ==========================================
# Use o GitLab para gerenciar suas tarefas.
# - Issues: Para bugs e novas features.
# - Boards: Kanban para visualizar o fluxo de trabalho (To Do, Doing, Done).
# - Milestones: Para agrupar tarefas de uma versão específica.

# ==========================================
# 7. Wiki e Documentação
# ==========================================
# Cada projeto no GitLab tem sua própria Wiki, ideal para documentar 
# arquitetura, guias de instalação e processos da equipe.
