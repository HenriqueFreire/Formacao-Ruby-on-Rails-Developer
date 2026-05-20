# Guia de Instalação do Ruby on Rails

# O Ruby on Rails é um framework de desenvolvimento web escrito em Ruby. 
# Para utilizá-lo, você precisa ter o Ruby, um gerenciador de dependências (Bundler) 
# e, opcionalmente, um gerenciador de versões (como rbenv ou rvm).

# ==========================================
# 1. Instalação no Windows (Recomendado: WSL2)
# ==========================================
# A melhor forma de desenvolver com Rails no Windows é utilizando o WSL2 (Windows Subsystem for Linux).
#
# Passo 1: Instale o WSL2 no terminal (PowerShell):
# wsl --install
#
# Passo 2: Reinicie o computador e abra o Ubuntu (ou a distro escolhida).
# Passo 3: Siga os passos de instalação para Linux (Ubuntu/Debian) abaixo.

# ==========================================
# 2. Instalação no macOS
# ==========================================
# Passo 1: Instale o Homebrew (gerenciador de pacotes):
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
# Passo 2: Instale o rbenv para gerenciar versões do Ruby:
# brew install rbenv ruby-build
#
# Passo 3: Configure o rbenv no seu shell:
# rbenv init
# (Siga as instruções que aparecerem no terminal para adicionar ao seu .zshrc ou .bash_profile)
#
# Passo 4: Instale o Ruby:
# rbenv install 3.3.0
# rbenv global 3.3.0
#
# Passo 5: Instale o Rails:
# gem install rails

# ==========================================
# 3. Instalação no Linux (Ubuntu/Debian)
# ==========================================
# Passo 1: Atualize os pacotes:
# sudo apt update
#
# Passo 2: Instale dependências básicas:
# sudo apt install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev
#
# Passo 3: Instale o rbenv:
# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
# (Adicione as linhas recomendadas ao seu ~/.bashrc)
#
# Passo 4: Instale o Ruby:
# rbenv install 3.3.0
# rbenv global 3.3.0
#
# Passo 5: Instale o Rails:
# gem install rails

# ==========================================
# 4. Verificação da Instalação
# ==========================================
# Para garantir que tudo está funcionando corretamente, execute:
# ruby -v
# rails -v

puts "Guia de instalação criado com sucesso!"
puts "Verifique o conteúdo deste arquivo para instruções detalhadas sobre cada SO."
