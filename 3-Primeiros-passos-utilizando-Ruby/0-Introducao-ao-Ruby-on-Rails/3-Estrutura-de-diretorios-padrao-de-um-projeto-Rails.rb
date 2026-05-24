# Estrutura de Diretórios Padrão de um Projeto Rails
#
# O Rails segue a filosofia de "Convenção sobre Configuração", o que significa que
# cada tipo de arquivo tem um lugar específico. Conhecer essa estrutura é fundamental
# para navegar e desenvolver em qualquer projeto Rails.

# --- 1. A Pasta Principal: /app ---
# Contém o código específico da sua aplicação. É onde você passará 90% do seu tempo.
#
# - /app/models      -> Lógica de negócio e interação com o banco (ex: usuario.rb).
# - /app/controllers -> Recebe as requisições e coordena a resposta (ex: usuarios_controller.rb).
# - /app/views       -> Templates HTML/ERB que o usuário vê (ex: index.html.erb).
# - /app/assets      -> Arquivos estáticos como CSS, Imagens e JavaScript.
# - /app/helpers     -> Métodos auxiliares para as Views.
# - /app/jobs        -> Tarefas que rodam em segundo plano (background jobs).
# - /app/mailers     -> Lógica para envio de e-mails.


# --- 2. Configurações: /config ---
# Onde vivem os "cérebros" da aplicação.
#
# - config/routes.rb      -> Define para onde as URLs devem ser enviadas (o roteamento).
# - config/database.yml   -> Configurações de conexão com o banco de dados.
# - config/environments/  -> Configurações específicas para cada ambiente (development, test, production).
# - config/initializers/  -> Códigos que rodam assim que a aplicação inicia.


# --- 3. Banco de Dados: /db ---
# - db/migrate/ -> Histórico de alterações no banco de dados (migrações).
# - db/seeds.rb -> Dados iniciais para popular o banco (ex: criar um usuário admin padrão).
# - db/schema.rb -> A representação atual da estrutura do seu banco de dados.


# --- 4. Testes: /test (ou /spec) ---
# O Rails incentiva o desenvolvimento orientado a testes.
# - Aqui ficam os testes de unidade, integração e sistema.


# --- 5. Outros Diretórios Importantes ---
#
# - /bin    -> Scripts executáveis (ex: o próprio comando 'rails' ou 'bundle').
# - /lib    -> Módulos e códigos estendidos que não se encaixam exatamente no fluxo MVC.
# - /log    -> Arquivos de log da aplicação (útil para debugar erros).
# - /public -> A única pasta acessível diretamente pela web (páginas 404, 500, favicon).
# - /tmp    -> Arquivos temporários (cache, PIDs de processos).
# - /vendor -> Onde você coloca bibliotecas de terceiros que não são gerenciadas por Gems.


# --- 6. Arquivos na Raiz ---
#
# - Gemfile      -> Declara todas as dependências (Gems) que seu projeto precisa.
# - Gemfile.lock -> Registra as versões exatas das Gems instaladas (garante consistência).
# - Rakefile     -> Carrega tarefas que podem ser executadas via terminal (rake tasks).
# - .gitignore   -> Diz ao Git quais arquivos devem ser ignorados (ex: logs e senhas).
