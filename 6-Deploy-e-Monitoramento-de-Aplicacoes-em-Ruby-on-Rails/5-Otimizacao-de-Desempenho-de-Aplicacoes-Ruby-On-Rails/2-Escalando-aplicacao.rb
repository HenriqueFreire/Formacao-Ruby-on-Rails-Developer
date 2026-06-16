# Escalando a Aplicação (Scaling)

Este arquivo explica os conceitos de escalabilidade e como aplicar estratégias de escalonamento em aplicações hospedadas na AWS.

## 1. Tipos de Escalabilidade

### Escalabilidade Vertical (Scale Up)
Consiste em aumentar os recursos de um único servidor (aumentar CPU, Memória RAM ou trocar para uma instância mais potente).
- **Prós**: Simples de implementar.
- **Contras**: Possui um limite físico e causa downtime durante o upgrade.

### Escalabilidade Horizontal (Scale Out) - O Padrão Cloud
Consiste em adicionar mais servidores ao pool para dividir a carga.
- **Prós**: Praticamente ilimitada e garante alta disponibilidade.
- **Contras**: Exige que a aplicação seja *stateless* (não armazene estado localmente).

---

## 2. Componentes Chave na AWS

### Elastic Load Balancer (ELB/ALB)
O Load Balancer (Balanceador de Carga) é a porta de entrada. Ele recebe as requisições dos usuários e as distribui entre as várias instâncias EC2 disponíveis.

### Auto Scaling Group (ASG)
O Auto Scaling monitora a carga das instâncias e, baseado em regras, adiciona ou remove servidores automaticamente.
- **Exemplo**: Se a média de CPU do grupo passar de 70%, adicione 2 novas instâncias.

---

## 3. Exemplo Prático: Criando um Auto Scaling Group (Conceito CLI)

Para criar um grupo de auto scaling, primeiro precisamos de um **Launch Template** (que define *o que* rodar) e depois o **Auto Scaling Group** (que define *quantos* rodar).

```bash
# Exemplo simplificado de criação de ASG via AWS CLI
aws autoscaling create-auto-scaling-group \
    --auto-scaling-group-name "MeuApp-ASG" \
    --launch-template LaunchTemplateName=MeuApp-Template \
    --min-size 2 \
    --max-size 10 \
    --desired-capacity 2 \
    --vpc-zone-identifier "subnet-12345,subnet-67890"
```

---

## 4. Considerações para Ruby on Rails

Para que sua aplicação Rails escale horizontalmente com sucesso, você deve seguir o princípio de **Statelessness**:

1. **Sessões**: Não use `CookieStore` se os dados forem grandes, ou prefira armazenar sessões no **Redis** ou **Memcached** (usando AWS ElastiCache).
2. **Uploads**: Nunca salve arquivos no disco local da instância. Use o **Amazon S3**.
3. **Banco de Dados**: Use um banco de dados externo e gerenciado, como o **Amazon RDS**, para que todas as instâncias acessem a mesma fonte de dados.
4. **Logs**: Centralize os logs no **CloudWatch Logs** (conforme visto no arquivo anterior).

### Exemplo de Configuração de Sessão no Redis (Gemfile):
```ruby
# No Gemfile
gem 'redis-actionpack'

# Em config/initializers/session_store.rb
Rails.application.config.session_store :redis_store,
  servers: ["redis://#{ENV['REDIS_HOST']}:6379/0/session"],
  expire_after: 90.minutes,
  key: '_meu_app_session'
```

## 5. Resumo
Escalar não é apenas "adicionar mais máquinas", mas garantir que sua arquitetura suporte o crescimento de forma automática e eficiente, mantendo a experiência do usuário consistente.
