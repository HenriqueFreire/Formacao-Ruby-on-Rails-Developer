# Configurando a Aplicação utilizando Stimulus

A configuração do Stimulus no Ruby on Rails evoluiu bastante, especialmente a partir do Rails 7 com o Hotwire. Existem duas formas principais de configurar: via **Importmaps** (padrão) ou via **Node.js/esbuild**.

---

## 1. Instalação em um novo projeto

Se você criar um novo projeto Rails, o Stimulus já vem configurado por padrão:
```bash
rails new minha_app
```

Se precisar adicionar a um projeto existente:
```bash
bundle add stimulus-rails
rails stimulus:install
```

---

## 2. Estrutura de Diretórios

O Rails organiza os controllers do Stimulus em:
`app/javascript/controllers/`

Nesta pasta, você encontrará:
- `index.js`: Onde a aplicação Stimulus é inicializada e os controllers são carregados automaticamente.
- `application.js`: Configura a instância global do Stimulus.
- `*_controller.js`: Seus controllers personalizados.

---

## 3. Registrando Controllers Automaticamente

O arquivo `app/javascript/controllers/index.js` gerencia o registro. 

### Com Importmaps:
O Rails usa um comando para atualizar o manifesto de controllers:
```bash
bin/rails stimulus:manifest:update
```
Isso garante que, ao criar `hello_controller.js`, ele seja mapeado para `data-controller="hello"`.

---

## 4. Exemplo de Configuração de um Novo Controller

### Passo 1: Gerar o arquivo
Você pode criar manualmente ou usar o generator:
```bash
rails generate stimulus search
```
Isso criará o arquivo `app/javascript/controllers/search_controller.js`.

### Passo 2: O conteúdo do Controller
```javascript
// app/javascript/controllers/search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Controller de busca conectado ao DOM!")
  }

  submit() {
    this.element.requestSubmit() // Exemplo de disparar o formulário
  }
}
```

### Passo 3: Ativando no HTML
```html
<form data-controller="search" data-action="input->search#submit">
  <input type="text" placeholder="Pesquisar automaticamente...">
</form>
```

---

## 5. Dicas Importantes para Configuração

1.  **Nomenclatura**: Se o arquivo for `users/profile_controller.js`, o nome no HTML será `data-controller="users--profile"`.
2.  **Debug**: Use o `connect()` para verificar se o controller está carregando corretamente. Se o log não aparecer no console do navegador, o manifesto pode estar desatualizado ou o arquivo não está na pasta correta.
3.  **Importmaps**: Verifique seu `config/importmap.rb` para garantir que `@hotwired/stimulus` está pinado corretamente.

```ruby
# config/importmap.rb
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
```
