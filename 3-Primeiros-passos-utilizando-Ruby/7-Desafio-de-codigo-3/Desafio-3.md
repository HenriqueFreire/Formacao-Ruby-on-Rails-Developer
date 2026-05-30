# Desafio 3: Cofres Seguros - Herança e Polimorfismo

## Objetivo
Desenvolver um sistema para gerenciar dois tipos de cofres: um **Cofre Digital** (aberto por senha numérica) e um **Cofre Físico** (aberto por chave).

## Tipos de Cofres
1. **Cofre Digital:**
   - Solicita uma senha numérica.
   - Solicita confirmação da senha.
   - Valida se as senhas coincidem.
2. **Cofre Físico:**
   - Não requer senha (abertura por chave física).

## Entrada
1. O tipo de cofre: `digital` ou `fisico`.
2. Se for `digital`:
   - Uma senha (inteiro).
   - Uma confirmação de senha (inteiro).

## Saída
Exibir o tipo do cofre, o método de abertura e o status da validação (se digital).

## Exemplos de Teste

| Entrada | Saída Esperada |
| :--- | :--- |
| `digital`<br>`12345`<br>`1234` | `Tipo: Cofre Digital`<br>`Metodo de abertura: Senha`<br>`Senha incorreta!` |
| `fisico` | `Tipo: Cofre Fisico`<br>`Metodo de abertura: Chave` |
| `digital`<br>`2525`<br>`2525` | `Tipo: Cofre Digital`<br>`Metodo de abertura: Senha`<br>`Cofre aberto!` |
