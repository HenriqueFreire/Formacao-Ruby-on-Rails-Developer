# Relacionamentos no ActiveRecord: has_many e belongs_to

# No Ruby on Rails, os relacionamentos entre modelos são fundamentais para organizar dados.
# Os dois relacionamentos mais comuns são `has_many` e `belongs_to`.

# 1. belongs_to
# Este relacionamento indica que cada instância do modelo atual pertence a exatamente uma instância de outro modelo.
# Geralmente, a tabela do banco de dados correspondente ao modelo que declara o `belongs_to` 
# contém uma chave estrangeira (foreign key).

# Exemplo: Um Livro pertence a um Autor.
class Book < ApplicationRecord
  belongs_to :author
end

# 2. has_many
# Este relacionamento indica uma conexão um-para-muitos com outro modelo. 
# Ele é frequentemente encontrado no "outro lado" de um relacionamento `belongs_to`.

# Exemplo: Um Autor tem muitos Livros.
class Author < ApplicationRecord
  has_many :books
end

# --- Casos de Uso e Exemplos Práticos ---

# Imagine que temos os seguintes dados:
# autor = Author.create(name: "Machado de Assis")
# livro1 = Book.create(title: "Dom Casmurro", author: autor)
# livro2 = Book.create(title: "Memórias Póstumas de Brás Cubas", author: autor)

# Com o relacionamento configurado, podemos fazer o seguinte:

# A partir do autor, acessar seus livros:
# autor.books # Retorna uma coleção com livro1 e livro2

# A partir de um livro, acessar seu autor:
# livro1.author # Retorna o objeto do autor Machado de Assis

# --- Pontos Importantes ---

# - Convenção de Nomes: 
#   - `belongs_to` usa o nome do modelo no SINGULAR (:author).
#   - `has_many` usa o nome do modelo no PLURAL (:books).

# - Chave Estrangeira:
#   O Rails espera que a tabela `books` tenha uma coluna chamada `author_id`.

# - Integridade Referencial:
#   Você pode adicionar opções como `dependent: :destroy` no `has_many`:
#   has_many :books, dependent: :destroy
#   Isso garante que, se um autor for excluído, todos os seus livros também serão removidos do banco de dados.
