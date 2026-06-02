# Refatorando: Escrevendo Controllers Stimulus mais Limpos

Refatorar no Stimulus geralmente significa mover lógica do JavaScript para o HTML (via atributos de configuração) e utilizar as APIs nativas do framework para evitar manipular o DOM manualmente com strings.

---

## 1. Usando Stimulus "Values" (Substituindo data-attributes manuais)

Em vez de usar `this.element.getAttribute("data-url")`, use a API de `Values`. Ela lida com tipos de dados automaticamente.

### Antes (Código "Sujo"):
```javascript
// JavaScript
connect() {
  this.url = this.element.getAttribute("data-url")
  this.timeout = parseInt(this.element.getAttribute("data-timeout"))
}
```

### Depois (Refatorado):
```javascript
// JavaScript
export default class extends Controller {
  static values = { url: String, timeout: { type: Number, default: 500 } }

  connect() {
    console.log(this.urlValue)      // Acessa automaticamente
    console.log(this.timeoutValue)  // Já convertido para Number
  }
}
```
*HTML correspondente:* `<div data-controller="exemplo" data-exemplo-url-value="/api" data-exemplo-timeout-value="1000"></div>`

---

## 2. Usando Stimulus "Classes" (Substituindo toggle de strings)

Evite hardcodar nomes de classes CSS no seu JavaScript. Use o atributo `Classes` para tornar seu controller reutilizável com diferentes frameworks CSS (Bootstrap, Tailwind, etc).

### Antes (Código Amarrado):
```javascript
// JavaScript
marcarComoLido() {
  this.element.classList.add("bg-success", "text-white") // Hardcoded!
}
```

### Depois (Refatorado):
```javascript
// JavaScript
export default class extends Controller {
  static classes = [ "active" ]

  marcarComoLido() {
    this.element.classList.add(...this.activeClasses) // Flexível!
  }
}
```
*HTML correspondente:* `<div data-controller="exemplo" data-exemplo-active-class="bg-success text-white"></div>`

---

## 3. Aproveitando Callbacks de Ciclo de Vida

O Stimulus oferece `initialize`, `connect` e `disconnect`. Use-os para limpar recursos e evitar memory leaks.

```javascript
export default class extends Controller {
  connect() {
    // Configura um timer ou listener global
    this.timer = setInterval(() => this.refresh(), 5000)
  }

  disconnect() {
    // MUITO IMPORTANTE: Limpa o timer quando o elemento sai da página
    clearInterval(this.timer)
  }
}
```

---

## 4. Extração de Lógica Comum (Mixins)

Se você tem vários controllers que fazem coisas parecidas (como mostrar um loading), você pode criar um controller base ou usar composição.

```javascript
// app/javascript/controllers/base_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showLoading(element) {
    element.innerHTML = '<span class="spinner"></span>'
  }
}

// app/javascript/controllers/search_controller.js
import BaseController from "./base_controller"

export default class extends BaseController {
  submit() {
    this.showLoading(this.element)
    // ... restante da lógica
  }
}
```

---

## Conclusão da Refatoração
Um bom controller Stimulus:
1.  Não conhece nomes específicos de classes CSS (usa `classes`).
2.  Não faz parsing manual de atributos (usa `values`).
3.  Limpa seus próprios resíduos (usa `disconnect`).
4.  É focado em uma única responsabilidade.
