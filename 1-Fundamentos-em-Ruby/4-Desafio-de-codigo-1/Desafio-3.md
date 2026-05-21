# Desafio 3: Validação de Saque Bancário

## Descrição
Você está desenvolvendo uma funcionalidade para um sistema bancário que permite aos clientes realizarem saques em caixas eletrônicos. O programa deve validar se o cliente possui saldo suficiente antes de autorizar a transação.

### Regras de Negócio:
1.  **Saldo Disponível**: O valor solicitado para o saque deve ser menor ou igual ao saldo atual da conta.
2.  **Sucesso**: Se houver saldo, subtraia o valor do saque e exiba o novo saldo.
3.  **Falha**: Se o saldo for insuficiente, a transação deve ser cancelada com uma mensagem de erro.

## Entrada
A entrada consiste em dois valores inteiros (um em cada linha):
1.  **Saldo Total**: O saldo disponível na conta bancária.
2.  **Valor do Saque**: O valor que o cliente deseja retirar.

## Saída
O programa deve retornar uma string específica para cada situação:

*   **Em caso de sucesso:**
    `Saque realizado com sucesso. Novo saldo: {saldo}`
*   **Em caso de saldo insuficiente:**
    `Saldo insuficiente. Saque nao realizado!`

*(Nota: Certifique-se de que a mensagem de sucesso use exatamente a pontuação e o formato indicados).*

## Exemplos
A tabela abaixo apresenta casos de teste para validar sua lógica.

| Entrada | Saída |
| :--- | :--- |
| 1000<br>200 | Saque realizado com sucesso. Novo saldo: 800 |
| 1500<br>1800 | Saldo insuficiente. Saque nao realizado! |
| 300<br>200 | Saque realizado com sucesso. Novo saldo: 100 |
