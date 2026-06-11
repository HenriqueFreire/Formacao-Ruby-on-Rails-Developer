# Configurando Cucumber em uma aplicação Rails

Cucumber é uma ferramenta que suporta o BDD (Behavior-Driven Development). Ele permite que você descreva o comportamento do sistema em uma linguagem simples (Gherkin) que qualquer pessoa possa entender.

## 1. Adicionando as Gems necessárias

No seu arquivo `Gemfile`, adicione as seguintes gems ao grupo de `:development` e `:test`:

```ruby
group :development, :test do
  gem 'cucumber-rails', require: false
  # database_cleaner é usado para garantir um estado limpo do banco de dados entre os testes
  gem 'database_cleaner'
end
```

Após adicionar as gems, execute o comando no terminal:
```bash
bundle install
```

## 2. Instalando o Cucumber no Rails

Após instalar as gems, você precisa rodar o gerador do Cucumber para criar a estrutura de diretórios necessária (`features/`):

```bash
rails generate cucumber:install
```

Isso criará arquivos como `config/cucumber.yml`, `features/step_definitions/`, `features/support/env.rb`, etc.

## 3. Criando sua primeira Feature

Crie um arquivo chamado `features/gerenciar_usuarios.feature`:

```gherkin
# language: pt
Funcionalidade: Gerenciar Usuários
  Como um administrador
  Eu quero cadastrar novos usuários
  Para que eles possam acessar o sistema

  Cenário: Cadastro de usuário com sucesso
    Dado que eu estou na página de cadastro de usuários
    Quando eu preencho o campo "Nome" com "João Silva"
    E eu preencho o campo "Email" com "joao@example.com"
    E eu clico no botão "Salvar"
    Então eu devo ver a mensagem "Usuário cadastrado com sucesso!"
```

## 4. Definindo os Passos (Step Definitions)

Agora, você precisa dizer ao Cucumber o que cada frase do Gherkin deve fazer. Crie o arquivo `features/step_definitions/usuario_steps.rb`:

```ruby
Dado('que eu estou na página de cadastro de usuários') do
  visit new_user_path
end

Quando('eu preencho o campo {string} com {string}') do |campo, valor|
  fill_in campo, with: valor
end

Quando('eu clico no botão {string}') do |botao|
  click_button botao
end

Então('eu devo ver a mensagem {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end
```

## 5. Executando os Testes

Para rodar todos os seus testes do Cucumber, use o comando:

```bash
bundle exec cucumber
```

Ou, para rodar uma feature específica:

```bash
bundle exec cucumber features/gerenciar_usuarios.feature
```
