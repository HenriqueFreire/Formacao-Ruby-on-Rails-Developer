# Desafio 1: Taxa de Sucesso de Testes Automatizados

## Descrição
Neste desafio, seu objetivo é criar um algoritmo para avaliar o desempenho de uma suíte de testes automatizados. O programa deve calcular a **Taxa de Sucesso** com base no número de testes bem-sucedidos em relação ao total de testes realizados.

### Critério de Cálculo:
A taxa de sucesso é calculada pela fórmula:
`Taxa de Sucesso (%) = (Testes Bem-sucedidos / Total de Testes) * 100`

## Entrada
A entrada consiste em dois números inteiros, fornecidos um em cada linha:
1.  **Testes Bem-sucedidos**: O número de casos de teste que passaram.
2.  **Total de Testes**: O número total de casos de teste executados.

## Saída
A saída deve ser uma string informando a porcentagem da taxa de sucesso, formatada obrigatoriamente com **duas casas decimais**.

**Formato esperado:**
`Taxa de sucesso: XX.XX%`

## Exemplos
A tabela abaixo apresenta exemplos de entrada e a saída esperada. Certifique-se de que seu programa trata corretamente a divisão por números decimais (float).

| Entrada | Saída |
| :--- | :--- |
| 10<br>20 | Taxa de sucesso: 50.00% |
| 10<br>25 | Taxa de sucesso: 40.00% |
| 3<br>5 | Taxa de sucesso: 60.00% |
