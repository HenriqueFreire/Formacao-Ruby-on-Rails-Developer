# Internacionalização (i18n) no Ruby on Rails

A internacionalização permite que sua aplicação suporte múltiplos idiomas e formatos regionais (como datas e moedas) sem alterar o código-fonte.

## 1. Configuração Inicial
Por padrão, o Rails vem configurado para o inglês (`en`). Para alterar o idioma padrão para Português do Brasil, você deve editar o arquivo `config/application.rb`:

```ruby
# config/application.rb
module SuaApp
  class Application < Rails::Application
    # Define o idioma padrão
    config.i18n.default_locale = :'pt-BR'
    
    # Opcional: define quais idiomas são permitidos
    config.i18n.available_locales = [:en, :'pt-BR']
  end
end
```

## 2. Arquivos de Tradução (YAML)
As traduções ficam localizadas no diretório `config/locales/`. Elas seguem uma estrutura de dicionário em arquivos `.yml`.

**Exemplo: Português (`config/locales/pt-BR.yml`)**
```yaml
pt-BR:
  hello: "Olá Mundo"
  welcome: "Bem-vindo ao sistema, %{name}!"
  items:
    one: "1 item"
    other: "%{count} itens"
```

**Exemplo: Inglês (`config/locales/en.yml`)**
```yaml
en:
  hello: "Hello World"
  welcome: "Welcome to the system, %{name}!"
  items:
    one: "1 item"
    other: "%{count} items"
```

## 3. Utilizando Traduções no Código
No Rails, você usa o método `I18n.t` (ou apenas `t` em views e controllers).

```ruby
# Tradução simples
I18n.t('hello') # => "Olá Mundo"

# Com interpolação de variáveis
I18n.t('welcome', name: 'Henrique') # => "Bem-vindo ao sistema, Henrique!"

# Pluralização
I18n.t('items', count: 1) # => "1 item"
I18n.t('items', count: 5) # => "5 itens"
```

## 4. Localização (Datas e Números)
O método `I18n.l` (ou `l`) é usado para formatar objetos que dependem da região, como datas e valores monetários.

```ruby
# Formatação de data (precisa estar definido no YAML de locale)
I18n.l(Time.now, format: :short)
```

## 5. Tradução de Models (Active Record)
Você pode traduzir nomes de modelos e atributos para que as mensagens de erro automáticas do Rails fiquem no idioma correto:

```yaml
# config/locales/pt-BR.yml
pt-BR:
  activerecord:
    models:
      user: "Usuário"
    attributes:
      user:
        name: "Nome Completo"
        email: "E-mail"
```

Desta forma, uma mensagem de erro de validação como "Name can't be blank" passará a ser "Nome Completo não pode ficar em branco".
