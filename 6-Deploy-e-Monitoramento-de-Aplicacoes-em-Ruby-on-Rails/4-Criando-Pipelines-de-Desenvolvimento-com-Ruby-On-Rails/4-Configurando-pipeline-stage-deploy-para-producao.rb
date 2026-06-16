# Guia: Configurando o Estágio de Deploy para Produção no Pipeline

# O estágio de 'Deploy' é o passo final onde o código validado é enviado para 
# o ambiente real onde os usuários acessarão a aplicação. Em Rails, isso 
# pode ser feito via SSH direto, Ansible, Docker ou plataformas como Heroku/AWS.

# ==========================================
# 1. Segurança em Primeiro Lugar: SSH Keys
# ==========================================
# Nunca coloque senhas ou chaves privadas diretamente no código. 
# Use as 'Variables' do GitLab para armazenar sua chave SSH.
#
# Exemplo de preparação do SSH no Job:
#
# .setup_ssh: &setup_ssh
#   before_script:
#     - 'command -v ssh-agent >/dev/null || ( apt-get update -y && apt-get install openssh-client -y )'
#     - eval $(ssh-agent -s)
#     - echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
#     - mkdir -p ~/.ssh
#     - chmod 700 ~/.ssh
#     - echo "$SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts

# ==========================================
# 2. Exemplo: Deploy via SSH Simples
# ==========================================
# deploy_production:
#   stage: deploy
#   <<: *setup_ssh
#   script:
#     - ssh deploy@meu-servidor.com "cd /app && git pull && bundle install && rails db:migrate && systemctl restart puma"
#   only:
#     - main # Só faz deploy quando houver merge na main

# ==========================================
# 3. Exemplo: Deploy utilizando Ansible
# ==========================================
# Se você já tem um Playbook de deploy (como visto em módulos anteriores):
#
# deploy_ansible:
#   stage: deploy
#   image: williamyeh/ansible:ubuntu22.04
#   <<: *setup_ssh
#   script:
#     - ansible-playbook -i inventory.ini deploy.yml
#   environment:
#     name: production
#     url: https://minha-app.com

# ==========================================
# 4. Uso de Environments e Rollbacks
# ==========================================
# O GitLab permite rastrear o que está em qual ambiente.
# Com o 'environment', você ganha o botão de 'Rollback' na interface do GitLab.
# 
# environment:
#   name: production
#   on_stop: stop_production

# ==========================================
# 5. Deploy Manual (Aprovação)
# ==========================================
# Para evitar deploys automáticos acidentais em produção, você pode exigir 
# um clique manual de um gerente de projeto.
#
# deploy_to_prod:
#   stage: deploy
#   script:
#     - echo "Realizando deploy..."
#   when: manual # Exige clique no botão 'Play' no GitLab
#   allow_failure: false

# ==========================================
# 6. Deploy de Containers (Docker)
# ==========================================
# Se você usa Docker, o deploy consiste em avisar o servidor para rodar 
# a nova versão da imagem que foi buildada no estágio de 'Build'.
#
# deploy_docker:
#   stage: deploy
#   script:
#     - ssh $SERVER_USER@$SERVER_IP "docker pull $CI_REGISTRY_IMAGE:latest && docker stack deploy -c docker-compose.yml meu_app"

# ==========================================
# 7. Verificação Pós-Deploy
# ==========================================
# É recomendável adicionar um pequeno script de teste após o deploy:
#
# post_deploy_check:
#   stage: deploy
#   script:
#     - curl --fail https://minha-app.com/health_check || exit 1
