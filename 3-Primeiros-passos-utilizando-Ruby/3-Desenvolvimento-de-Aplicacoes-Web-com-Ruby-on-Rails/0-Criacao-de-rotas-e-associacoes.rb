# Criação de Rotas e Associações em Rails

Este arquivo explica como o Rails gerencia a navegação entre URLs (Rotas) e como os modelos se relacionam entre si (Associações).

---

## 1. Rotas (Routes)

As rotas são definidas no arquivo `config/routes.rb`. Elas mapeiam uma URL e um método HTTP (GET, POST, etc.) para uma ação de um controlador.

### Rotas RESTful (Resources)
O comando `resources` cria automaticamente as 7 rotas padrão para um recurso (index, show, new, create, edit, update, destroy).

**Exemplo:**
```ruby
# config/routes.rb
Rails.application.routes.draw do
  resources :produtos
  
  # Rota raiz (página inicial)
  root "produtos#index"
  
  # Rota customizada
  get "/contato", to: "paginas#contato"
end
```

### Rotas Aninhadas (Nested Routes)
Úteis quando um recurso depende de outro.

**Exemplo:**
```ruby
resources :autores do
  resources :livros
end
# Isso cria URLs como /autores/1/livros
```

---

## 2. Associações (Associations)

As associações facilitam a realização de operações comuns nos seus objetos, conectando os modelos através de chaves estrangeiras.

### belongs_to e has_many (1-para-N)
É a associação mais comum. Um registro "pertence a" outro, e o outro "tem muitos" do primeiro.

**Exemplo:**
Um `Autor` tem muitos `Livros`, e um `Livro` pertence a um `Autor`.

```ruby
# app/models/autor.rb
class Autor < ApplicationRecord
  has_many :livros
end

# app/models/livro.rb
class Livro < ApplicationRecord
  belongs_to :autor
end
```

### has_one (1-para-1)
Similar ao `has_many`, mas indica que o modelo possui apenas uma instância do outro.

**Exemplo:**
Um `Usuario` tem um `Perfil`.

```ruby
# app/models/usuario.rb
class Usuario < ApplicationRecord
  has_one :perfil
end

# app/models/perfil.rb
class Perfil < ApplicationRecord
  belongs_to :usuario
end
```

### has_many :through (N-para-N)
Usada para estabelecer uma relação de muitos-para-muitos através de um terceiro modelo.

**Exemplo:**
Um `Medico` tem muitos `Pacientes` através de `Consultas`.

```ruby
# app/models/medico.rb
class Medico < ApplicationRecord
  has_many :consultas
  has_many :pacientes, through: :consultas
end

# app/models/consulta.rb
class Consulta < ApplicationRecord
  belongs_to :medico
  belongs_to :paciente
end

# app/models/paciente.rb
class Paciente < ApplicationRecord
  has_many :consultas
  has_many :medicos, through: :consultas
end
```

---

## 3. Benefícios das Associações

Com as associações configuradas, você pode fazer chamadas poderosas de forma simples:

```ruby
@autor = Autor.first
@livros = @autor.livros # Busca todos os livros do autor automaticamente

@novo_livro = @autor.livros.create(titulo: "O Hobbit") # Cria o livro já associado ao ID do autor
```
