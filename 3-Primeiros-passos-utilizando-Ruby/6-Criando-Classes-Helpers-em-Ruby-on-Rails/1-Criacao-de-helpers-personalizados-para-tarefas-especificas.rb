# Criação de Helpers Personalizados para Tarefas Específicas

Além dos helpers genéricos, muitas vezes precisamos de lógica de visualização ligada ao domínio do nosso negócio. Aqui exploramos como criar métodos para tarefas especializadas.

---

## 1. Formatando Dados Brasileiros

Muitas aplicações no Brasil precisam formatar CPFs, CNPJs ou Telefones. Centralizar isso em um helper evita repetição e facilita mudanças de padrão.

```ruby
# app/helpers/formatacao_helper.rb
module FormatacaoHelper
  def formatar_cpf(cpf)
    return "" if cpf.blank?
    # Ex: 12345678901 -> 123.456.789-01
    cpf.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
  end

  def formatar_telefone(telefone)
    return "" if telefone.blank?
    # Ex: 11988887777 -> (11) 98888-7777
    if telefone.length == 11
      telefone.gsub(/(\d{2})(\d{5})(\d{4})/, '(\1) \2-\3')
    else
      telefone.gsub(/(\d{2})(\d{4})(\d{4})/, '(\1) \2-\3')
    end
  end
end
```

---

## 2. Menu de Navegação Ativo

Um problema comum é destacar o item do menu correspondente à página onde o usuário está.

```ruby
# app/helpers/nav_helper.rb
module NavHelper
  def menu_item_class(path)
    # Retorna a classe 'active' se a URL atual for igual ao caminho passado
    current_page?(path) ? "nav-link active" : "nav-link"
  end
end
```

**Uso na View:**
```html
<li class="nav-item">
  <%= link_to "Início", root_path, class: menu_item_class(root_path) %>
</li>
```

---

## 3. Helpers para Lógica Condicional Complexa

Evite colocar múltiplos `if/else` dentro do seu HTML. Extraia para o helper.

```ruby
# app/helpers/vendas_helper.rb
module VendasHelper
  def link_acao_venda(venda)
    case venda.status
    when 'pendente'
      link_to 'Pagar Agora', checkout_path(venda), class: 'btn btn-primary'
    when 'pago'
      link_to 'Ver Recibo', recibo_path(venda), class: 'btn btn-secondary'
    when 'cancelado'
      content_tag(:span, 'Venda Cancelada', class: 'text-muted')
    end
  end
end
```

---

## 4. Gerando Grids ou Listas Customizadas

Se você repete muito uma estrutura de "Card" ou "Tabela", pode criar um helper que receba um objeto e gere o HTML.

```ruby
def card_informativo(titulo, valor, cor_bg = 'bg-primary')
  content_tag(:div, class: "card text-white #{cor_bg} mb-3") do
    content_tag(:div, class: 'card-body') do
      content_tag(:h5, titulo, class: 'card-title') +
      content_tag(:p, valor, class: 'card-text h2')
    end
  end
end
```

---

## 5. Quando usar um Helper vs um Decorator/Presenter?

Se o seu helper começar a ficar muito grande ou você precisar de muitos métodos específicos para um único modelo (ex: `app/helpers/usuarios_helper.rb` com 30 métodos), considere usar uma Gem como **Draper** ou o padrão **Decorator/Presenter**. Isso permite tratar a lógica de visualização como um objeto em vez de apenas métodos soltos em módulos.
