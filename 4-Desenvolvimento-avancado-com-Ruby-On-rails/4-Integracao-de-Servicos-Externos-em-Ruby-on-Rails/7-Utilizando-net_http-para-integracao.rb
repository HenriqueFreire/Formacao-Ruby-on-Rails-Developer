# Utilizando Net::HTTP para Integração de API

A biblioteca **Net::HTTP** faz parte da biblioteca padrão (Standard Library) do Ruby. Isso significa que você não precisa instalar nenhuma gem para usá-la. Embora seja mais verbosa que o HTTParty ou Rest-Client, ela é extremamente poderosa e útil quando você quer manter seu projeto livre de dependências externas.

---

## 1. Requisição GET Simples

Para requisições muito simples, o Ruby oferece um atalho através do módulo `OpenURI`, mas o `Net::HTTP` puro é mais flexível.

```ruby
require 'net/http'
require 'json'

url = URI("https://jsonplaceholder.typicode.com/posts/1")

# Forma mais simples de GET
response = Net::HTTP.get(url) 
dados = JSON.parse(response)
puts dados['title']
```

---

## 2. Requisições Complexas (POST com JSON)

Para requisições que envolvem headers e corpo (body), o processo é um pouco mais manual.

```ruby
require 'net/http'
require 'uri'
require 'json'

uri = URI.parse("https://jsonplaceholder.typicode.com/posts")

# 1. Configurar o objeto de requisição
request = Net::HTTP::Post.new(uri)
request.content_type = "application/json"
request["Accept"] = "application/json"
request.body = { title: "Meu Post", body: "Conteúdo", userId: 1 }.to_json

# 2. Executar a requisição usando SSL (HTTPS)
response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

puts "Código: #{response.code}"
puts "Resposta: #{response.body}"
```

---

## 3. Configurando HTTPS e Timeouts

Diferente das gems, no `Net::HTTP` você precisa configurar explicitamente o uso de SSL para URLs `https://`.

```ruby
uri = URI("https://api.exemplo.com")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true # Obrigatório para HTTPS
http.open_timeout = 5 # Tempo máximo para abrir conexão
http.read_timeout = 10 # Tempo máximo para ler a resposta

request = Net::HTTP::Get.new(uri)
response = http.request(request)
```

---

## 4. Net::HTTP vs Gems

| Característica | Net::HTTP | HTTParty / Rest-Client |
| :--- | :--- | :--- |
| **Instalação** | Já vem no Ruby | Precisa de Gem |
| **Sintaxe** | Verbosa e Manual | Limpa e Direta |
| **Parsing JSON** | Manual (`JSON.parse`) | Automático |
| **SSL (HTTPS)** | Manual (`use_ssl: true`) | Automático |

---

## 5. Quando usar Net::HTTP?

- Quando você está criando uma **Gem** e não quer forçar seus usuários a instalarem outras dependências.
- Em **Scripts Simples** onde você não quer criar um `Gemfile`.
- Em ambientes restritos onde você não pode instalar gems externas.

## Resumo
O `Net::HTTP` é o "motor" que a maioria das gems usa por baixo dos panos. Entender como ele funciona é fundamental para qualquer desenvolvedor Ruby, mesmo que no dia a dia você prefira a conveniência de uma gem como o HTTParty.
