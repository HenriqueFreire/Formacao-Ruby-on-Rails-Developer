  # Utilizando Rest-Client para Integração de API

A gem **rest-client** é uma alternativa poderosa e flexível ao HTTParty. Ela é conhecida por seguir os padrões REST de forma rigorosa e oferecer um controle refinado sobre requisições, especialmente no envio de arquivos e tratamento de exceções.

---

## 1. Instalação

Adicione ao seu `Gemfile`:
```ruby
gem 'rest-client'
```
E instale com `bundle install` ou `gem install rest-client`.

---

## 2. Uso Básico (Requisições Simples)

Diferente do HTTParty, o `rest-client` não faz o parse automático do JSON por padrão; você precisará da biblioteca `json`.

```ruby
require 'rest-client'
require 'json'

# GET
response = RestClient.get('https://jsonplaceholder.typicode.com/posts/1')
puts response.code # 200
dados = JSON.parse(response.body)
puts dados['title']

# POST (com Payload e Headers)
url = 'https://jsonplaceholder.typicode.com/posts'
payload = { title: 'Novo Post', body: 'Conteúdo', userId: 1 }
headers = { content_type: :json, accept: :json }

response = RestClient.post(url, payload.to_json, headers)
puts response.code # 201
```

---

## 3. Tratamento de Exceções (O diferencial)

O `rest-client` lança exceções para códigos de status que não sejam 2xx (como 404, 401, 500). Isso obriga você a tratar erros de forma explícita.

```ruby
begin
  response = RestClient.get('https://api.exemplo.com/recurso-inexistente')
rescue RestClient::ExceptionWithResponse => e
  puts "Erro: #{e.response.code}"
  puts "Corpo do erro: #{e.response.body}"
rescue SocketError => e
  puts "Erro de conexão: #{e.message}"
end
```

---

## 4. Trabalhando com Parâmetros de URL

Para enviar query strings no GET, passamos um hash para o header `:params`.

```ruby
response = RestClient.get('https://api.exemplo.com/busca', { params: { q: 'ruby', page: 2 } })
# URL gerada: https://api.exemplo.com/busca?q=ruby&page=2
```

---

## 5. Rest-Client vs HTTParty

| Recurso | HTTParty | Rest-Client |
| :--- | :--- | :--- |
| **Parsing JSON** | Automático | Manual (`JSON.parse`) |
| **Erros (404, 500)** | Retorna objeto response | Lança Exceção |
| **Sintaxe** | Baseada em inclusão de módulo | Funcional/Direta |
| **Envio de Arquivos** | Mais complexo | Muito simples (suporta Multipart) |

---

## Exemplo de Envio de Arquivo (Multipart)

O `rest-client` facilita muito o upload de arquivos:

```ruby
payload = {
  nome: 'Documento Importante',
  arquivo: File.new('/caminho/do/arquivo.pdf', 'rb')
}

response = RestClient.post('https://api.exemplo.com/upload', payload)
```

## Resumo
O **rest-client** é ideal para projetos onde você precisa de um tratamento de erro mais rigoroso e estruturado via `begin/rescue`, ou quando sua integração envolve uploads complexos de arquivos. Para requisições simples onde o parsing automático é prioridade, o HTTParty continua sendo uma excelente escolha.
