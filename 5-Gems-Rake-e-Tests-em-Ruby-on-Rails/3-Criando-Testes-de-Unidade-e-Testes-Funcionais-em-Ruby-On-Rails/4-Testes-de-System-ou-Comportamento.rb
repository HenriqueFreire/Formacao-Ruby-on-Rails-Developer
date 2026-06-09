# Testes de System ou Comportamento em Rails

# Testes de sistema (System Tests) são testes de ponta a ponta (E2E) que simulam 
# um usuário real interagindo com a sua aplicação através de um navegador.

# O Rails integra nativamente o Capybara para essa tarefa, permitindo:
# 1. Visitar páginas.
# 2. Preencher formulários.
# 3. Clicar em botões e links.
# 4. Verificar a presença de textos e elementos visuais na tela.

# --- 1. Configuração Básica ---

# O Rails cria automaticamente uma pasta 'test/system' e uma classe base 'ApplicationSystemTestCase'.
# Você pode configurar se o teste roda com um navegador visível ou "headless" (sem interface).

# --- 2. Exemplo Prático de Teste de Sistema ---

# Imagine o fluxo de um usuário criando uma nova tarefa em um Todo List.

=begin
require "application_system_test_case"

class TarefasTest < ApplicationSystemTestCase
  
  test "deve criar uma nova tarefa com sucesso" do
    visit tarefas_path # 1. Visita a página de listagem
    
    click_on "Nova Tarefa" # 2. Clica no link de criação
    
    # 3. Preenche o formulário
    fill_in "Título", with: "Estudar Ruby on Rails"
    fill_in "Descrição", with: "Praticar testes de sistema com Capybara"
    
    click_on "Salvar" # 4. Envia o formulário
    
    # 5. Valida o resultado final na tela
    assert_text "Tarefa criada com sucesso!"
    assert_text "Estudar Ruby on Rails"
  end

  test "deve exibir erro ao tentar criar tarefa sem título" do
    visit new_tarefa_path
    
    click_on "Salvar"
    
    assert_text "Título can't be blank"
  end

end
=end

# --- 3. Comandos Comuns do Capybara ---

# - visit(url): Navega para uma página.
# - fill_in(label_ou_id, with: "texto"): Digita em um campo de formulário.
# - click_on(texto_ou_id): Clica em botões ou links.
# - select(opcao, from: label): Seleciona uma opção em um <select>.
# - check / uncheck: Marca ou desmarca checkboxes.
# - assert_selector "div.alerta": Verifica se um elemento CSS existe.
# - assert_text "Texto": Verifica se um texto está visível na página.

# --- 4. Por que usar Testes de Sistema? ---

# - Confiança Total: Eles garantem que todas as peças (Roteamento, Controller, Model, View, DB, JavaScript) 
#   estão funcionando juntas corretamente.
# - Visão do Usuário: Detectam problemas que testes de unidade não veriam (ex: um botão escondido por CSS).

# --- CONCLUSÃO ---

# Embora sejam mais lentos que os testes de unidade, os Testes de Sistema são 
# indispensáveis para cobrir o "Caminho Feliz" (Happy Path) das funcionalidades 
# críticas da sua aplicação.
