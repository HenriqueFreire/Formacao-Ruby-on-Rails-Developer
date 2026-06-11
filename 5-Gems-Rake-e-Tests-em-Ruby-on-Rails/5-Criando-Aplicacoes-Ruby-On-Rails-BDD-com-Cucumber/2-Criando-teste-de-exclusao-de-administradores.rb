# Criando Teste de Exclusão de Administradores

Este guia explica como testar a funcionalidade de exclusão de registros (administradores) em uma aplicação Rails utilizando Cucumber e Capybara.

## 1. Definindo a Feature (Gherkin)

Crie ou edite o arquivo `features/excluir_administrador.feature`. Vamos descrever o cenário onde um administrador é removido da listagem.

```gherkin
# language: pt
Funcionalidade: Excluir Administrador
  Como um superusuário
  Eu quero excluir administradores antigos
  Para manter a lista de acessos atualizada

  Cenário: Exclusão de administrador com sucesso
    Dado que existe um administrador cadastrado com o nome "Admin Antigo"
    E que eu estou na página de listagem de administradores
    Quando eu clico no link "Excluir" do administrador "Admin Antigo"
    E eu confirmo o alerta de exclusão
    Então eu devo ver a mensagem "Administrador excluído com sucesso!"
    E o administrador "Admin Antigo" não deve existir no banco de dados
```

## 2. Implementando os Step Definitions

Crie ou edite `features/step_definitions/administrador_steps.rb`.

```ruby
# Preparação do estado (Background data)
Dado('que existe um administrador cadastrado com o nome {string}') do |nome|
  Admin.create!(name: nome, email: "#{nome.parameterize}@example.com", password: 'password123')
end

# Navegação
Dado('que eu estou na página de listagem de administradores') do
  visit admins_path
end

# Ação de clique específica para uma linha/item
Quando('eu clico no link {string} do administrador {string}') do |link, nome|
  # Usamos o find para localizar a linha específica que contém o nome do administrador
  within("tr", text: nome) do
    click_link link
  end
end

# Lidando com diálogos de confirmação (JavaScript confirm)
Quando('eu confirmo o alerta de exclusão') do
  # O Capybara pode aceitar diálogos automaticamente se configurado, 
  # ou você pode usar este bloco para simular o "OK" no navegador:
  page.driver.browser.switch_to.alert.accept rescue nil
  # Nota: Em drivers modernos como Selenium/Cuprite, isso pode variar.
end

# Verificação de ausência no banco
Então('o administrador {string} não deve existir no banco de dados') do |nome|
  admin = Admin.find_by(name: nome)
  expect(admin).to be_nil
end
```

## 3. Explicação dos Conceitos

### `within` (Escopo)
O comando `within` é fundamental para testes de exclusão ou edição em tabelas. Sem ele, o Capybara poderia clicar no primeiro link "Excluir" que encontrasse, e não necessariamente no do administrador correto.
- `within("tr", text: nome)`: Procura por uma linha da tabela (`<tr>`) que contenha o texto específico (nome do admin) e restringe as ações seguintes apenas a dentro daquela linha.

### Confirmação de Exclusão
No Rails, links de exclusão geralmente possuem `data-confirm`. Para que o teste funcione:
1.  **Driver JavaScript**: Você precisará de um driver que suporte JS (como `selenium-webdriver` ou `cuprite`) se houver um modal real.
2.  **Configuração do Capybara**: Se estiver usando o driver padrão `rack_test`, ele não processa JavaScript, e o link de exclusão (geralmente um `DELETE` via `data-turbo-method` ou `data-method`) pode exigir configurações adicionais.

### Verificação de Sucesso
Além de checar a mensagem na tela (`expect(page).to have_content`), é uma boa prática verificar a **integridade dos dados** consultando diretamente o banco com `Admin.find_by(...)`.

## 4. Executando o Teste

```bash
bundle exec cucumber features/excluir_administrador.feature
```
