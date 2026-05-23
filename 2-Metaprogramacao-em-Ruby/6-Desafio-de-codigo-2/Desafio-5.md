# Desafio 5: Simulador de Cartas de Baralho

## Contexto
Muitas aplicações de jogos precisam representar objetos do mundo real com valores fixos. Este desafio foca na criação de uma classe `Carta` e no tratamento de valores categóricos (simulando enums).

## Objetivo
Criar um programa que receba índices numéricos para **Valor** e **Naipe**, e exiba o nome da carta correspondente.

## Mapeamento de Valores
Para este desafio, utilize a seguinte lógica de conversão:

### Valores (Valor):
1. Ás
2. Valete
3. Dama
4. Rei

### Naipes (Naipe):
0. Paus
1. Ouros
2. Copas
3. Espadas

## Requisitos
1. **Classe `Carta`:** Possui atributos `valor` e `naipe`.
2. **Lógica de Exibição:** Converter os índices numéricos recebidos nos nomes correspondentes.
3. **Saída:** Exibir no formato: `Carta escolhida: [Valor] de [Naipe]`

## Entrada
Duas linhas contendo inteiros:
1. O índice do **Valor**.
2. O índice do **Naipe**.

## Saída
`Carta escolhida: [Nome do Valor] de [Nome do Naipe]`

---

## Exemplos
| Entrada | Saída |
| :--- | :--- |
| 1 <br> 0 | Carta escolhida: Ás de Paus |
| 3 <br> 2 | Carta escolhida: Dama de Copas |
| 4 <br> 3 | Carta escolhida: Rei de Espadas |

---
*Dica: Utilize Hash ou arrays para mapear os índices para os nomes das cartas de forma eficiente.*
