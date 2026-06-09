# Criando Testes sobre Helper em Rails

# Helpers são módulos usados para encapsular lógica de visualização (view logic), 
# permitindo que as views fiquem limpas e focadas apenas na estrutura HTML.
# Testar helpers garante que transformações de dados para o usuário final estejam corretas.

# --- 1. O que testar em um Helper? ---
# - Formatação de datas e moedas.
# - Geração de tags HTML dinâmicas.
# - Lógica condicional complexa para exibição de elementos.

# --- 2. Exemplo de Helper (ApplicationHelper) ---

# module ApplicationHelper
#   def formatar_moeda(valor)
#     number_to_currency(valor, unit: "R$", separator: ",", delimiter: ".")
#   end
#
#   def status_badge(ativo)
#     classe = ativo ? "badge-success" : "badge-danger"
#     texto  = ativo ? "Ativo" : "Inativo"
#     content_tag(:span, texto, class: "badge #{classe}")
#   end
# end

# --- 3. Implementando os Testes de Helper ---

# Em Rails, usamos ActionView::TestCase, que nos dá acesso automático aos 
# métodos do helper sendo testado e também aos helpers nativos do Rails (como content_tag).

=begin
require "test_helper"

class ApplicationHelperTest < ActionView::TestCase

  # Testando formatação simples
  test "deve formatar valor para moeda brasileira" do
    assert_equal "R$ 1.250,50", formatar_moeda(1250.50)
  end

  # Testando lógica de badge (HTML)
  test "deve retornar badge de sucesso para status ativo" do
    resultado = status_badge(true)
    assert_match /badge-success/, resultado
    assert_match /Ativo/, resultado
  end

  test "deve retornar badge de erro para status inativo" do
    resultado = status_badge(false)
    assert_match /badge-danger/, resultado
    assert_match /Inativo/, resultado
  end

end
=end

# --- BOAS PRÁTICAS ---

# 1. Isolamento: Teste apenas a saída do método dado uma entrada específica.
# 2. HTML Safe: Se o seu helper gera HTML, verifique se as tags estão sendo geradas corretamente.
# 3. Helpers Nativos: Lembre-se que o ActionView::TestCase permite usar métodos como 
#    'link_to', 'image_tag' etc., dentro dos seus testes de helper.

# --- CONCLUSÃO ---

# Testar helpers previne erros bobos de exibição e garante que a lógica de "perfumaria" 
# e formatação da sua aplicação seja robusta, mantendo a integridade visual do sistema.
