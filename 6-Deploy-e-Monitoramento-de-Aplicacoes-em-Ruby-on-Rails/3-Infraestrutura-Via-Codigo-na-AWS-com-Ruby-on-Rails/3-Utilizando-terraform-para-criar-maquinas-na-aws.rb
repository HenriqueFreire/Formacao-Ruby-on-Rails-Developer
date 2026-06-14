# Guia: Utilizando Terraform para Criar Infraestrutura na AWS (Rails)

# Terraform é uma ferramenta de Infraestrutura como Código (IaC) que permite criar, 
# alterar e melhorar a infraestrutura de forma segura e previsível. Em vez de 
# clicar no console da AWS, você descreve seus servidores e redes em arquivos.

# ==========================================
# 1. Por que usar Terraform?
# ==========================================
# - Versionamento: Sua infraestrutura está no Git.
# - Velocidade: Cria dezenas de recursos em minutos.
# - Consistência: O ambiente de staging será idêntico ao de produção.

# ==========================================
# 2. Configuração do Provider (main.tf)
# ==========================================
# O primeiro passo é dizer ao Terraform que usaremos a AWS.
#
# provider "aws" {
#   region = "us-east-1"
# }

# ==========================================
# 3. Exemplo: Criando um Security Group (Firewall)
# ==========================================
# Precisamos abrir as portas 22 (SSH) e 80 (HTTP) para nossa aplicação.
#
# resource "aws_security_group" "rails_sg" {
#   name        = "rails_app_sg"
#   description = "Permitir SSH e HTTP"
#
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# ==========================================
# 4. Exemplo: Criando uma Instância EC2
# ==========================================
# Aqui definimos a "máquina" onde o Rails vai rodar.
#
# resource "aws_instance" "rails_server" {
#   ami           = "ami-0c7217cdde317cfec" # Exemplo de Ubuntu 22.04
#   instance_type = "t3.micro"
#   key_name      = "minha-chave-ssh"
#
#   vpc_security_group_ids = [aws_security_group.rails_sg.id]
#
#   tags = {
#     Name = "RailsServer-Producao"
#   }
#
#   # Script para rodar no boot (instalação inicial)
#   user_data = <<-EOF
#               #!/bin/bash
#               sudo apt-get update
#               sudo apt-get install -y docker.io
#               sudo systemctl start docker
#               sudo systemctl enable docker
#               EOF
# }

# ==========================================
# 5. Fluxo de Trabalho (Comandos)
# ==========================================
# 1. terraform init    - Baixa os plugins da AWS.
# 2. terraform plan    - Mostra o que será criado (o "preview").
# 3. terraform apply   - Cria a infraestrutura de fato.
# 4. terraform destroy - Remove tudo o que foi criado.

# ==========================================
# 6. Integração com Rails
# ==========================================
# Após o Terraform criar a máquina, você pode usar o IP gerado 
# para rodar seus Playbooks de Ansible ou configurar seu deploy via SSH.
#
# output "server_ip" {
#   value = aws_instance.rails_server.public_ip
# }

# ==========================================
# 7. Dica: State File
# ==========================================
# O Terraform cria um arquivo chamado 'terraform.tfstate'. 
# NUNCA o apague manualmente, pois ele é a "memória" do que existe na nuvem.
