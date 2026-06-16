# Monitoramento de Aplicações e Encerramento do Curso

Este arquivo final aborda o monitoramento de performance de nível de aplicação (APM) e consolida os conhecimentos adquiridos durante o módulo de Deploy e Monitoramento.

## 1. Monitoramento de Performance de Aplicação (APM)

Diferente do CloudWatch (que monitora a infraestrutura), ferramentas de APM olham para o que acontece *dentro* do código Ruby on Rails.

### Ferramentas Populares:
- **New Relic**: Extremamente popular no ecossistema Ruby.
- **Datadog**: Oferece monitoramento unificado (infra + app).
- **Skylight**: Focado especificamente em performance de Rails.

### O que o APM rastreia?
- **Transactions**: Tempo gasto em cada requisição.
- **Database Queries**: Identifica consultas SQL lentas (N+1).
- **External Services**: Tempo de resposta de APIs externas.
- **Error Tracking**: Detalhes de exceções que ocorrem em produção.

### Exemplo: Instalando New Relic no Rails
1. Adicione a gem ao `Gemfile`:
   ```ruby
   gem 'newrelic_rpm'
   ```
2. Adicione o arquivo `config/newrelic.yml` com sua chave de licença.
3. Reinicie a aplicação. O monitoramento começará automaticamente.

---

## 2. Health Checks (Verificações de Saúde)

É fundamental que o Load Balancer saiba se sua aplicação está "viva" e pronta para receber tráfego.

### Exemplo: Implementando um Health Check simples no Rails
Crie uma rota específica que retorne `200 OK` apenas se tudo estiver bem (conexão com banco, etc).

```ruby
# config/routes.rb
get '/health', to: 'health_check#index'

# app/controllers/health_check_controller.rb
class HealthCheckController < ApplicationController
  def index
    # Verifica se o banco de dados está respondendo
    ActiveRecord::Base.connection.execute("SELECT 1")
    render plain: "OK", status: :ok
  rescue => e
    render plain: "Error: #{e.message}", status: :service_unavailable
  end
end
```

---

## 3. Resumo do Módulo: O Caminho para Produção

Durante este módulo, vimos:
1. **Preparação para Deploy**: Uso de Git e variáveis de ambiente.
2. **Deploys Manuais vs. Automatizados**: A importância de pipelines de CI/CD.
3. **Docker**: Como empacotar a aplicação para consistência entre ambientes.
4. **Infraestrutura na AWS**: EC2, RDS, S3 e Load Balancers.
5. **Backups e Segurança**: Criação de AMIs e backups de bancos de dados.
6. **Monitoramento e Escala**: CloudWatch, Auto Scaling e ferramentas de APM.

## 4. Conclusão

Parabéns por concluir esta jornada! Agora você possui as bases necessárias para não apenas desenvolver em Ruby on Rails, mas também para colocar sua aplicação no ar de forma profissional, segura e escalável.

**Dica Final**: O aprendizado em DevOps e Cloud é contínuo. Explore ferramentas de infraestrutura como código (Terraform, CloudFormation) para automatizar ainda mais seus ambientes.

---
*Fim do curso: Formação Ruby on Rails Developer*
