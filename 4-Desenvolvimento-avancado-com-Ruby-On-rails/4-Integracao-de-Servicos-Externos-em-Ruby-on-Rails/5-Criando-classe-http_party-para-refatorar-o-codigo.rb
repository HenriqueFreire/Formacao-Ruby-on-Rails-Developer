# Refatorando integrações de API com classes HTTParty

Muitas vezes, começamos a usar o HTTParty de forma espalhada pelo código, repetindo URLs, headers de autenticação e lógica de tratamento de erro. Refatorar essas chamadas para uma **Classe de Serviço** dedicada torna o código mais limpo, fácil de testar e de manter.

---

## 1. O Problema: Código Repetitivo (Anti-padrão)

```ruby
# Em vários lugares do sistema:
response = HTTParty.get("https://api.meusite.com/v1/users", headers: { "Authorization" => "Bearer 123" })
# ... lógica repetida ...
response = HTTParty.post("https://api.meusite.com/v1/users", body: { name: "João" }, headers: { "Authorization" => "Bearer 123" })
```

---

## 2. A Solução: Classe Base Customizada

Podemos criar uma classe base ou incluir o `HTTParty` diretamente em uma classe específica para a API.

```ruby
require 'httparty'

class MyApiService
  include HTTParty
  
  # 1. Definimos a URL base uma única vez
  base_uri 'https://api.meusite.com/v1'
  
  # 2. Definimos headers padrão (ex: JSON e Auth)
  headers 'Content-Type' => 'application/json'

  def initialize(token)
    # 3. Podemos passar configurações dinâmicas no construtor
    @options = { headers: { "Authorization" => "Bearer #{token}" } }
  end

  # --- Métodos de Recurso ---

  def users
    handle_response { self.class.get("/users", @options) }
  end

  def create_user(data)
    # Mergeamos o corpo da requisição com as opções de autenticação
    opts = @options.merge(body: data.to_json)
    handle_response { self.class.post("/users", opts) }
  end

  private

  # 4. Centralizamos o tratamento de erros e parsing
  def handle_response
    response = yield
    case response.code
    when 200..299
      response.parsed_response
    when 401
      raise "Erro de Autenticação: Verifique seu Token."
    when 404
      nil
    else
      raise "Erro na API: #{response.code} - #{response.body}"
    end
  rescue StandardError => e
    puts "Ocorreu um erro na comunicação: #{e.message}"
    nil
  end
end
```

---

## 3. Benefícios da Refatoração

1.  **DRY (Don't Repeat Yourself)**: A URL base, os headers e a lógica de erros estão em um só lugar. Se a URL da API mudar, você altera apenas uma linha.
2.  **Facilidade de Uso**: O restante do seu sistema não precisa saber como a API funciona internamente.
    ```ruby
    api = MyApiService.new("TOKEN_ABC")
    usuarios = api.users
    ```
3.  **Testabilidade**: É muito mais fácil "mockar" (simular) a classe `MyApiService` em testes unitários do que tentar interceptar chamadas diretas do `HTTParty`.
4.  **Segurança**: Centralizar a autenticação diminui o risco de esquecer de enviar o token em alguma requisição importante.

---

## 4. Dica: Usando Variáveis de Ambiente

Nunca deixe tokens de API "hardcoded" na sua classe refatorada. Use o arquivo `.env` ou o `credentials` do Rails.

```ruby
class MyApiService
  # ...
  def initialize
    token = Rails.application.credentials.my_api_token
    @options = { headers: { "Authorization" => "Bearer #{token}" } }
  end
  # ...
end
```

## Resumo
Refatorar para uma classe não é apenas sobre estética, é sobre **organização arquitetural**. Sempre que sua aplicação precisar conversar com um serviço externo de forma recorrente, crie uma classe de serviço dedicada para essa integração.
