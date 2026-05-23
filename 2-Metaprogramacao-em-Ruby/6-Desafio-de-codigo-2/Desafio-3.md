# Desafio 3: Fábrica de Robôs Personalizados

## Contexto
Como um inventor de robôs, você deseja organizar sua criação através de um sistema. Cada robô deve ser único, possuindo nome, modelo e ano de fabricação. Este desafio foca no uso de **construtores** (método `initialize`) em Ruby.

## Objetivo
Implementar uma classe `Robo` que utilize um construtor para definir suas características e um método para exibir seu perfil completo.

## Requisitos da Classe `Robo`
- **Atributos:** `nome`, `modelo`, `ano_fabricacao`.
- **Construtor:** Deve inicializar os três atributos no momento da criação do objeto.
- **Método `exibir_informacoes`:** Deve imprimir os dados do robô seguindo o formato:
  `O robô [nome], modelo [modelo], foi fabricado em [ano].`

## Entrada
O programa receberá três entradas em ordem:
1. `nome` (String)
2. `modelo` (String)
3. `ano` (Integer)

## Saída
A frase formatada contendo todas as informações fornecidas.

---

## Exemplos
| Entrada | Saída |
| :--- | :--- |
| DioBot <br> DIO <br> 2020 | O robô DioBot, modelo DIO, foi fabricado em 2020. |
| Robozão <br> RBZ1000 <br> 2022 | O robô Robozão, modelo RBZ1000, foi fabricado em 2022. |
| Megazord <br> PR-2000 <br> 2017 | O robô Megazord, modelo PR-2000, foi fabricado em 2017. |
