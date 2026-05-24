# Utilização de Helpers para Lógica de Visualização Compartilhada

Os **Helpers** no Rails são módulos Ruby projetados para extrair a lógica de apresentação das suas Views, mantendo-as limpas, legíveis e fáceis de manter (princípio DRY - Don't Repeat Yourself).

---

## 1. O que é um Helper?

Um Helper é um método que reside em `app/helpers/` e está disponível automaticamente para as suas Views. Eles servem para formatar dados, gerar HTML complexo ou lidar com condicionais de interface.

### Por que usar?
- **View Limpa:** Evita blocos grandes de código Ruby dentro do HTML.
- **Reutilização:** Um método definido em um helper pode ser usado em várias views.
- **Testabilidade:** É mais fácil testar um método Ruby puro do que lógica embutida em um template ERB.

---

## 2. Criando um Helper Customizado

Imagine que você quer exibir um "badge" de status (Ativo/Inativo) com cores diferentes em várias partes do sistema.

**Onde criar:** `app/helpers/application_helper.rb` (para uso global) ou `app/helpers/produtos_helper.rb` (específico).

```ruby
# app/helpers/application_helper.rb
module ApplicationHelper
  def status_badge(ativo)
    content = ativo ? "Ativo" : "Inativo"
    css_class = ativo ? "badge-success" : "badge-danger"
    
    content_tag(:span, content, class: "badge #{css_class}")
  end
end
```

**Como usar na View:**
```html
<p>Status do Produto: <%= status_badge(@produto.ativo) %></p>
```

---

## 3. Helpers Nativos do Rails

O Rails já vem com dezenas de helpers poderosos:

- **Formatação:** `number_to_currency(10.5)`, `time_ago_in_words(Time.now)`, `truncate("Texto longo", length: 10)`.
- **Navegação:** `link_to "Home", root_path`.
- **Ativos:** `image_tag "logo.png"`, `stylesheet_link_tag "style"`.
- **Formulários:** `form_with`, `text_field`, `check_box`.

---

## 4. Trabalhando com HTML nos Helpers (`content_tag`)

Ao gerar HTML dentro de um helper, evite concatenar strings manualmente. Use o `content_tag` ou `tag` para garantir que o HTML seja gerado com segurança.

**Exemplo:**
```ruby
def link_com_icone(texto, caminho, icone_class)
  link_to(caminho) do
    content_tag(:i, "", class: icone_class) + " " + texto
  end
end
```

---

## 5. Boas Práticas

1. **Lógica Simples:** Helpers devem lidar apenas com **formatação** e **apresentação**. Lógica de negócio pesada deve ficar no Model.
2. **Nomes Claros:** Use nomes descritivos como `formatar_data_brasileira(data)` em vez de apenas `formatar(data)`.
3. **Evite Variáveis de Instância:** Tente passar os dados necessários como argumentos para o método do helper, em vez de acessar `@produto` diretamente dentro dele. Isso torna o helper mais fácil de testar.
