# Trabalhando com Scaffold e Inflections em Rails

O Rails é famoso pela sua produtividade, e dois conceitos fundamentais para isso são o **Scaffold** (geração automática de código) e as **Inflections** (regras de pluralização).

---

## 1. Scaffold: O Gerador Completo

O `scaffold` é um gerador que cria, com um único comando, toda a estrutura necessária para um recurso (CRUD completo):
- Migração para o banco de dados.
- Modelo (Model).
- Controlador (Controller) com as 7 ações padrão.
- Visualizações (Views) para listar, exibir, criar e editar.
- Arquivo de estilos (CSS) e testes básicos.

**Exemplo de comando:**
```bash
bin/rails generate scaffold Categoria nome:string descricao:text
```

### Quando usar?
O scaffold é excelente para prototipagem rápida ou para partes simples da aplicação (como cadastros básicos). Para lógicas muito complexas, desenvolvedores costumam gerar cada parte separadamente.

---

## 2. Inflections (Inflexões)

O Rails utiliza uma biblioteca chamada **ActiveSupport** para converter palavras entre singular e plural (ex: `Product` vira `products`). Isso é vital para que as convenções de nomes (Model no singular, Controller no plural) funcionem.

No entanto, o Rails é otimizado para o inglês. Para palavras em português ou palavras irregulares, precisamos configurar as **Inflections**.

### Configurando em config/initializers/inflections.rb

Se você criar um modelo chamado `País`, o Rails pode tentar pluralizar para `Paíss`. Você deve corrigir isso:

```ruby
# config/initializers/inflections.rb
ActiveSupport::Inflector.inflections(:en) do |inflect|
  # Define que o plural de 'pais' é 'paises'
  inflect.irregular 'pais', 'paises'
  
  # Define que palavras terminadas em 'ao' pluralizam para 'oes'
  inflect.plural /([^aeou])ao$/i, '\1oes'
  inflect.singular /([^aeou])oes$/i, '\1ao'

  # Palavras que são iguais no singular e plural
  inflect.uncountable %w( tenis lanchonete )
end
```

---

## 3. Por que isso é importante?

Se as inflexões não estiverem corretas, o Rails não conseguirá encontrar as tabelas no banco de dados ou os controladores correspondentes, resultando em erros de `Routing Error` ou `Table not found`.

**Exemplo de erro comum:**
- Model: `Postagem`
- Rails espera a tabela: `postagems` (Incorreto no português)
- Com Inflection correta, o Rails buscará: `postagens` (Correto)

---

## 4. Testando Inflexões no Console

Você pode verificar como o Rails está transformando as palavras usando o `bin/rails console`:

```ruby
"postagem".pluralize
# => "postagens" (Se configurado corretamente)

"paises".singularize
# => "pais"
```

---

## 5. Destruindo um Scaffold

Se você cometer um erro ao gerar um scaffold, pode desfazê-lo facilmente:

```bash
bin/rails destroy scaffold Categoria
```
*(Lembre-se de reverter a migração com `db:rollback` antes de destruir, se já tiver rodado o migrate).*
