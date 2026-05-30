# Desafio 1: Verificador de Senhas da AWS

## Objetivo
Você faz parte da equipe de segurança de uma empresa que utiliza os serviços da AWS. Foi identificado que algumas senhas de usuários do IAM são fracas. Sua missão é desenvolver um programa em Ruby que valide a força de uma senha com base em critérios rigorosos de segurança.

## Requisitos de Segurança
Para ser considerada forte, a senha deve atender a todos os critérios abaixo:
1. **Comprimento Mínimo:** Pelo menos 8 caracteres.
2. **Letra Maiúscula:** Pelo menos uma letra maiúscula (A-Z).
3. **Letra Minúscula:** Pelo menos uma letra minúscula (a-z).
4. **Número:** Pelo menos um dígito numérico (0-9).
5. **Caractere Especial:** Pelo menos um caractere especial (ex: `!`, `@`, `#`, `$`, `%`, `*`).

## Entrada
A entrada será uma única string representando a senha que precisa ser validada.

## Saída
O programa deve retornar uma mensagem indicando se a senha atende aos requisitos. Caso não atenda, deve fornecer o feedback apropriado.

## Exemplos de Teste

| Entrada | Saída Esperada |
| :--- | :--- |
| `0101` | `Sua senha e muito curta. Recomenda-se no minimo 8 caracteres.` |
| `030609saturno*` | `Sua senha atende aos requisitos de seguranca. Parabens!` |
| `010203Jupiter` | `Sua senha nao atende aos requisitos de seguranca.` |
