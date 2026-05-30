# Desafio 2: Sistema de Abertura de Contas

## Objetivo
Implementar uma classe em Ruby chamada `ContaBancaria` que represente uma conta básica em um sistema bancário. O desafio foca na criação de objetos e manipulação de atributos.

## Requisitos da Classe
A classe `ContaBancaria` deve possuir os seguintes atributos:
- **Número da Conta:** Valor inteiro.
- **Nome do Titular:** String.
- **Saldo:** Valor decimal (float).

## Entrada
O programa deve ler via console:
1. O número da conta (Inteiro).
2. O nome do titular (String).
3. O saldo inicial (Decimal).

## Saída
Exibir as informações da conta formatadas conforme o padrão abaixo:
```text
Informacoes:
Conta: [numero]
Titular: [nome]
Saldo: R$ [saldo]
```

## Exemplos de Teste

| Entrada | Saída Esperada |
| :--- | :--- |
| `101010`<br>`Caio Carlos`<br>`98.0` | `Informacoes:`<br>`Conta: 101010`<br>`Titular: Caio Carlos`<br>`Saldo: R$ 98.0` |
| `212223`<br>`Carla Paiva`<br>`500.0` | `Informacoes:`<br>`Conta: 212223`<br>`Titular: Carla Paiva`<br>`Saldo: R$ 500.0` |
| `123456`<br>`Joao Silva`<br>`1000.0` | `Informacoes:`<br>`Conta: 123456`<br>`Titular: Joao Silva`<br>`Saldo: R$ 1000.0` |

