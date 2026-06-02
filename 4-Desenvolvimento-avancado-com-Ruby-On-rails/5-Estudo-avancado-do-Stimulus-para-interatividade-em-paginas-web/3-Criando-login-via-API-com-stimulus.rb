# Criando Login via API com Stimulus

Integrar um formulário de login com uma API usando Stimulus permite uma experiência de usuário fluida, sem recarregamentos de página, e com feedback em tempo real.

---

## 1. Estrutura do Formulário HTML (View)

Utilizamos `data-controller`, `data-target` e `data-action` para conectar o HTML ao nosso controller JavaScript.

```html
<!-- app/views/sessions/new.html.erb -->
<div data-controller="login">
  <div data-login-target="message" class="alert d-none"></div>

  <form data-action="submit->login#submit">
    <div>
      <label>Email:</label>
      <input type="email" data-login-target="email" required>
    </div>

    <div>
      <label>Senha:</label>
      <input type="password" data-login-target="password" required>
    </div>

    <button type="submit" data-login-target="submitButton">Entrar</button>
  </form>
</div>
```

---

## 2. O Controller Stimulus (JavaScript)

Aqui lidamos com a captura dos dados, a chamada de rede (`fetch`) e a manipulação da resposta.

```javascript
// app/javascript/controllers/login_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "email", "password", "message", "submitButton" ]

  async submit(event) {
    event.preventDefault() // Impede o envio tradicional do formulário

    this.lockButton()
    this.hideMessage()

    const credentials = {
      email: this.emailTarget.value,
      password: this.passwordTarget.value
    }

    try {
      const response = await fetch("/api/v1/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ user: credentials })
      })

      const data = await response.json()

      if (response.ok) {
        // Sucesso: Salva o token (se houver) e redireciona
        localStorage.setItem("auth_token", data.token)
        window.location.href = "/dashboard"
      } else {
        // Erro da API (ex: 401 Unauthorized)
        this.showMessage(data.error || "Credenciais inválidas", "alert-danger")
      }
    } catch (error) {
      this.showMessage("Erro ao conectar ao servidor", "alert-danger")
    } finally {
      this.unlockButton()
    }
  }

  // Helpers de UI
  lockButton() {
    this.submitButtonTarget.disabled = true
    this.submitButtonTarget.textContent = "Carregando..."
  }

  unlockButton() {
    this.submitButtonTarget.disabled = false
    this.submitButtonTarget.textContent = "Entrar"
  }

  showMessage(text, className) {
    this.messageTarget.textContent = text
    this.messageTarget.className = `alert ${className}`
    this.messageTarget.classList.remove("d-none")
  }

  hideMessage() {
    this.messageTarget.classList.add("d-none")
  }
}
```

---

## 3. Considerações Importantes

1.  **Segurança (CSRF)**: Sempre inclua o `X-CSRF-Token` nos headers de requisições POST para evitar erros de autenticidade do Rails.
2.  **Tokens**: Em aplicações Rails tradicionais, o login via API pode retornar um JWT ou apenas criar uma sessão no cookie. Se for JWT, o Stimulus pode salvá-lo no `localStorage` ou `sessionStorage`.
3.  **Feedback Visual**: Note como usamos `targets` para desabilitar o botão e exibir mensagens de erro sem precisar recarregar a página.
4.  **Endpoint API**: Certifique-se de que seu controller Rails (`Api::V1::SessionsController`) está respondendo em formato JSON.

---

## Resumo do Fluxo
1. Usuário clica em "Entrar".
2. `login#submit` é disparado.
3. JavaScript coleta os valores dos `targets`.
4. `fetch` envia os dados para a API.
5. Resposta é processada: redirecionamento em caso de sucesso ou mensagem de erro em caso de falha.
