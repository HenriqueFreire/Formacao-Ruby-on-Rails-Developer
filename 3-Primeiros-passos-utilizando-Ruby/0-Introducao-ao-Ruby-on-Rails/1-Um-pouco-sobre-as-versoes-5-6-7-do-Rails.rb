# Evolução do Ruby on Rails: Versões 5, 6 e 7
#
# O Rails evoluiu significativamente nos últimos anos, focando em produtividade,
# comunicação em tempo real e simplificação do desenvolvimento frontend.

# --- RAILS 5: O Framework Moderno e em Tempo Real ---
# Lançado em 2016, trouxe o Ruby 2.2.2 como requisito mínimo.
#
# Principais Novidades:
# 1. Action Cable: Integração nativa de WebSockets para apps em tempo real (ex: chat).
# 2. Rails API Mode: Permite criar apps Rails focados apenas em backend para APIs.
# 3. Attributes API: Melhor controle sobre os tipos de dados nos Models.
#
# Exemplo (Action Cable):
# class ChatChannel < ApplicationCable::Channel
#   def subscribed
#     stream_from "sala_principal"
#   end
# end


# --- RAILS 6: Escalabilidade e Gestão de E-mails ---
# Lançado em 2019, focou em facilitar a vida de desenvolvedores em apps grandes.
#
# Principais Novidades:
# 1. Action Mailbox: Encaminha e-mails recebidos para controllers (ex: responder ticket por e-mail).
# 2. Action Text: Traz o editor Trix para o Rails, facilitando campos de texto rico (WYSIWYG).
# 3. Parallel Testing: Permite rodar testes em paralelo usando múltiplos núcleos da CPU.
# 4. Zeitwerk: Novo carregador de código (autoloader) muito mais eficiente.
# 5. Webpacker: Tornou-se o padrão para gerenciar JavaScript.
#
# Exemplo (Action Text no Model):
# class Artigo < ApplicationRecord
#   has_rich_text :conteudo
# end


# --- RAILS 7: Simplificação do Frontend e Segurança ---
# Lançado em 2021, trouxe uma mudança de paradigma, especialmente no frontend.
#
# Principais Novidades:
# 1. Import Maps: Permite usar JavaScript moderno sem precisar de Node.js ou Webpack.
# 2. Turbo e Stimulus (Hotwire): Foco em apps SPA-like com pouco ou nenhum JavaScript customizado.
# 3. At-rest Encryption: Criptografia nativa para atributos no banco de dados.
# 4. Zeitwerk exclusivo: O carregador antigo foi totalmente removido.
#
# Exemplo (Criptografia no Model):
# class Usuario < ApplicationRecord
#   encrypts :cpf, :numero_cartao
# end


# --- RESUMO DE EVOLUÇÃO ---
# - Rails 5: Consolidou o tempo real (WebSockets).
# - Rails 6: Melhorou a infraestrutura (Testes, E-mails, Texto Rico).
# - Rails 7: Declarou "paz" com o ecossistema JS, simplificando o frontend e focando em segurança.
