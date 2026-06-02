# Criando Tradução para a Página Home no Ruby on Rails

Para manter as traduções organizadas e fáceis de manter, o Rails recomenda seguir a estrutura de diretórios das views dentro dos arquivos YAML.

## 1. Organização dos Arquivos YAML
Supondo que sua página inicial seja renderizada pela action `index` do `HomeController`.

**Arquivo: `config/locales/pt-BR.yml`**
```yaml
pt-BR:
  home:
    index:
      title: "Página Inicial"
      welcome_message: "Bem-vindo ao nosso portal!"
      cta_button: "Saiba mais sobre nós"
      description: "Esta é uma aplicação de exemplo utilizando i18n."
```

**Arquivo: `config/locales/en.yml`**
```yaml
en:
  home:
    index:
      title: "Home Page"
      welcome_message: "Welcome to our portal!"
      cta_button: "Learn more about us"
      description: "This is an example application using i18n."
```

## 2. Utilizando na View (`app/views/home/index.html.erb`)

### A. Caminho Completo
Você pode referenciar a tradução pelo caminho absoluto definido no YAML.

```erb
<h1><%= t('home.index.title') %></h1>
<p><%= t('home.index.welcome_message') %></p>
```

### B. Lazy Lookup (Busca Automática)
O Rails possui uma funcionalidade chamada "Lazy Lookup". Se você usar um ponto (`.`) no início da chave dentro de uma view, o Rails buscará automaticamente a tradução baseada no caminho da view atual.

Se o arquivo for `app/views/home/index.html.erb`, o código abaixo buscará por `home.index.title`:

```erb
<h1><%= t('.title') %></h1>
<p><%= t('.welcome_message') %></p>
<button><%= t('.cta_button') %></button>
```

## 3. Traduzindo Elementos Globais (Header/Navigation)
Para elementos que aparecem na Home mas pertencem ao layout global, organize-os em uma chave separada:

**No YAML (`pt-BR.yml`):**
```yaml
pt-BR:
  layouts:
    navigation:
      home: "Início"
      about: "Sobre"
      contact: "Contato"
```

**No Layout (`app/views/layouts/application.html.erb`):**
```erb
<nav>
  <%= link_to t('layouts.navigation.home'), root_path %>
  <%= link_to t('layouts.navigation.about'), about_path %>
</nav>
```

## 4. Dica: Variáveis Dinâmicas
Você pode passar variáveis para as traduções da Home:

**YAML:**
```yaml
home:
  index:
    greet: "Olá, %{name}! Que bom ver você de novo."
```

**View:**
```erb
<%= t('.greet', name: current_user.name) %>
```
