# Desafio 5: Gerenciador de Usuários com Singleton

## Objetivo
Implementar um sistema de gerenciamento de usuários utilizando o padrão de projeto **Singleton**. O Singleton garante que uma classe tenha apenas uma única instância em toda a aplicação, o que é útil para gerenciar recursos compartilhados.

## Especificações

### 1. Classe `User`
Atributos:
- `id`: Inteiro (gerado automaticamente conforme a ordem de inserção).
- `name`: String.

### 2. Classe `UserManager` (Singleton)
Funcionalidades:
- **Adicionar Usuário:** Recebe um nome e cria um novo objeto `User`.
- **Listar Usuários:** Retorna todos os usuários cadastrados.

## Entrada
1. Um número inteiro representando a quantidade de usuários a cadastrar.
2. Os nomes dos usuários (uma string por linha).

## Saída
Uma lista numerada com os nomes dos usuários cadastrados.

## Exemplos de Teste

| Entrada | Saída Esperada |
| :--- | :--- |
| `2`<br>`Ada`<br>`Linus` | `1 - Ada`<br>`2 - Linus` |
| `3`<br>`Grace`<br>`Alan`<br>`Steve` | `1 - Grace`<br>`2 - Alan`<br>`3 - Steve` |
| `4`<br>`Tim`<br>`Margaret`<br>`John`<br>`Richard` | `1 - Tim`<br>`2 - Margaret`<br>`3 - John`<br>`4 - Richard` |
