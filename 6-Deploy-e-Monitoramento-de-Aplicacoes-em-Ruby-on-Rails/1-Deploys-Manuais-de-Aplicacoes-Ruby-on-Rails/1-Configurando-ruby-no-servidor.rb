# Guia de Configuração do Ruby no Servidor

# Configurar o Ruby corretamente no servidor é crucial para o desempenho e a 
# estabilidade da aplicação Rails. Recomenda-se o uso de gerenciadores de versão.

# ==========================================
# 1. Por que usar um Gerenciador de Versão?
# ==========================================
# Evita conflitos com a versão do Ruby do sistema operacional e permite que 
# cada aplicação use uma versão específica.

# Principais opções:
# - rbenv (Mais leve e focado)
# - rvm (Mais completo, gerencia "gemsets")
# - asdf (Multilinguagem)

# ==========================================
# 2. Configuração com rbenv (Recomendado)
# ==========================================
# Passo 1: Instale o rbenv e o ruby-build
# git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# cd ~/.rbenv && src/configure && make -C src
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# source ~/.bashrc

# Passo 2: Instale o plugin ruby-build
# mkdir -p "$(rbenv root)"/plugins
# git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Passo 3: Instale a versão desejada
# rbenv install 3.3.0
# rbenv global 3.3.0

# ==========================================
# 3. Configuração de Gems e Bundler
# ==========================================
# No servidor, é comum configurar o Bundler para instalar as gems localmente 
# na pasta do projeto para evitar poluição global.

# Exemplo de configuração:
# gem install bundler
# bundle config set --local deployment 'true'
# bundle config set --local path 'vendor/bundle'

# ==========================================
# 4. Variáveis de Ambiente (ENV)
# ==========================================
# Nunca coloque senhas no código. Use variáveis de ambiente.
# No servidor, você pode defini-las no ~/.bashrc ou em arquivos .env.

# Exemplo no ~/.bashrc:
# export RAILS_ENV=production
# export DATABASE_URL="postgresql://user:pass@localhost/myapp_prod"
# export SECRET_KEY_BASE="gerada_com_bin/rails_secret"

# ==========================================
# 5. Otimização de Memória (MALLOC_ARENA_MAX)
# ==========================================
# Para aplicações Ruby em produção, limitar as arenas de memória do Linux 
# pode reduzir drasticamente o consumo de RAM.

# Adicione ao script de inicialização:
# export MALLOC_ARENA_MAX=2

# ==========================================
# 6. Verificação Final
# ==========================================
# ruby -v
# which ruby
# gem -v
# bundle -v
