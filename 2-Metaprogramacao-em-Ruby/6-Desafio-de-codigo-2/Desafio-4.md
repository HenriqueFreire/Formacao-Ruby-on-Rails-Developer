# Desafio 4: Sistema de Combate RPG - Herança

## Contexto
Em jogos de RPG, personagens compartilham características básicas, mas possuem especializações. Este desafio explora o conceito de **Herança** para criar personagens e suas subclasses de combate.

## Objetivo
Criar uma estrutura de herança onde uma `Subclasse` herda de `Personagem`, adicionando funcionalidades de cálculo de dano.

## Requisitos
1. **Classe `Personagem`:**
   - Atributos: `nome`, `mana`.
2. **Classe `Subclasse` (Herda de `Personagem`):**
   - Atributo adicional: `dano_base`.
   - Método `calcular_dano`: Recebe a `mana_usada` e retorna o resultado de `dano_base * mana_usada`.

## Entrada
O programa receberá:
1. `nome` (String)
2. `mana` (Integer) - *Nota: No contexto do desafio, este valor será usado como multiplicador de dano no ataque.*
3. `dano_base` (Integer)

## Saída
Uma mensagem formatada:
`[nome] atacou e causou [dano_total] de dano!`

---

## Exemplos
| Entrada | Saída |
| :--- | :--- |
| sauron <br> 30 <br> 30 | sauron atacou e causou 900 de dano! |
| frodo <br> 10 <br> 5 | frodo atacou e causou 50 de dano! |
| legolas <br> 23 <br> 20 | legolas atacou e causou 460 de dano! |
