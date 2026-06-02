# O que é o Stimulus?

Stimulus é um framework JavaScript modesto e focado em melhorar o HTML que você já tem. Ao contrário de frameworks pesados como React ou Vue, o Stimulus não tenta criar todo o seu front-end; ele apenas adiciona comportamento ao seu HTML de forma organizada e declarativa.

Ele funciona conectando objetos JavaScript (chamados de **Controllers**) a elementos na sua página através de atributos `data-`.

---

## Os Três Pilares do Stimulus

### 1. Controllers
É a classe JavaScript que define o comportamento. Ela é vinculada a um elemento HTML via `data-controller`.

### 2. Targets (Alvos)
São referências a elementos específicos dentro do controller para que você possa manipulá-los facilmente. Definidos via `data-[controller-name]-target`.

### 3. Actions (Ações)
São os métodos no controller que são disparados por eventos do DOM (como `click`, `submit`, `input`). Definidos via `data-action`.

---

## Exemplo Prático: Um Contador Simples

### Passo 1: O HTML (View)
No seu arquivo `.html.erb`, você define a estrutura e os atributos do Stimulus:

```html
<div data-controller="hello">
  <input type="text" data-hello-target="name" placeholder="Digite seu nome">
  
  <button data-action="click->hello#greet">
    Cumprimentar
  </button>

  <h1 data-hello-target="output"></h1>
</div>
```

### Passo 2: O Controller JavaScript
No seu arquivo `app/javascript/controllers/hello_controller.js`:

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Define os alvos que queremos acessar
  static targets = [ "name", "output" ]

  greet() {
    // Acessamos os elementos através de this.[nome]Target
    const name = this.nameTarget.value
    this.outputTarget.textContent = `Olá, ${name}!`
  }
}
```

---

## Por que usar Stimulus com Rails?

1.  **HTML First**: Você continua escrevendo HTML no servidor, o que é ótimo para SEO e velocidade.
2.  **Organização**: Evita o "Espaguete de jQuery" ao encapsular a lógica em controllers reutilizáveis.
3.  **Hotwire**: Ele é parte integrante do ecossistema Hotwire (junto com Turbo), permitindo criar aplicações SPA-like sem a complexidade de uma SPA real.
4.  **Estado no DOM**: O estado da aplicação vive no HTML (atributos `data-`), tornando-o fácil de depurar.

---

## Resumo
O Stimulus é perfeito para pequenas interatividades: abrir modais, atualizar contadores, habilitar botões após validação, ou qualquer comportamento que precise de um "toque" de JavaScript sem reinventar a roda.
