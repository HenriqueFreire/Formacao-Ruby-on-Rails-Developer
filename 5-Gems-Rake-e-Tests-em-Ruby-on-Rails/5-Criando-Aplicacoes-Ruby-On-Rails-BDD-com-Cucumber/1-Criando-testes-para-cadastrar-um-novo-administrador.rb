# Criando Testes para Cadastrar um Novo Administrador

Este guia demonstra como criar um teste BDD (Behavior-Driven Development) para a funcionalidade de cadastro de administradores em uma aplicação Rails usando Cucumber e Capybara.

## 1. Definindo a Feature (O Cenário)

Crie o arquivo `features/cadastrar_administrador.feature`. Aqui descrevemos o comportamento esperado em linguagem natural (Gherkin).

```gherkin
# language: pt
Funcionalidade: Cadastro de Administrador
  Como um superusuário do sistema
  Eu quero cadastrar novos administradores
  Para que eles possam gerenciar a plataforma

  Cenário: Cadastro de administrador com sucesso
    Dado que eu estou na página de cadastro de administradores
    Quando eu preencho o campo "Nome" com "Carlos Admin"
    E eu preencho o campo "Email" com "carlos@admin.com"
    E eu preencho o campo "Senha" com "senha123"
    E eu preencho o campo "Confirmação de Senha" com "senha123"
    E eu clico no botão "Cadastrar"
    Então eu devo ver a mensagem "Administrador cadastrado com sucesso!"
    E o administrador "Carlos Admin" deve existir no banco de dados
```

## 2. Implementando os Step Definitions

Agora, criamos a lógica Ruby que executa cada passo. Crie o arquivo `features/step_definitions/administrador_steps.rb`.

```ruby
# Navegação
Dado('que eu estou na página de cadastro de administradores') do
  visit new_admin_path # Certifique-se de que esta rota existe no seu routes.rb
end

# Preenchimento de campos genéricos
Quando('eu preencho o campo {string} com {string}') do |campo, valor|
  fill_in campo, with: valor
end

# Ação de clique
Quando('eu clico no botão {string}') do |botao|
  click_button botao
end

# Validação na interface (View)
Então('eu devo ver a mensagem {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end

# Validação no Banco de Dados (Model)
Então('o administrador {string} deve existir no banco de dados') do |nome|
  admin = Admin.find_by(name: nome)
  expect(admin).not_to be_nil
  expect(admin.name).to eq(nome)
end
```

## 3. Considerações Importantes

### Rotas e Controladores
Para que o teste passe, você deve ter definido em seu `config/routes.rb`:
```ruby
resources :admins
```
E um controlador `AdminsController` com os métodos `new` e `create`.

### Capybara e Matchers
- `visit`: Navega para uma URL.
- `fill_in`: Localiza um campo por ID, Name ou Label e preenche o valor.
- `click_button`: Clica em um botão ou input do tipo submit.
- `expect(page).to have_content`: Verifica se o texto está presente na página renderizada.

### Ambiente de Teste
Lembre-se que o Cucumber utiliza o ambiente de `test`. Seus testes não afetarão o banco de dados de desenvolvimento ou produção.

## 4. Executando o Teste

No terminal, execute:
```bash
bundle exec cucumber features/cadastrar_administrador.feature
```
