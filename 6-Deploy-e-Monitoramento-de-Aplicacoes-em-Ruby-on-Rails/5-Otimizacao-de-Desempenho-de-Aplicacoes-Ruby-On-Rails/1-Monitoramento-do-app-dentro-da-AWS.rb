# Monitoramento do App dentro da AWS

Este arquivo contém explicações e exemplos sobre como monitorar aplicações hospedadas na AWS, utilizando serviços como CloudWatch, SNS e Logs.

## 1. Amazon CloudWatch

O CloudWatch é o principal serviço de monitoramento da AWS. Ele coleta dados na forma de métricas, permitindo visualizar e criar alarmes.

### Principais Conceitos:
- **Métricas**: Dados sobre o desempenho dos seus recursos (CPU, Memória, Disco, Latência de Rede).
- **Alarmes**: Ações automáticas baseadas em limites (ex: enviar um e-mail se a CPU passar de 80%).
- **Dashboards**: Visualizações personalizadas das métricas.

### Exemplo: Criando um Alarme de CPU via AWS CLI
```bash
aws cloudwatch put-metric-alarm \
    --alarm-name "AltaUtilizacaoCPU" \
    --alarm-description "Alarme se a CPU exceder 80% por 5 minutos" \
    --metric-name CPUUtilization \
    --namespace AWS/EC2 \
    --statistic Average \
    --period 300 \
    --threshold 80 \
    --comparison-operator GreaterThanThreshold \
    --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
    --evaluation-periods 1 \
    --alarm-actions arn:aws:sns:us-east-1:123456789012:MeuTopicoNotificacao
```

---

## 2. CloudWatch Logs

O CloudWatch Logs permite centralizar os logs da sua aplicação e do sistema operacional.

### Como funciona:
1. O **CloudWatch Agent** é instalado no servidor.
2. Ele coleta arquivos de log (ex: `/var/log/nginx/access.log` ou `log/production.log` do Rails).
3. Os logs são enviados para o CloudWatch, onde podem ser pesquisados e filtrados.

### Exemplo: Consultando logs via CLI (Logs Insights)
```bash
aws logs start-query \
    --log-group-name "/aws/ec2/meu-app-producao" \
    --start-time 1625097600 \
    --end-time 1625184000 \
    --query-string "fields @timestamp, @message | filter @message like /Error/ | sort @timestamp desc"
```

---

## 3. Notificações com AWS SNS (Simple Notification Service)

O SNS é usado para enviar notificações (E-mail, SMS, HTTP) quando um alarme do CloudWatch é disparado.

### Fluxo:
`CloudWatch Alarme` -> `Tópico SNS` -> `Assinantes (E-mail do Administrador)`

---

## 4. Exemplo com Ruby (AWS SDK)

Você pode enviar métricas personalizadas da sua aplicação Rails diretamente para o CloudWatch.

```ruby
require 'aws-sdk-cloudwatch'

cw = Aws::CloudWatch::Client.new(region: 'us-east-1')

# Enviando uma métrica personalizada: Total de Vendas
cw.put_metric_data({
  namespace: 'MeuApp/Vendas',
  metric_data: [
    {
      metric_name: 'VendaRealizada',
      dimensions: [
        {
          name: 'TipoProduto',
          value: 'Assinatura'
        },
      ],
      value: 1.0,
      unit: 'Count'
    },
  ]
})

puts "Métrica enviada com sucesso!"
```

### Por que monitorar?
- **Proatividade**: Descobrir problemas antes que os usuários reclamem.
- **Escalabilidade**: Saber o momento exato de adicionar mais servidores (Auto Scaling).
- **Segurança**: Identificar padrões de acesso suspeitos nos logs.
