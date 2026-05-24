# Trabalhando com o Método DELETE para Excluir Registros

A exclusão de registros no Rails envolve entender tanto a operação no banco de dados (Active Record) quanto a interface do usuário (Views/Links).

---

## 1. No Modelo: delete vs destroy

Existem duas formas principais de remover um registro no banco de dados via Active Record:

### `destroy` (Recomendado)
Carrega o objeto, executa os **callbacks** (como `before_destroy`) e as dependências (como `dependent: :destroy`) antes de apagar.
```ruby
produto = Produto.find(1)
produto.destroy
```

### `delete`
Apaga o registro diretamente no banco de dados via SQL. **Não** executa callbacks nem validações. É mais rápido, porém mais perigoso.
```ruby
Produto.delete(1)
```

---

## 2. No Controlador: A Ação destroy

Por padrão, a ação que gerencia a exclusão é a `destroy`.

```ruby
class ProdutosController < ApplicationController
  def destroy
    @produto = Produto.find(params[:id])
    @produto.destroy

    respond_to do |format|
      # Redireciona o usuário após a exclusão
      format.html { redirect_to produtos_url, notice: "Produto removido com sucesso." }
      format.json { head :no_content }
    end
  end
end
```

---

## 3. Na View: Criando o Link de Exclusão

Como navegadores não suportam nativamente o método HTTP `DELETE` em links (`<a>`), o Rails utiliza o **Turbo** (ou Rails UJS em versões antigas) para simular essa requisição.

### Em Rails 7+ (Com Turbo)
Usamos o atributo `data: { turbo_method: :delete }`.

```erb
<%= link_to "Excluir Produto", product_path(@produto), 
            data: { turbo_method: :delete, turbo_confirm: "Tem certeza?" } %>
```

### Usando button_to
O `button_to` cria um formulário real, o que é mais semântico para operações que alteram dados.

```erb
<%= button_to "Apagar", @produto, method: :delete, confirm: "Confirmar?" %>
```

---

## 4. Por que usar Confirmação?

Sempre adicione um pedido de confirmação (`turbo_confirm`) em ações de exclusão para evitar que o usuário apague dados por acidente ao clicar no botão errado.

```erb
data: { turbo_confirm: "Esta ação não pode ser desfeita. Continuar?" }
```

---

## 5. Exclusão em Massa

Se precisar apagar vários registros de uma vez:

```ruby
# Executa callbacks para cada um
Produto.where(ativo: false).destroy_all

# Apaga direto via SQL (rápido, sem callbacks)
Produto.where(ativo: false).delete_all
```
