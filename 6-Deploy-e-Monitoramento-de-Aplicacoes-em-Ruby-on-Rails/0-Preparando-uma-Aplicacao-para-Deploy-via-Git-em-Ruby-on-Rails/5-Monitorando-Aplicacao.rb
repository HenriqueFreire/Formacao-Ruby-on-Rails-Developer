# Monitorando Aplicações Ruby on Rails em Produção

O monitoramento é essencial para garantir a disponibilidade, performance e saúde da sua aplicação. Ele permite identificar erros antes dos usuários e entender gargalos de desempenho.

## 1. Monitoramento de Erros (Error Tracking)

Em vez de verificar logs manualmente, usamos ferramentas que capturam exceções automaticamente e enviam alertas (E-mail, Slack).

### Ferramentas Comuns:
- **Sentry**: Popular e com plano gratuito generoso.
- **Honeybadger**: Focado em aplicações Ruby.
- **Airbrake**: Um dos mais antigos do ecossistema.

### Exemplo de Configuração (Sentry):
Adicione ao seu `Gemfile`:
```ruby
gem "sentry-ruby"
gem "sentry-rails"
```

Configure em `config/initializers/sentry.rb`:
```ruby
Sentry.init do |config|
  config.dsn = 'https://exemplo@sentry.io/123'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.traces_sample_rate = 0.5 # Captura 50% das transações para performance
end
```

## 2. Monitoramento de Performance (APM)

APM (Application Performance Monitoring) ajuda a identificar consultas SQL lentas, gargalos em controllers e tempo de resposta de APIs externas.

### Ferramentas Comuns:
- **New Relic**: O padrão da indústria.
- **Skylight**: Focado em Ruby on Rails, interface muito simples.
- **AppSignal**: Ótimo custo-benefício.

### O que observar:
- **Apdex**: Índice de satisfação do usuário baseado no tempo de resposta.
- **Slowest Transactions**: Quais rotas demoram mais para responder.
- **SQL Queries**: Tabelas que precisam de índices.

## 3. Gerenciamento de Logs (Log Aggregation)

Em produção, os logs podem crescer rapidamente. Ferramentas de agregação facilitam a busca por eventos específicos.

### Ferramentas:
- **Papertrail**: Muito fácil de configurar no Heroku.
- **Datadog**: Monitoramento completo (Logs + Métricas + APM).
- **Logtail**: Agregador moderno baseado em SQL.

### Comandos Úteis (Heroku):
```bash
# Ver logs em tempo real
heroku logs --tail

# Filtrar por processos específicos (ex: worker)
heroku logs --ps worker --tail
```

## 4. Monitoramento de Infraestrutura

Se você gerencia seu próprio servidor (VPS), precisa monitorar recursos básicos:
- **Uso de CPU e Memória**: Ferramentas como `htop` ou `Glances`.
- **Espaço em Disco**: Alertas quando o disco atinge 90%.
- **Uptime**: Serviços como **UptimeRobot** ou **Better Uptime** que avisam se o site sair do ar.

## 5. Health Checks no Rails

Crie um endpoint simples para que balanceadores de carga ou serviços de monitoramento verifiquem se a aplicação está viva.

No Rails 7, já existe o arquivo `app/controllers/up_controller.rb`:
```ruby
class UpController < ApplicationController
  def index
    render plain: "OK", status: :ok
  end
end
```
Rota: `GET /up`

## 6. Resumo do Plano de Monitoramento
1. **Erros**: Use Sentry ou Honeybadger para alertas imediatos de bugs.
2. **Performance**: Use Skylight ou New Relic para otimizar o código lento.
3. **Disponibilidade**: Use UptimeRobot para saber se o servidor caiu.
4. **Logs**: Use Papertrail ou Datadog para histórico e auditoria.
