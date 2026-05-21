# Desafio 4: Registro de Depósitos Bancários

## Descrição
Você foi contratado para desenvolver o módulo de depósitos de um sistema bancário. O programa deve processar uma única tentativa de depósito e validar o valor informado pelo cliente, garantindo que apenas valores positivos sejam aceitos.

### Regras de Validação:
1.  **Valor Positivo**: O saldo da conta deve ser atualizado e uma mensagem de sucesso exibida.
2.  **Valor Zero**: O programa deve ser encerrado com uma mensagem informativa.
3.  **Valor Negativo**: Deve exibir uma mensagem de erro indicando que o valor é inválido.

## Entrada
O programa recebe um valor numérico (pode ser inteiro ou decimal) representando o depósito:
*   Ex: `500.50`, `-100`, `0`.

## Saída
O programa deve exibir mensagens conforme o valor de entrada:

*   **Se valor > 0:**
    `Deposito realizado com sucesso!`
    `Saldo atual: R$ {valor}`
*   **Se valor == 0:**
    `Encerrando o programa...`
*   **Se valor < 0:**
    `Valor invalido! Digite um valor maior que zero.`

## Exemplos
A tabela abaixo apresenta os cenários de teste esperados.

| Entrada | Saída |
| :--- | :--- |
| 500.50 | Deposito realizado com sucesso!<br>Saldo atual: R$ 500.50 |
| -100 | Valor invalido! Digite um valor maior que zero. |
| 0 | Encerrando o programa... |
