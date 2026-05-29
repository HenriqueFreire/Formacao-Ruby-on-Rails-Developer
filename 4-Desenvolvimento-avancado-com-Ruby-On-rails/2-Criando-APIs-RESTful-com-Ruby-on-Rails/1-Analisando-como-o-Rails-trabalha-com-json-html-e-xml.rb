# Analisando como o Rails trabalha com JSON, HTML e XML

# O Ruby on Rails possui suporte nativo para responder a múltiplas representações 
# de um mesmo recurso. Isso permite que um único controller atenda tanto requisições 
# de navegadores (HTML) quanto de clientes de API (JSON ou XML).

# --- Como o Rails determina o formato? ---
# O Rails utiliza duas formas principais para decidir qual formato entregar:
# 1. Extensão na URL: /articles.json ou /articles.xml
# 2. Header 'Accept': O cliente envia "Accept: application/json" na requisição.

# --- O bloco respond_to ---
# Dentro das ações do controller, usamos o método `respond_to` para definir 
# o comportamento para cada formato.

class ProductsController < ApplicationController
  def index
    @products = Product.all

    respond_to do |format|
      # 1. Responder com HTML (procura por index.html.erb)
      format.html 

      # 2. Responder com JSON (converte a coleção automaticamente)
      format.json { render json: @products }

      # 3. Responder com XML
      format.xml { render xml: @products }
    end
  end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # Renderiza show.html.erb
      
      # Você pode customizar o JSON antes de enviar
      format.json do 
        render json: { 
          id: @product.id, 
          nome: @product.name, 
          preco_formatado: "R$ #{@product.price}" 
        }
      end

      format.xml { render xml: @product }
    end
  end
end

# --- Renderização Automática ---
# O Rails tenta ser inteligente. Se você pedir .json e o controller não tiver 
# um bloco `respond_to`, mas você tiver um arquivo chamado `index.json.jbuilder`, 
# o Rails o renderizará automaticamente.

# --- Vantagens desta abordagem ---
# 1. DRY (Don't Repeat Yourself): A lógica de negócio (busca no banco) é feita uma única vez.
# 2. Consistência: Garante que os mesmos dados sejam expostos em diferentes formatos.
# 3. Flexibilidade: Permite que a mesma aplicação suporte Web, Mobile e integrações de terceiros.

# --- Nota sobre XML ---
# Embora o Rails suporte XML nativamente (usando .to_xml), o padrão da indústria 
# para APIs modernas é quase exclusivamente o JSON por ser mais leve e fácil de 
# processar em JavaScript.
