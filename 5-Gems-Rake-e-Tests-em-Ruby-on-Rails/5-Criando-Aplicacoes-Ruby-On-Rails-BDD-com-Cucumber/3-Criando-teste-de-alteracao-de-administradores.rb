# Criando Teste de Alteração de Administradores

Este guia detalha como testar a funcionalidade de edição (update) de registros de administradores em uma aplicação Rails utilizando Cucumber e Capybara.

## 1. Definindo a Feature (Gherkin)

Crie ou edite o arquivo `features/alterar_administrador.feature`. O cenário descreve a navegação até o formulário de edição, a alteração dos dados e a verificação do sucesso.

```gherkin
# language: pt
Funcionalidade: Alterar Administrador
  Como um superusuário
  Eu quero editar os dados de um administrador existente
  Para manter as informações atualizadas

  Cenário: Alteração de nome e email com sucesso
    Dado que existe um administrador cadastrado com o nome "Admin Antigo"
    E que eu estou na página de listagem de administradores
    Quando eu clico no link "Editar" do administrador "Admin Antigo"
    E eu preencho o campo "Nome" com "Admin Atualizado"
    E eu preencho o campo "Email" com "atualizado@example.com"
    E eu clico no botão "Salvar"
    Então eu devo ver a mensagem "Administrador atualizado com sucesso!"
    E o administrador "Admin Atualizado" deve existir no banco de dados com o email "atualizado@example.com"
```

## 2. Implementando os Step Definitions

Crie ou edite `features/step_definitions/administrador_steps.rb`.

```ruby
# Reutilizando o Dado de criação (se já definido em outros arquivos)
Dado('que existe um administrador cadastrado com o nome {string}') do |nome|
  Admin.create!(
    name: nome, 
    email: "#{nome.parameterize}@example.com", 
    password: 'password123'
  )
end

# Navegação para a edição usando escopo
Quando('eu clico no link {string} do administrador {string}') do |link, nome|
  within("tr", text: nome) do
    click_link link
  end
end

# Preenchimento e Ação
Quando('eu preencho o campo {string} com {string}') do |campo, valor|
  fill_in campo, with: valor
end

Quando('eu clico no botão {string}') do |botao|
  click_button botao
end

# Verificações
Então('eu devo ver a mensagem {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end

Então('o administrador {string} deve existir no banco de dados com o email {string}') do |nome, email|
  admin = Admin.find_by(name: nome)
  expect(admin).not_to be_nil
  expect(admin.email).to eq(email)
end
```

## 3. Explicação dos Conceitos Chave

### Fluxo de Edição
Diferente do cadastro, a edição exige que um registro **já exista**. Por isso, o passo `Dado que existe um administrador...` é essencial para preparar o estado do banco de dados antes do teste começar.

### Localização Dinâmica (`within`)
Assim como na exclusão, usamos o `within` para garantir que estamos clicando no botão "Editar" da linha correta da tabela. Isso evita erros quando existem múltiplos administradores listados.

### Validação de Persistência
Não basta apenas ver a mensagem de sucesso na tela. É crucial verificar se os dados foram realmente alterados no banco de dados:
```ruby
admin = Admin.find_by(name: nome)
expect(admin.email).to eq(email)
```

## 4. Dicas de Melhores Práticas

1.  **Limpeza de Dados**: Certifique-se de que a gem `database_cleaner` está configurada para limpar o banco entre os cenários, garantindo que um teste não interfira no outro.
2.  **Caminhos (Paths)**: Utilize os helpers do Rails (ex: `edit_admin_path(admin)`) se precisar navegar diretamente para a página de edição, mas prefira simular a jornada do usuário clicando nos links da interface.

## 5. Executando o Teste

```bash
bundle exec cucumber features/alterar_administrador.feature
```
