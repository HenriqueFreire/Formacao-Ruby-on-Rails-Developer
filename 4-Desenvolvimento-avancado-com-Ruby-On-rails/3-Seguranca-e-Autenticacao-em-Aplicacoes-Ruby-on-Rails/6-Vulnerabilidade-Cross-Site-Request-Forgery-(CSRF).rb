# Vulnerabilidade Cross-Site Request Forgery (CSRF) no Ruby on Rails

O **Cross-Site Request Forgery (CSRF)** é um ataque que força um usuário autenticado a executar ações indesejadas em uma aplicação web na qual ele está atualmente autenticado. Diferente do XSS, o objetivo do CSRF não é roubar dados (pois o atacante não tem como ver a resposta), mas sim **executar uma mudança de estado** (ex: alterar senha, deletar conta, fazer uma transferência).

## 1. Como o Ataque Funciona

O ataque baseia-se no fato de que os navegadores enviam automaticamente os cookies de um site em todas as requisições feitas para esse site, mesmo que a requisição tenha sido originada de um site diferente.

### Exemplo de Cenário:
1. Você está logado no seu banco `meubanco.com`.
2. O banco usa um cookie de sessão para te identificar.
3. Você visita um site malicioso `site-hacker.com` em outra aba.
4. O `site-hacker.com` contém um formulário invisível que faz um POST para `meubanco.com/transferir`.
5. Seu navegador envia a requisição para o banco **junto com seu cookie de sessão**.
6. O banco vê o cookie, acha que é você e processa a transferência.

---

## 2. Exemplo de Código Malicioso

Um atacante pode usar um formulário simples que é enviado automaticamente via JavaScript assim que a página carrega:

```html
<!-- No site-hacker.com -->
<form id="csrf-form" action="https://seu-app-rails.com/usuarios/deletar" method="POST">
  <input type="hidden" name="id" value="123" />
</form>

<script>
  document.getElementById('csrf-form').submit();
</script>
```

Ou até mesmo uma tag de imagem (para ataques via GET, por isso **nunca** use GET para alterar dados):

```html
<img src="https://seu-app-rails.com/perfil/logout" style="display:none;">
```

---

## 3. Como o Rails protege você (Authenticity Token)

O Rails possui proteção nativa contra CSRF através do `authenticity_token`.

### O Mecanismo:
1. O Rails gera um token único para a sessão do usuário.
2. Esse token é inserido em todos os formulários gerados pelo Rails (`form_with`, `form_for`).
3. Quando o formulário é enviado, o Rails compara o token recebido com o token da sessão.
4. Se os tokens não coincidirem ou o token estiver faltando, o Rails bloqueia a requisição.

### No seu HTML (gerado automaticamente):
```html
<form action="/posts" method="post">
  <input type="hidden" name="authenticity_token" value="abc123xyz..." />
  <!-- ... outros campos ... -->
</form>
```

---

## 4. Configuração no Rails

A proteção é ativada globalmente no `ApplicationController`:

```ruby
class ApplicationController < ActionController::Base
  # Garante que todas as requisições POST, PUT, PATCH e DELETE tenham o token
  protect_from_forgery with: :exception
end
```

### Estratégias de Falha:
- `:exception`: Lança uma exceção `ActionController::InvalidAuthenticityToken`.
- `:null_session`: Limpa a sessão durante aquela requisição (comum em APIs que usam tokens manuais).
- `:reset_session`: Reseta toda a sessão do usuário.

---

## 5. Cuidados Importantes

### A. Nunca use GET para alterar dados
A especificação HTTP diz que GET deve ser "seguro" (apenas leitura). O Rails não verifica tokens CSRF em requisições GET.

### B. Requisições AJAX
Para requisições JavaScript (Fetch ou jQuery), você deve incluir o token no cabeçalho `X-CSRF-Token`. O Rails facilita isso com uma tag meta:

```erb
<%= csrf_meta_tags %>
```

O JavaScript então lê essa tag e envia no header da requisição.

### C. Desabilitando (Com Cuidado)
Se você estiver criando uma API que usa JWT ou outros métodos de autenticação que não dependem de cookies, você pode precisar pular a verificação:

```ruby
class ApiController < ActionController::API
  # APIs que não usam cookies para autenticação não precisam de CSRF
  # Mas cuidado para não abrir brechas se ainda houver sessão via cookie
  skip_before_action :verify_authenticity_token
end
```

## Resumo
O CSRF explora a confiança que um site tem no navegador do usuário. A melhor defesa é sempre usar as ferramentas padrão do Rails (`form_with`), garantir que `protect_from_forgery` esteja ativo e **nunca** realizar alterações de estado via requisições GET.
