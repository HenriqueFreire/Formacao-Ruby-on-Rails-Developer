# Desafio 4: Consulta de Análises de Desempenho

## Objetivo
Criar uma interface para acionistas que permita consultar análises de desempenho bancário dentro de um período específico. O foco é manipulação de listas e filtros de datas.

## Requisitos
- Implementar um método chamado `obter_analises_desempenho`.
- O método recebe `data_inicial` e `data_final` (no formato `dd/mm/aaaa`).
- O sistema deve retornar as análises que ocorreram dentro desse intervalo (inclusivo).

## Entrada
- Data Inicial: `dd/mm/aaaa`.
- Data Final: `dd/mm/aaaa`.

## Saída
Uma lista (strings) contendo as análises realizadas no período.

## Exemplos de Teste

| Entrada | Saída Esperada |
| :--- | :--- |
| `01/04/2023`<br>`20/05/2023` | `Analise de Politicas e Regulamentacoes`<br>`Analise de Ativos` |
| `05/03/2023`<br>`05/04/2023` | `Analises Corporativas`<br>`Analise de Politicas e Regulamentacoes` |
| `05/01/2023`<br>`03/03/2023` | `Analise de Riscos e Exposicoes` |
