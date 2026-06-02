# Nova Verificação: Validação em Tempo Real com Stimulus

Uma das melhores aplicações do Stimulus é realizar verificações no servidor enquanto o usuário ainda está preenchendo o formulário (ex: checar se um email já está cadastrado).

---

## 1. Exemplo: Verificação de Disponibilidade de Usuário

Neste exemplo, verificamos se um nome de usuário está disponível assim que ele termina de digitar (evento `blur` ou `input`).

### Estrutura HTML (View)

```html
<div data-controller="user-verification">
  <label>Nome de Usuário:</label>
  <input type="text" 
         data-user-verification-target="input" 
         data-action="blur->user-verification#check">
  
  <span data-user-verification-target="result"></span>
</div>
```

---

## 2. O Controller Stimulus (JavaScript)

O controller envia o valor digitado para um endpoint da API e atualiza a interface com o resultado.

```javascript
// app/javascript/controllers/user_verification_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "result" ]

  async check() {
    const username = this.inputTarget.value
    if (username.length < 3) return

    this.resultTarget.textContent = "Verificando..."
    this.resultTarget.className = "text-muted"

    try {
      const response = await fetch(`/api/v1/users/check_availability?username=${username}`)
      const data = await response.json()

      if (data.available) {
        this.resultTarget.textContent = "Disponível!"
        this.resultTarget.className = "text-success"
        this.inputTarget.classList.remove("is-invalid")
        this.inputTarget.classList.add("is-valid")
      } else {
        this.resultTarget.textContent = "Já está em uso."
        this.resultTarget.className = "text-danger"
        this.inputTarget.classList.remove("is-valid")
        this.inputTarget.classList.add("is-invalid")
      }
    } catch (error) {
      this.resultTarget.textContent = "Erro ao verificar"
    }
  }
}
```

---

## 3. Lado do Servidor (Rails Controller)

A API deve ser rápida e retornar um JSON simples.

```ruby
# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ActionController::API
  def check_availability
    exists = User.exists?(username: params[:username])
    render json: { available: !exists }
  end
end
```

---

## 4. Benefícios desta abordagem

1.  **Feedback Instantâneo**: O usuário não precisa clicar em "Enviar" para descobrir que o nome já existe.
2.  **Menos Erros de Submissão**: Reduz o número de vezes que o formulário é enviado com dados inválidos.
3.  **Performance**: Por ser uma requisição leve via `fetch`, não sobrecarrega o servidor e mantém a página rápida.

---

## Dica de Ouro: Debounce
Se você usar o evento `input` em vez de `blur`, é recomendado usar uma técnica de **debounce** para não disparar uma requisição a cada tecla digitada.

```javascript
// Exemplo simples de debounce no Stimulus
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // ... targets ...
  
  check() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.performCheck()
    }, 500) // Aguarda 500ms após a última tecla
  }
  
  async performCheck() {
    // ... lógica do fetch ...
  }
}
```
