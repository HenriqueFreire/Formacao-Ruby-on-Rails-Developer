# Guia: Atualizando Aplicação via SSH em Ruby on Rails

# Este arquivo detalha o processo de atualização de uma aplicação em produção
# utilizando acesso direto via SSH. Este é o processo manual básico que 
# ferramentas como Capistrano ou Kamal automatizam.

# ==========================================
# 1. Acessando o Servidor
# ==========================================
# O primeiro passo é conectar-se ao servidor onde a aplicação está hospedada.
#
# Exemplo:
# ssh usuario@ip-do-servidor
# ou se usar uma chave específica:
# ssh -i ~/.ssh/minha_chave.pem usuario@ip-do-servidor

# ==========================================
# 2. Navegando até o Diretório da Aplicação
# ==========================================
# Geralmente as aplicações ficam em /var/www ou no home do usuário de deploy.
#
# cd /home/deploy/minha-aplicacao

# ==========================================
# 3. Obtendo as Atualizações do Código
# ==========================================
# Baixe as alterações mais recentes do seu repositório Git.
#
# git pull origin main

# ==========================================
# 4. Atualizando Dependências (Gems)
# ==========================================
# Se você adicionou novas gems no Gemfile, precisará instalá-las.
#
# bundle install --deployment --without development test

# ==========================================
# 5. Executando Migrações de Banco de Dados
# ==========================================
# Sempre que houver mudanças na estrutura do banco.
#
# bundle exec rails db:migrate RAILS_ENV=production

# ==========================================
# 6. Pré-compilação de Assets
# ==========================================
# Necessário se houve mudanças em CSS, JavaScript ou imagens.
#
# bundle exec rails assets:precompile RAILS_ENV=production

# ==========================================
# 7. Reiniciando o Servidor de Aplicação
# ==========================================
# Para que as alterações de código entrem em vigor, o servidor (Puma, Passenger, etc)
# precisa ser reiniciado.
#
# Se usar Systemd:
# sudo systemctl restart minha-aplicacao.service
#
# Se usar o comando 'touch' no Passenger:
# touch tmp/restart.txt

# ==========================================
# 8. Script de Automação Simples (deploy.sh)
# ==========================================
# Você pode criar um script simples no servidor para rodar tudo de uma vez:
#
# #!/bin/bash
# echo "Iniciando deploy..."
# git pull origin main
# bundle install --deployment --without development test
# bundle exec rails db:migrate RAILS_ENV=production
# bundle exec rails assets:precompile RAILS_ENV=production
# sudo systemctl restart puma
# echo "Deploy finalizado com sucesso!"

# ==========================================
# 9. Verificação
# ==========================================
# Após o deploy, verifique os logs para garantir que tudo está ok.
#
# tail -f log/production.log
