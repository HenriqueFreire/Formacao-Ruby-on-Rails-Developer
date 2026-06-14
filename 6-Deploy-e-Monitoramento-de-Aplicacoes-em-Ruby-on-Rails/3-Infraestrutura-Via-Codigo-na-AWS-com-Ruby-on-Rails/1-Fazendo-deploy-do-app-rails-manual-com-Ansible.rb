# Guia: Deploy de Aplicação Rails com Ansible

# O Ansible é uma ferramenta de automação de TI que simplifica tarefas complexas 
# como o provisionamento de servidores, gerenciamento de configuração e deploy 
# de aplicações. Diferente do deploy manual via SSH, o Ansible permite que você 
# defina seu estado desejado em arquivos YAML (Playbooks).

# ==========================================
# 1. Estrutura Básica
# ==========================================
# Para um deploy simples, você geralmente precisa de:
# - inventory.ini: Onde ficam os endereços dos seus servidores.
# - deploy.yml: O arquivo principal com as instruções (Playbook).

# ==========================================
# 2. Exemplo de Arquivo de Inventário (inventory.ini)
# ==========================================
# [webservers]
# 192.168.1.100 ansible_user=deploy ansible_ssh_private_key_file=~/.ssh/id_rsa

# ==========================================
# 3. Exemplo de Playbook de Deploy (deploy.yml)
# ==========================================
# ---
# - name: Deploy da Aplicação Ruby on Rails
#   hosts: webservers
#   vars:
#     app_path: /home/deploy/minha-aplicacao
#     repo_url: git@github.com:usuario/minha-aplicacao.git
#     rails_env: production
#
#   tasks:
#     - name: Atualizar código fonte do repositório Git
#       git:
#         repo: "{{ repo_url }}"
#         dest: "{{ app_path }}"
#         version: main
#         force: yes
#
#     - name: Instalar gems do projeto
#       command: bundle install --deployment --without development test
#       args:
#         chdir: "{{ app_path }}"
#
#     - name: Executar migrações do banco de dados
#       command: bundle exec rails db:migrate
#       args:
#         chdir: "{{ app_path }}"
#       environment:
#         RAILS_ENV: "{{ rails_env }}"
#
#     - name: Pré-compilar assets
#       command: bundle exec rails assets:precompile
#       args:
#         chdir: "{{ app_path }}"
#       environment:
#         RAILS_ENV: "{{ rails_env }}"
#
#     - name: Reiniciar o servidor de aplicação (Puma)
#       become: yes
#       systemd:
#         name: puma
#         state: restarted

# ==========================================
# 4. Como Executar o Deploy
# ==========================================
# No seu terminal local, execute o comando:
#
# ansible-playbook -i inventory.ini deploy.yml

# ==========================================
# 5. Vantagens do Ansible para Rails
# ==========================================
# - Idempotência: Se uma tarefa já foi realizada (ex: git pull sem mudanças), 
#   o Ansible não faz nada, economizando tempo.
# - Reprodutibilidade: Você pode rodar o mesmo deploy em 10 servidores 
#   simultaneamente com um único comando.
# - Documentação como Código: O Playbook serve como documentação viva de 
#   como sua aplicação deve ser instalada.

# ==========================================
# 6. Exemplo: Verificando se o Ruby está instalado
# ==========================================
# - name: Verificar versão do Ruby
#   command: ruby -v
#   register: ruby_version
#
# - name: Mostrar versão do Ruby
#   debug:
#     msg: "A versão instalada é {{ ruby_version.stdout }}"
