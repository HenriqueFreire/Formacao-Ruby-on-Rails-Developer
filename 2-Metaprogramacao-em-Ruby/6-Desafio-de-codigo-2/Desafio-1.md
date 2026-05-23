# Desafio 1: Criando Sua Primeira Classe em Ruby

## Contexto
Agora que você domina os fundamentos da Orientação a Objetos, seu desafio é criar uma estrutura simples para representar uma pessoa. Este exercício foca na criação de classes, atributos e na interação básica com o usuário através do terminal.

## Objetivo
Implementar uma classe chamada `Pessoa` que seja capaz de armazenar e exibir informações básicas (nome e idade).

## Requisitos
1. **Classe Pessoa:** Deve conter os atributos `nome` e `idade`.
2. **Entrada de Dados:** O programa deve solicitar que o usuário insira o nome e a idade.
3. **Exibição:** O programa deve exibir os dados formatados conforme o padrão estabelecido.
4. **Estrutura:** Utilize métodos e boas práticas de POO.

## Entrada
O programa receberá dois valores via terminal:
1. Uma `String` representando o **nome**.
2. Um `Integer` representando a **idade**.

## Saída
A saída deve ser uma única linha contendo a frase:
`Nome: [nome], Idade: [idade]`

---

## Exemplos
A tabela abaixo apresenta exemplos de entradas e as respectivas saídas esperadas:

| Entrada | Saída |
| :--- | :--- |
| João <br> 26 | Nome: João, Idade: 26 |
| Ana <br> 17 | Nome: Ana, Idade: 17 |
| Paulo <br> 44 | Nome: Paulo, Idade: 44 |

---
*Dica: Lembre-se de converter a entrada da idade para inteiro usando `.to_i`.*
