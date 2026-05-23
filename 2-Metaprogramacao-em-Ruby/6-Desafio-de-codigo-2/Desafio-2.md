# Desafio 2: Simulador de Velocidade de Robô

## Contexto
Você foi designado para desenvolver o núcleo de controle de movimento de um robô explorador. O robô opera dentro de limites de segurança (velocidade mínima e máxima) e responde a comandos de aceleração e desaceleração.

## Objetivo
Criar uma classe `Robo` que gerencie sua velocidade atual com base em limites pré-definidos e comandos sequenciais.

## Especificações da Classe `Robo`
- **Atributos:**
  - `velocidade_atual`: Inicia na velocidade mínima (`Vmin`).
  - `velocidade_maxima`: Limite superior.
  - `velocidade_minima`: Limite inferior.
- **Métodos:**
  - `acelerar`: Aumenta a velocidade em 1 unidade (respeitando o limite máximo).
  - `desacelerar`: Diminui a velocidade em 1 unidade (respeitando o limite mínimo).

## Entrada
O programa receberá:
1. Uma linha com dois inteiros: `Vmin` e `Vmax` (ex: `1 5`).
2. Uma linha com uma sequência de caracteres (String): `'A'` para acelerar e `'D'` para desacelerar (ex: `AADAD`).

## Saída
Um único inteiro representando a **velocidade final** do robô após o processamento de todos os comandos.

---

## Exemplos
| Entrada | Saída |
| :--- | :--- |
| 1 5 <br> AADAD | 2 |
| 2 8 <br> ADAAD | 3 |

---
*Nota: Se o robô estiver na velocidade mínima e receber um comando 'D', ele deve permanecer na velocidade mínima. O mesmo se aplica à velocidade máxima com o comando 'A'.*
