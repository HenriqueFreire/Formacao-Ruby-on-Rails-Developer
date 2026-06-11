# Guia de Registro e Configuração de DNS

# O DNS (Domain Name System) é o responsável por traduzir o nome do seu domínio 
# (ex: meu-app.com) para o endereço IP do seu servidor (ex: 192.168.1.1).

# ==========================================
# 1. Tipos de Registros Mais Comuns
# ==========================================

# A (Address): Aponta um nome de domínio para um endereço IPv4.
# Exemplo: meu-app.com -> 104.21.43.120

# CNAME (Canonical Name): Aponta um nome para outro nome (um apelido).
# Exemplo: www.meu-app.com -> meu-app.com

# TXT (Text): Usado para verificações de segurança e e-mail (SPF, DKIM).
# Exemplo: Usado para provar que você é dono do domínio no Google Search Console.

# MX (Mail Exchange): Define para onde os e-mails do domínio devem ser enviados.

# ==========================================
# 2. Exemplo Prático de Configuração
# ==========================================
# Imagine que seu servidor tem o IP: 157.245.80.12

# No seu painel de DNS (Cloudflare, Registro.br, GoDaddy, AWS Route53):
# ------------------------------------------------------------------
# Tipo | Nome (Host) | Valor (Aponta para) | TTL
# -----|-------------|---------------------|---------
# A    | @           | 157.245.80.12       | Automático (ou 3600)
# A    | api         | 157.245.80.12       | Automático
# CNAME| www         | meu-app.com         | Automático
# ------------------------------------------------------------------
# Nota: O "@" representa o domínio raiz (meu-app.com).

# ==========================================
# 3. TTL (Time to Live)
# ==========================================
# O TTL determina por quanto tempo os servidores DNS ao redor do mundo 
# devem "lembrar" (fazer cache) da sua configuração.
# - TTL Baixo (ex: 300s / 5 min): Bom para quando você está trocando de servidor.
# - TTL Alto (ex: 3600s / 1 hora): Bom para estabilidade quando nada vai mudar.

# ==========================================
# 4. Propagação de DNS
# ==========================================
# Quando você altera um DNS, a mudança não é instantânea. Ela pode levar de 
# alguns minutos até 48 horas para se espalhar por toda a internet.
# Ferramenta útil: whatsmydns.net (para verificar o status global).

# ==========================================
# 5. Dica: Usando Cloudflare como Proxy
# ==========================================
# O Cloudflare oferece uma camada de proteção (WAF) e cache.
# Quando a "nuvem laranja" está ativa, o IP real do seu servidor fica escondido, 
# e o tráfego passa pelos servidores do Cloudflare antes de chegar ao Rails.

# ==========================================
# 6. Verificação via Terminal
# ==========================================
# Você pode verificar para onde seu domínio está apontando usando o comando 'dig' ou 'nslookup':
#
# dig meu-app.com
# nslookup meu-app.com
