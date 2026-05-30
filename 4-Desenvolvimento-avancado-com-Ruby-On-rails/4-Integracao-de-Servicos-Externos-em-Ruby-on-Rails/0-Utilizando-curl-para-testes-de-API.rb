# Utilizando cURL para Testes de API no Ruby on Rails

O **cURL** (Client URL) é uma ferramenta de linha de comando essencial para desenvolvedores. Ela permite transferir dados de ou para um servidor, sendo perfeita para testar endpoints de APIs RESTful sem a necessidade de uma interface gráfica (como Postman ou Insomnia).

## 1. Comandos Básicos

### GET (Listar/Buscar)
O GET é o método padrão do cURL.
```bash
# Simples requisição GET
curl http://localhost:3000/posts

# Com formatação (verbose) para ver os headers da resposta
curl -i http://localhost:3000/posts/1
```

---

## 2. Enviando Dados (POST e PUT)

Ao testar APIs Rails, geralmente precisamos enviar dados no formato JSON.

### POST (Criar)
Para criar um novo registro, usamos `-X POST`, definimos o header `Content-Type` e passamos os dados com `-d`.

```bash
curl -X POST http://localhost:3000/posts \
     -H "Content-Type: application/json" \
     -d '{"post": {"title": "Meu Post via cURL", "body": "Conteúdo do post aqui"}}'
```

### PUT/PATCH (Atualizar)
Similar ao POST, mas alterando o método e especificando o ID do recurso.

```bash
curl -X PATCH http://localhost:3000/posts/1 \
     -H "Content-Type: application/json" \
     -d '{"post": {"title": "Título Atualizado"}}'
```

---

## 3. Excluindo Dados (DELETE)

```bash
curl -X DELETE http://localhost:3000/posts/1
```

---

## 4. Testando Autenticação

Se sua API utiliza tokens (como JWT ou Simple Token), você deve enviá-los no header de autorização.

```bash
curl http://localhost:3000/admin/dashboard \
     -H "Authorization: Bearer seu_token_aqui"
```

---

## 5. Dicas Úteis para Rails

### A. Lidando com CSRF (Web Browser Context)
Se você estiver testando um controller que exige proteção contra CSRF (sessões via cookie), você precisará do `X-CSRF-Token`. Em APIs puras (`ActionController::API`), isso geralmente é ignorado.

### B. Formatando a Saída JSON
Para ler a resposta JSON mais facilmente no terminal, você pode "pipear" o resultado para o `jq` (se instalado):

```bash
curl http://localhost:3000/posts | jq
```

### C. Enviando Parâmetros via URL (Query Strings)
```bash
curl "http://localhost:3000/posts?status=published&author_id=5"
```
*Nota: Use aspas na URL para evitar que o terminal interprete o caractere `&`.*

## Resumo dos Principais Parâmetros
- `-X`: Especifica o método HTTP (GET, POST, etc).
- `-H`: Adiciona um header à requisição.
- `-d`: Envia os dados (corpo da requisição).
- `-i`: Exibe os headers da resposta (útil para depurar status codes).
- `-L`: Segue redirecionamentos (importante se o Rails redirecionar após uma ação).
