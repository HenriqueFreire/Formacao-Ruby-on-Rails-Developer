# Utilizando Ruby para Executar Comandos Shell

O Ruby oferece diversas maneiras de interagir com o sistema operacional e executar comandos de terminal. Cada método tem um comportamento diferente em relação ao valor de retorno e à captura da saída (stdout/stderr).

## 1. Backticks (``) e %x{}
Estes são os métodos mais comuns quando você precisa **capturar a saída** do comando como uma string.

```ruby
# Usando crases (backticks)
saida = `ls -l`
puts "Arquivos: #{saida}"

# Usando a sintaxe %x (útil se o comando contiver aspas)
data_atual = %x{date}
puts "Hoje é: #{data_atual}"
```
*   **Retorno:** A saída (STDOUT) do comando como uma String.
*   **Erro:** Se o comando falhar, a saída de erro (STDERR) é impressa no terminal, mas não capturada na variável.

---

## 2. O Método `system`
Ideal para quando você quer saber apenas se o comando foi executado com **sucesso ou falha**, sem capturar a saída textual.

```ruby
resultado = system("mkdir nova_pasta")

if resultado
  puts "Pasta criada com sucesso!"
else
  puts "Falha ao criar pasta (talvez ela já exista)."
end
```
*   **Retorno:** `true` se o comando terminou com sucesso (exit code 0), `false` se houve erro, ou `nil` se o comando não existe.
*   **Saída:** A saída do comando é impressa diretamente no terminal.

---

## 3. O Método `exec`
Este método é único: ele **substitui o processo atual do Ruby** pelo comando solicitado. O script Ruby para de executar no momento em que o `exec` é chamado.

```ruby
puts "Vou listar os arquivos e fechar o script Ruby..."
exec "ls -la"
puts "Isso nunca será impresso!"
```
*   **Uso:** Raramente usado em scripts comuns, exceto quando você quer transformar o script Ruby em outro processo.

---

## 4. Open3 (A forma mais completa)
Se você precisa de controle total sobre a entrada, a saída e os erros (STDOUT e STDERR), utilize a biblioteca padrão `Open3`.

```ruby
require 'open3'

comando = "ls arquivo_que_nao_existe"

stdout, stderr, status = Open3.capture3(comando)

if status.success?
  puts "Sucesso: #{stdout}"
else
  puts "Erro detectado: #{stderr}"
  puts "Código de saída: #{status.exitstatus}"
end
```
*   **Vantagem:** Permite capturar erros separadamente da saída padrão e verificar o código de saída exato.

---

## 5. Resumo de Qual Usar:

| Método | Captura Saída? | Retorna Sucesso? | Encerra o Script? |
| :--- | :---: | :---: | :---: |
| **Backticks (``)** | Sim | Não | Não |
| **system** | Não | Sim | Não |
| **exec** | Não | N/A | Sim |
| **Open3** | Sim | Sim | Não |

## Cuidados com Segurança
**IMPORTANTE:** Nunca concatene variáveis de entrada de usuário diretamente em strings de comando. Isso abre brecha para **Shell Injection**.
```ruby
# PERIGOSO
usuario_input = "; rm -rf /"
system("ls #{usuario_input}") 

# SEGURO (Passando como argumentos separados)
system("ls", usuario_input)
```
