# Utilizando HTTParty para Integração de API

A gem **HTTParty** é uma das bibliotecas mais populares e simples para consumir APIs REST em Ruby. Ela transforma as respostas JSON/XML automaticamente em hashes/arrays do Ruby, facilitando muito o trabalho.

## 1. Instalação
Para utilizar, você deve adicionar ao seu `Gemfile`:
```ruby
gem 'httparty'
```
E rodar `bundle install` ou instalar via terminal: `gem install httparty`.

---

## 2. Uso Básico (Requisições Diretas)

Você pode fazer requisições rápidas chamando os métodos HTTP diretamente na classe `HTTParty`.

```ruby
require 'httparty'

# GET
response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/1')
puts response.code    # 200
puts response.message # OK
puts response.parsed_response['title'] # O HTTParty já faz o JSON.parse

# POST
options = {
  body: {
    title: 'foo',
    body: 'bar',
    userId: 1
  }.to_json,
  headers: { 'Content-Type' => 'application/json' }
}

response = HTTParty.post('https://jsonplaceholder.typicode.com/posts', options)
puts response.code # 201
```

---

## 3. Uso Avançado (Encapsulamento em Classe)

A forma recomendada de usar o HTTParty é criando uma classe e incluindo o módulo `HTTParty`. Isso permite configurar uma `base_uri` e headers padrão.

```ruby
require 'httparty'

class BlogService
  include HTTParty
  base_uri 'https://jsonplaceholder.typicode.com'

  def initialize
    @options = { headers: { "Authorization" => "Bearer seu_token" } }
  end

  def posts
    self.class.get("/posts", @options)
  end

  def criar_post(titulo, corpo)
    opcoes = @options.merge(
      body: { title: titulo, body: corpo, userId: 1 }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    self.class.post("/posts", opcoes)
  end
end

# Utilizando a classe
service = BlogService.new
puts service.posts.first['title']
```

---

## 4. Tratamento de Erros

É importante verificar o status da resposta antes de tentar acessar os dados.

```ruby
response = HTTParty.get('https://api.exemplo.com/dados')

case response.code
  when 200
    puts "Sucesso! Dados: #{response.parsed_response}"
  when 404
    puts "Recurso não encontrado."
  when 500...600
    puts "Erro no servidor: #{response.code}"
  else
    puts "Erro inesperado: #{response.code}"
end
```

---

## 5. Por que usar HTTParty?

1.  **Parsing Automático**: Ele detecta se a resposta é JSON ou XML e já converte para tipos Ruby.
2.  **Sintaxe Limpa**: Muito mais legível que a biblioteca padrão `Net::HTTP`.
3.  **Configurável**: Permite definir timeouts, autenticação básica e headers de forma simples.

## Exemplo de busca de Endereço (ViaCEP)

```ruby
def buscar_cep(cep)
  response = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")
  if response.success?
    puts "Endereço: #{response['logradouro']}, #{response['bairro']} - #{response['localidade']}"
  else
    puts "CEP não encontrado."
  end
end

buscar_cep("01001000")
```
