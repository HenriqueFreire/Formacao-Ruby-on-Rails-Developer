# Guia: Deploy com Docker utilizando Ansible em Ruby on Rails

# Combinar Docker com Ansible une o melhor dos dois mundos: a portabilidade dos 
# containers com a automação de infraestrutura do Ansible. Nesta abordagem, 
# o Ansible não gerencia os arquivos Ruby individualmente, mas sim o ciclo de 
# vida dos containers.

# ==========================================
# 1. Por que usar Docker + Ansible?
# ==========================================
# - O Ansible garante que o Docker está instalado e configurado no servidor.
# - O Docker garante que a aplicação rodará exatamente igual ao desenvolvimento.
# - Facilita o rollback: basta pedir para o Ansible rodar uma versão anterior da imagem.

# ==========================================
# 2. Exemplo de Playbook: Preparando o Ambiente
# ==========================================
# Antes de rodar o app, precisamos garantir que o Docker existe no servidor.
#
# - name: Instalar Docker
#   hosts: webservers
#   become: yes
#   tasks:
#     - name: Instalar dependências do Docker
#       apt:
#         name: ["apt-transport-https", "ca-certificates", "curl", "software-properties-common"]
#         update_cache: yes
#
#     - name: Adicionar chave GPG do Docker
#       apt_key:
#         url: https://download.docker.com/linux/ubuntu/gpg
#
#     - name: Instalar o engine do Docker
#       apt:
#         name: docker-ce
#         state: present

# ==========================================
# 3. Exemplo de Playbook: Deploy do Container Rails
# ==========================================
# Este exemplo assume que você já fez o 'push' da sua imagem para um Registry (Docker Hub, AWS ECR, etc).
#
# - name: Deploy do App Rails Containerizado
#   hosts: webservers
#   vars:
#     image_tag: "meu-usuario/meu-app-rails:v1.2.0"
#     db_url: "postgres://user:pass@db-host:5432/dbname"
#
#   tasks:
#     - name: Pull da imagem mais recente
#       docker_image:
#         name: "{{ image_tag }}"
#         source: pull
#
#     - name: Rodar Migrations (Container Temporário)
#       docker_container:
#         name: rails_migrations
#         image: "{{ image_tag }}"
#         command: bundle exec rails db:migrate
#         env:
#           DATABASE_URL: "{{ db_url }}"
#           RAILS_ENV: production
#         detach: no
#         cleanup: yes # Remove o container após terminar
#
#     - name: Iniciar Container da Aplicação
#       docker_container:
#         name: meu-app-rails
#         image: "{{ image_tag }}"
#         state: started
#         restart_policy: always
#         ports:
#           - "80:3000"
#         env:
#           DATABASE_URL: "{{ db_url }}"
#           RAILS_ENV: production
#           SECRET_KEY_BASE: "{{ lookup('env', 'SECRET_KEY_BASE') }}"

# ==========================================
# 4. Orquestração com Docker Compose via Ansible
# ==========================================
# Se você usa Docker Compose para gerenciar App + Banco + Redis:
#
# - name: Subir stack com Docker Compose
#   community.docker.docker_compose:
#     project_src: /home/deploy/app
#     state: present

# ==========================================
# 5. Dicas de Segurança
# ==========================================
# - Use 'ansible-vault' para criptografar suas variáveis sensíveis (senhas de banco, keys).
# - Certifique-se de que o usuário que o Ansible usa está no grupo 'docker' 
#   para evitar o uso excessivo de 'sudo'.

# ==========================================
# 6. Como Executar
# ==========================================
# ansible-playbook -i inventory.ini deploy_docker.yml
