def verificar_forca_senha(senha)
  # 1. Validação de comprimento (Check-fast fail)
  return "Sua senha e muito curta. Recomenda-se no minimo 8 caracteres." if senha.length < 8

  # 2. Definição dos critérios de segurança
  critérios = {
    maiuscula: /[A-Z]/,
    minuscula: /[a-z]/,
    numero:    /[0-9]/,
    especial:  /[!@#$%^&*(),.?":{}|<>]/
  }

  # 3. Verificação de atendimento
  atende_requisitos = critérios.values.all? { |regex| senha.match?(regex) }

  # 4. Retorno baseado nos requisitos exatos do sistema de testes
  if atende_requisitos
    "Sua senha atende aos requisitos de seguranca. Parabens!"
  else
    "Sua senha nao atende aos requisitos de seguranca."
  end
end

# Execução do programa
if __FILE__ == $0
  senha = gets.to_s.chomp
  puts verificar_forca_senha(senha)
end
