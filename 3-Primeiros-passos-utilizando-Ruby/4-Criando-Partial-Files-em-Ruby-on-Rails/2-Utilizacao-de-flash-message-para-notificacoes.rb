# Utilização de Flash Messages para Notificações

As `flash messages` são uma forma de passar mensagens temporárias de um controller para a view. Elas são amplamente utilizadas para dar feedback ao usuário após uma ação (ex: "Produto criado com sucesso" ou "Erro ao deletar item").

---

## 1. Como funcionam?
O objeto `flash` funciona como um hash que armazena dados apenas para a **próxima requisição**. Após ser exibida ou após o próximo carregamento de página, a mensagem é automaticamente descartada.

As chaves mais comuns são:
- `:notice`: Para mensagens de sucesso ou informativas.
- `:alert`: Para mensagens de erro ou avisos críticos.

---

## 2. Definindo mensagens no Controller

Você pode definir uma mensagem flash de duas formas:

### A. Através do método `redirect_to` (Mais comum):
```ruby
def create
  @produto = Produto.new(produto_params)
  if @produto.save
    redirect_to @produto, notice: "Produto criado com sucesso!"
  else
    render :new, status: :unprocessable_entity
  end
end
```

### B. Através do hash `flash` diretamente:
```ruby
def destroy
  @produto.destroy
  flash[:alert] = "O produto foi removido permanentemente."
  redirect_to produtos_path
end
```

---

## 3. Exibindo mensagens na View

Para que o usuário veja as mensagens, você deve renderizá-las no seu layout global (`application.html.erb`).

### Exemplo Simples:
```erb
<% if flash[:notice] %>
  <div class="notice"><%= flash[:notice] %></div>
<% end %>

<% if flash[:alert] %>
  <div class="alert"><%= flash[:alert] %></div>
<% end %>
```

### Exemplo Robusto (Iterando sobre todas as chaves):
Esta forma é melhor pois captura qualquer chave personalizada que você criar.
```erb
<% flash.each do |type, message| %>
  <div class="flash <%= type %>">
    <%= message %>
  </div>
<% end %>
```

---

## 4. O uso de `flash.now`
Quando você usa `render` em vez de `redirect_to` (comum em erros de validação), o `flash` padrão não funcionará corretamente porque ele espera uma nova requisição. Nesses casos, use `flash.now`.

```ruby
def create
  @produto = Produto.new(produto_params)
  if @produto.save
    # ...
  else
    flash.now[:alert] = "Por favor, corrija os erros abaixo."
    render :new
  end
end
```

---

## 5. Diferença Visual (CSS sugerido)
```css
.flash.notice {
  background-color: #d4edda;
  color: #155724;
  padding: 10px;
  border: 1px solid #c3e6cb;
}

.flash.alert {
  background-color: #f8d7da;
  color: #721c24;
  padding: 10px;
  border: 1px solid #f5c6cb;
}
```
