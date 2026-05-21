# Desafio 5: Cálculo de Juros Compostos

## Descrição
Você deve criar uma ferramenta para um aplicativo bancário que calcule o valor final de um investimento baseado em juros compostos. O programa deve processar o capital inicial, a taxa de juros anual e o tempo de investimento.

### Fórmula Matemática:
O valor final (A) é calculado pela fórmula:
`A = P * (1 + i) ^ n`

Onde:
*   **A**: Valor final do investimento.
*   **P**: Valor inicial (capital).
*   **i**: Taxa de juros (ex: 0.05 para 5%).
*   **n**: Período de tempo (anos).

## Entrada
O programa recebe três valores, um em cada linha:
1.  **Valor Inicial (P)**: Número decimal ou inteiro.
2.  **Taxa de Juros (i)**: Número decimal (ex: 0.08 para 8%).
3.  **Período (n)**: Número inteiro representando os anos.

## Saída
A saída deve exibir o valor final do investimento, formatado com **duas casas decimais** e precedido pelo texto padrão.

**Formato esperado:**
`Valor final do investimento: R$ XX.XX`

## Exemplos
Confira os exemplos abaixo para validar o cálculo de potência e arredondamento.

| Entrada | Saída |
| :--- | :--- |
| 5000<br>0.08<br>5 | Valor final do investimento: R$ 7346.64 |
| 1000<br>0.06<br>3 | Valor final do investimento: R$ 1191.02 |
| 20000<br>0.04<br>10 | Valor final do investimento: R$ 29604.89 |
