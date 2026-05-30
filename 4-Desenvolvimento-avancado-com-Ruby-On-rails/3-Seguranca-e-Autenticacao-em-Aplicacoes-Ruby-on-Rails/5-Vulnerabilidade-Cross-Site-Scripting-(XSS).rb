# Vulnerabilidade Cross-Site Scripting (XSS) no Ruby on Rails

O **Cross-Site Scripting (XSS)** é uma vulnerabilidade onde um atacante injeta scripts maliciosos (geralmente JavaScript) em páginas web visualizadas por outros usuários. Se não for tratada, pode permitir o roubo de cookies de sessão, redirecionamentos maliciosos ou alteração do conteúdo da página.

## 1. Como o Rails protege você (ERB Escaping)

Por padrão, o Ruby on Rails é muito seguro contra XSS. Desde a versão 3.0, todas as strings renderizadas em templates ERB são automaticamente "escapadas".

### Exemplo de Proteção Padrão:
Se um usuário cadastrar seu nome como:
`<script>alert('XSS!');</script>`

Ao renderizar na view:
```erb
<%= @user.name %>
```
O Rails transformará os caracteres especiais em entidades HTML:
`&lt;script&gt;alert('XSS!');&lt;/script&gt;`
O navegador exibirá o texto literalmente em vez de executar o script.

---

## 2. Como as vulnerabilidades são introduzidas

O risco surge quando o desenvolvedor explicitamente diz ao Rails para **não** escapar o conteúdo, geralmente para renderizar HTML que ele considera confiável.

### Métodos Perigosos:
- `raw()`
- `html_safe`
- `<%== ... %>` (shorthand para `raw`)

### Exemplo de Vulnerabilidade:
```erb
<%# PERIGOSO: Se @comment.body vier de um input de usuário sem filtro %>
<div class="comment">
  <%= raw @comment.body %>
</div>
```
Se o corpo do comentário contiver um script, ele será executado no navegador de quem ler o comentário.

---

## 3. Tipos de XSS

1.  **Stored XSS (Persistente)**: O script malicioso é salvo permanentemente no banco de dados (ex: comentários, perfis). É o mais perigoso.
2.  **Reflected XSS (Refletido)**: O script é enviado via parâmetros da URL e "refletido" na resposta imediata (ex: mensagens de busca ou erro).
3.  **DOM-based XSS**: A vulnerabilidade existe puramente no código JavaScript do lado do cliente, manipulando o DOM de forma insegura.

---

## 4. Melhores Práticas de Prevenção

### A. Use `sanitize` em vez de `raw`
Se você precisa permitir algumas tags HTML (como `<b>` ou `<i>`), use o helper `sanitize`. Ele remove tags e atributos perigosos (como `<script>` ou `onmouseover`).

```erb
<%# SEGURO: Permite apenas tags seguras %>
<%= sanitize @comment.body %>
```

### B. Content Security Policy (CSP)
O Rails permite configurar uma CSP, que é uma camada extra de segurança que diz ao navegador quais fontes de scripts são confiáveis.

```ruby
# config/initializers/content_security_policy.rb
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.script_src  :self, "https://trusted.cdn.com"
end
```

### C. Nunca confie no Input do Usuário
Sempre assuma que qualquer dado vindo de formulários ou URLs é malicioso.

## Resumo
A regra de ouro no Rails é: **evite `raw` e `html_safe` a todo custo**. Se precisar renderizar HTML dinâmico, utilize o `sanitize` com uma lista rigorosa de tags permitidas.
