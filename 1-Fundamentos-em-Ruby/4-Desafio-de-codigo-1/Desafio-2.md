# Desafio 2: Upgrade de Capacidade de Mineração

## Descrição
As máquinas pesadas dos CodeMiners estão passando por um upgrade estratégico! Sua tarefa é criar um programa que calcule a nova capacidade total de processamento de uma máquina (medida em teraflops) após a aplicação de um aumento percentual.

### Lógica de Cálculo:
`Nova Capacidade = Capacidade Atual + (Capacidade Atual * (Aumento Percentual / 100))`

## Entrada
A entrada consiste em dois valores inteiros positivos, fornecidos em uma única linha e separados por um espaço:
1.  **Capacidade Atual**: Valor atual em teraflops.
2.  **Aumento Percentual**: O percentual de upgrade a ser aplicado.

## Saída
A saída deve exibir apenas o valor da nova capacidade total em teraflops (como um número inteiro ou formatado conforme o resultado do cálculo).

## Exemplos
A tabela abaixo apresenta exemplos de entrada e a respectiva saída esperada.

| Entrada | Saída |
| :--- | :--- |
| 100 20 | 120 |
| 50 10 | 55 |
| 200 50 | 300 |
