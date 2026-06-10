# Registrando e Configurando DNS para sua Aplicação Rails

O DNS (Domain Name System) é o que permite que os usuários acessem sua aplicação através de um nome (ex: `www.meusite.com.br`) em vez de um endereço IP difícil de lembrar.

## 1. Tipos de Registros DNS Comuns

Para configurar sua aplicação Rails, você precisará entender os principais tipos de registros:

- **A (Address)**: Aponta um domínio ou subdomínio diretamente para um endereço IPv4.
- **CNAME (Canonical Name)**: Aponta um domínio para outro domínio (muito usado em serviços como Heroku).
- **TXT**: Usado para verificações de segurança e configurações de e-mail (SPF, DKIM).
- **MX (Mail Exchange)**: Define para onde os e-mails do domínio devem ser enviados.

## 2. Exemplo: Apontando para um VPS (DigitalOcean, AWS, Linode)

Se você tem um servidor com IP fixo (ex: `159.203.170.20`):

| Tipo | Nome (Host) | Valor (Destino) | TTL |
| :--- | :--- | :--- | :--- |
| A | @ (ou vazio) | 159.203.170.20 | 3600 |
| A | www | 159.203.170.20 | 3600 |

*O símbolo `@` representa o domínio raiz (ex: `meusite.com.br`).*

## 3. Exemplo: Apontando para o Heroku

O Heroku não fornece um IP fixo, por isso usamos registros CNAME.

### Passo 1: Adicionar o domínio no Heroku
```bash
heroku domains:add www.meusite.com.br
```
O Heroku retornará um "DNS Target" como `www.meusite.com.br.herokudns.com`.

### Passo 2: Configurar no seu provedor de DNS (Registro.br, Cloudflare)

| Tipo | Nome (Host) | Valor (Destino) |
| :--- | :--- | :--- |
| CNAME | www | www.meusite.com.br.herokudns.com |

## 4. Usando Cloudflare para Segurança e Performance

O Cloudflare atua como um Proxy entre o usuário e seu servidor, oferecendo SSL gratuito e proteção contra ataques DDoS.

### Vantagens:
1. **SSL Grátis**: Você não precisa configurar o Let's Encrypt manualmente no servidor.
2. **Cache**: Melhora a velocidade de carregamento de assets (CSS, JS, Imagens).
3. **Ocultação de IP**: Protege o IP real do seu servidor.

## 5. Verificando as Configurações

Após alterar o DNS, a propagação pode levar de alguns minutos até 48 horas. Você pode verificar o status usando ferramentas de terminal:

```bash
# Verificar o registro A
dig meusite.com.br A

# Verificar o CNAME
dig www.meusite.com.br CNAME

# Versão simplificada (nslookup)
nslookup meusite.com.br
```

## 6. Configuração no Rails (Force SSL)

Uma vez que o DNS e o SSL estejam configurados, force sua aplicação a usar apenas HTTPS editando `config/environments/production.rb`:

```ruby
# config/environments/production.rb
Rails.application.configure do
  # ...
  config.force_ssl = true
end
```

## 7. Resumo do Processo
1. **Compre o domínio** (ex: Registro.br, GoDaddy).
2. **Defina os Name Servers** (apontar para Cloudflare ou para o provedor de DNS do seu servidor).
3. **Crie os registros A ou CNAME** apontando para o IP ou endereço do seu host.
4. **Aguarde a propagação**.
5. **Configure o SSL/HTTPS** na sua aplicação.
