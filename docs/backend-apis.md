# Link do Repositório em que API foi desenvolvida

https://github.com/GabrielGNM/ApiAgendamentos

# APIs e Web Services

O sistema integrado visa solucionar a falta de informações e otimizar o processo de cadastramento e agendamento de pacientes no consultório de Davi Aburjeli, fisioterapeuta especializado. A aplicação será voltada para pacientes com dores crônicas e emocionais, oferecendo uma interface amigável para facilitar a administração de novos cadastros e a marcação de consultas. O objetivo é modernizar o sistema de gestão e comunicação com o público-alvo, proporcionando maior eficiência no atendimento e na retenção de clientes.
 
Ao planejar a aplicação de APIs Web para o sistema de Davi Aburjeli, é importante seguir as etapas fundamentais para garantir segurança, escalabilidade e eficiência. Aqui estão algumas etapas importantes a serem consideradas: Definição dos Endpoints; Segurança; Escalabilidade; Gerenciamento de Erros; Documentação; Testes Automatizados; Monitoramento.



# Objetivos da API

O nosso objetivo,utilizando essa API, é fornecer um sistema que seja capaz de realizar o gerenciamento de agendamentos e o gerenciamento de usuários.

<div align="center">
 <h4>Gerenciamento de Agendamentos:</h4>
</div>
-Permitir a criação, edição, visualização e exclusão de agendamentos.

-Integrar notificações de lembrete para usuários sobre seus agendamentos.



<div align="center">
 <h4>Gerenciamento de Usuários:</h4>
</div>
-Criar, editar e excluir perfis de usuários.

-Implementar autenticação e autorização para garantir que apenas usuários autorizados possam acessar funcionalidades específicas.
-Permitir a recuperação de senhas e o gerenciamento de informações de contato.


## Arquitetura

A arquitetura monolítica da API de Agendamento de Fisioterapia centraliza funcionalidades como gerenciamento de usuários, agendamentos de consultas, autenticação e autorização em uma única aplicação. Utilizando verbos HTTP para comunicação, a API segue padrões REST, onde verbos como GET, POST, PUT e DELETE são usados para buscar, criar, atualizar e remover dados. As requisições e respostas trafegam em formato JSON, interagindo com o banco de dados através do EntityFramework, que traduz as operações HTTP em consultas e comandos SQL. Todo o ciclo de request e response ocorre dentro do mesmo ambiente de execução, garantindo eficiência na comunicação entre o backend e o banco de dados.

<div align="center">

 ![image](https://github.com/user-attachments/assets/74640a19-1b20-498d-a88a-9e1aee616d64)




<h6> Figura 01 - Arquitetura da API </h6>

</div>

## Modelagem da Aplicação
O modelo relacional da API de Agendamento de Fisioterapia define duas entidades principais: Usuário e Agendamento. Cada Usuário possui atributos como nome, senha, email, telefone, tipo (cliente ou profissional) e perfil (administrador ou usuário). O Agendamento está relacionado tanto ao Usuário cliente quanto ao profissional, armazenando informações como nome do paciente, data de atendimento e emails envolvidos. A relação entre Usuário e Agendamento é do tipo muitos-para-muitos, onde um ou mais usuários pode estar associado a vários agendamentos. A autenticação e autorização são geridas via JWT.

<div align="center">
<img src="https://github.com/ICEI-PUC-Minas-PMV-SI/pmv-si-2024-2-pe6-t2-g09-agendamento-fisioterapia/blob/main/docs/img/PUC_eixo06_fluxoApp.jpg" > </img>

<h6> Figura 02 - Modelo Relacional </h6>

</div>





## Fluxo de Dados
<div align="center">

![image](https://github.com/user-attachments/assets/b486b0cb-c86c-435d-95b7-ee71908d7201)

 <h6> Figura 03 - Fluxo de Dados </h6>
</div>  


## Requisitos Funcionais

|ID    | Descrição do Requisito  | Prioridade |
|------|-----------------------------------------|----|
|RF-001| O sistema deve permitir o gerenciamento de cadastros na agenda | ALTA | 
|RF-002| O sistema deve enviar notificações ao usuário informando sobre o próximo atendimento agendado | MÉDIA |
|RF-003| O sistema deve permitir o gerenciamento de usuários | MÉDIA |
|RF-004| O sistema deve permitir que o usuário visualize o histórico de seus agendamentos anteriores | BAIXO |

## Requisitos Não Funcionais

|ID     | Descrição do Requisito  |Prioridade |
|-------|-------------------------|----|
|RNF-001| O sistema deve garantir que apenas usuários autenticados possam acessar dados pessoais e funcionalidades protegidas | ALTA |  
|RNF-002| O código deve ser modular e bem documentado, facilitando a manutenção e atualizaçoes futuras | ALTA | 
|RNF-003| O sistema deve cumprir com todas as regulamentações sobre a Proteção de dados e privacidade, como a LGPD | MÉDIA | 
|RNF-004| O sistema deve funcionar corretamente em diferentes sistemas operacionais móveis e suas versões mais recentes, incluindo iOS e Android |  ALTA | 


## Tecnologias Utilizadas

Tecnologias utilizadas na implementação da solução:

-.NET (C#): ASP.NET Core para desenvolvimento do backend, Visual Studio como IDE.

-JWT: Autenticação e autorização dos usuários.

-REST API: Comunicação entre o frontend e o backend, Formato de dados JSON.

-Clean Code: Princípios de codificação limpa para manter o código legível e manutenível.

-Arquitetura em Camadas: Separação de responsabilidades em camadas (Apresentação, Negócio, Dados).

-EntityFramework: ORM utilizado para interagir com o banco de dados SQL Server de forma eficiente e simplificada.

## API Endpoints

- 1- Buscar Todos Agendamentos
- Método: GET
- URL: /agendamentos
- Parâmetros: Nenhum
- Resposta:

  - Sucesso (200 OK)
 ```
{
  "message": "Success",
  "data": [ ... ]
}
  ```
  - Erro (4XX, 5XX)

  ```
{
  "message": "Error",
  "error": {

  }
}
  ```

- 2- Buscar Agendamento por Médico Responsável
- Método: GET
- URL: /agendamentos/{id}
 - Parâmetros:
- id: ID do médico responsável (inteiro)
- Resposta:

  - Sucesso (200 OK)
  ```
  {
  "message": "Success",
  "data": { ... }
  ]
  ```
  - Erro (422 Unprocessable Entity)

 ```
{
  "message": "Error",
  "error": "UmErroAqui"
}
  ```
  - Erro (204 No Content)
  ```
{
  "message": "No Content"
}
  ```

- 5- Cadastrar Agendamento
- Método: POST
- URL: /agendamentos
 - Parâmetros:
- Corpo: AgendamentoModel
-Resposta:
- Sucesso (201 Created)
  ```
  {
  "message": "Created",
  "data": { ... }
  }
  ```
- Erro (400 Bad Request)
  ```
  {
  "message": "Error",
  "error": { ... }
  }
    ```
  
- 6- Atualizar Data de Agendamento
- Método: PUT
- URL: /agendamentos/AtualizarData/{id}
 - Parâmetros:
- id: ID do agendamento (long)
-data: nova data (string, query)
-Resposta:

- Sucesso (200 OK)
    ```
  {
  "message": "Success",
  "data": { ... }
  } 
  ```
- Erro (400 Bad Request)
  ```
  {
  "message": "Error",
  "error": { ... }
  }
  
- 7- Deletar Agendamento
- Método: DELETE
- URL: /agendamentos/{id}
 - Parâmetros:
- id: ID do agendamento (inteiro)
-Resposta:
- Sucesso (200 OK)
  ```
  {
  "message": "Deleted"
  }
  
- 8- Buscar Todos os Usuários
- Método: GET
- URL: /usuarios
 - Parâmetros: Nenhum
-Resposta:

- Sucesso (200 OK)
  ```
  {
  "message": "Success",
  "data": [ ... ]
  }
  
- Erro (400 Bad Request)
  ```
  {
  "message": "Error",
  "error": { ... }
  }
  
- 9- Adicionar Usuário
- Método: POST
- URL: /usuarios
 - Parâmetros:
- Corpo: UsuarioDto
-Resposta:
- Sucesso (201 Created)
  ```
  {
  "message": "Created",
  "data": { ... }
  }
  
- Erro (400 Bad Request)
  ```
  {
  "message": "Error",
  "error": { ... }
  }
  
- 10- Buscar Usuário por ID
- Método: GET
- URL: /usuarios/{id}
 - Parâmetros:
- id: ID do usuário (inteiro)
-Resposta:

- Sucesso (200 OK)
  ```
  {
  "message": "Success",
  "data": { ... }
  }
  
- Erro (422 Unprocessable Entity)
  ```
  {
  "message": "Error",
  "error": "UmErroAqui"
  }
  
- Erro (204 No Content)
  ```
  {
  "message": "No Content"
  }
  
- 11- Atualizar Usuário
- Método: PUT
- URL: /usuarios/{id}
 - Parâmetros:
- id: ID do usuário (long)
-Corpo: UsuarioDto
-Resposta:
- Sucesso (200 OK)
  ```
  {
  "message": "Success",
  "data": { ... }
  }
  
- Erro (422 Unprocessable Entity)
  ```
  {
  "message": "Error",
  "error": "UmErroAqui"
  }
  
- Erro (400 Bad Request)
  ```
  {
  "message": "Error",
  "error": { ... }
  }
  
- 12- Deletar Usuário
- Método: DELETE
- URL: /usuarios/{id}
 - Parâmetros:
- id: ID do usuário (inteiro)
-Resposta:

- Sucesso (204 No Content)
  ```
  {
  "message": "Deleted" 
  }
  
- 13- Autenticar Usuário
- Método: POST
- URL: /usuarios/authenticate
 - Parâmetros:
- Corpo: AuthenticateDto
-Resposta:
- Sucesso (200 OK)
  ```
  {
  "jwtToken": "seu_token_jwt"
  }
  
- Erro (401 Unauthorized)
  ```
  {
  "message": "Unauthorized"
  }




## Considerações de Segurança

A aplicação implementa várias considerações de segurança essenciais para proteger os dados e garantir o acesso seguro aos recursos. A autenticação e autorização são geridas por meio de tokens JWT (JSON Web Tokens), onde cada token contém informações sobre o usuário e suas permissões, garantindo que somente usuários autenticados possam acessar a API. O sistema utiliza a Proteção de Rotas com Base em Perfis de Usuários (RBAC), assegurando que apenas usuários com perfis apropriados, como administradores ou profissionais, tenham acesso a rotas específicas. Além disso, a expiração dos tokens e sua renovação segura ajudam a prevenir o uso indevido em casos de comprometimento. Por fim, os tokens são assinados digitalmente, assegurando a integridade e autenticidade dos dados, garantindo que as informações não sejam adulteradas durante o tráfego. Essas medidas protegem a API contra ataques, como interceptação de dados e acesso não autorizado, além de manter a confidencialidade das informações sensíveis.

## Implantação

**Requisitos necessários de Hardware:**

-CPU de 4 núcleos ou mais

-Memória RAM no minimo 16 GB

-Armazenamento SSD de no mínimo 500 GB

-Conexão de rede de alta velocidade

**Requisitos necessários de Software:**

-Servidor de banco de dados SQLServer

-Servidor web

-Ambiente de execução: C# e .NET Core

-Windows

**Plataforma de Hopedagem:**

Será realizada a implantação na plataforma do Heroku e para configuração do ambiente será utilizado o buildpack.

## Testes

Os testes realizados utilizaram estratégias de testes unitários, usando métodos da classe de serviço. Através dessa abordagem, garantimos que cada método funcionasse corretamente de forma independente.
Além dos testes unitários, foram utilizadas ferramentas como Postman/Insomnia para realizar testes manuais na API. Testes foram feitos para verificar as requisições HTTP, como POST, GET, PUT e DELETE, diretamente no código, observando o comportamento da aplicação em tempo real e a comunicação correta entre as camadas da API."

<h4>Casos de Teste:</h4>
 
**Cenário de teste 1: Adicionar agendamento com sucesso**  
Dado que um agendamento válido é fornecido  
Quando o repositório de agendamento retorna sucesso na operação de adição de agendamento  
Então o método deve retornar uma resposta de sucesso contendo o agendamento criado  

**Cenário de teste 2: Adicionar agendamento inválido**  
Dado que um agendamento inválido é fornecido  
Quando o repositório de agendamento falha na operação de adição  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 3: Adicionar usuário com sucesso**  
Dado que um usuário válido é fornecido  
Quando o repositório de usuários retorna sucesso na operação de adição de usuário  
Então o método deve retornar uma resposta de sucesso contendo o usuário criado  

**Cenário de teste 4: Adicionar usuário inválido**  
Dado que um usuário inválido é fornecido  
Quando o repositório de usuários falha na operação de adição  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 5: Deletar usuário com sucesso**  
Dado que um usuário válido é fornecido para deleção  
Quando o repositório de usuários retorna sucesso na operação de deleção  
Então o método deve retornar uma resposta de sucesso confirmando a deleção do usuário  

**Cenário de teste 6: Deletar usuário inválido**  
Dado que um usuário inválido é fornecido para deleção  
Quando o repositório de usuários falha na operação de deleção  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 7: Deletar agendamento com sucesso**  
Dado que um agendamento válido é fornecido para deleção  
Quando o repositório de agendamentos retorna sucesso na operação de deleção  
Então o método deve retornar uma resposta de sucesso confirmando a deleção do agendamento  

**Cenário de teste 8: Deletar agendamento inválido**  
Dado que um agendamento inválido é fornecido para deleção  
Quando o repositório de agendamentos retorna falha na operação de deleção  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 9: Autenticar usuário com sucesso**  
Dado que um conjunto de credenciais válidas é fornecido  
Quando o serviço de autenticação retorna sucesso na operação de autenticação  
Então o método deve retornar um token de autenticação válido e uma resposta de sucesso  

**Cenário de teste 10: Autenticar usuário com falha**  
Dado que credenciais inválidas são fornecidas  
Quando o serviço de autenticação falha na operação de autenticação  
Então uma mensagem de falha de autenticação deve ser retornada pelo método  

**Cenário de teste 11: Atualizar usuário com sucesso**  
Dado que um usuário válido e as informações atualizadas são fornecidas  
Quando o repositório de usuários retorna sucesso na operação de atualização  
Então o método deve retornar uma resposta de sucesso contendo os dados do usuário atualizado  

**Cenário de teste 12: Atualizar usuário com falha**  
Dado que um usuário inválido ou dados inválidos são fornecidos  
Quando o repositório de usuários falha na operação de atualização  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 13: Atualizar data de agendamento com sucesso**  
Dado que um ID de agendamento válido e uma nova data válida são fornecidos  
Quando o repositório de agendamento retorna sucesso na operação de atualização  
Então o método deve retornar uma resposta de sucesso contendo o agendamento atualizado com a nova data  

**Cenário de teste 14: Atualizar data de agendamento com falha**  
Dado que um ID de agendamento inválido ou uma nova data inválida são fornecidos  
Quando o repositório de agendamento falha na operação de atualização  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 15: Buscar usuário por ID com sucesso**  
Dado que um ID de usuário válido é fornecido  
Quando o repositório de usuários retorna o usuário correspondente  
Então o método deve retornar os dados do usuário encontrado  

**Cenário de teste 16: Buscar usuário por ID com falha**  
Dado que um ID de usuário inválido é fornecido  
Quando o repositório de usuários não encontra o usuário correspondente  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 17: Buscar todos os usuários com sucesso**  
Dado que existem usuários cadastrados  
Quando o repositório de usuários retorna sucesso na operação de busca  
Então o método deve retornar uma lista de todos os usuários cadastrados  

**Cenário de teste 18: Buscar todos os usuários com falha**  
Dado que não há usuários cadastrados ou o repositório falha  
Quando o repositório de usuários falha na operação de busca  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 19: Buscar agendamento por médico com sucesso**  
Dado que o email do médico responsável válido é fornecido  
Quando o repositório de agendamento retorna sucesso na operação de busca  
Então o método deve retornar uma lista de agendamentos relacionados ao médico fornecido  

**Cenário de teste 20: Buscar agendamento por médico com falha**  
Dado que o email do médico responsável inválido é fornecido  
Quando o repositório de agendamento falha na operação de busca  
Então uma mensagem de falha deve ser retornada pelo método  

**Cenário de teste 21: Buscar todos os agendamentos com sucesso**  
Dado que existem agendamentos cadastrados  
Quando o repositório de agendamento retorna sucesso na operação de busca  
Então o método deve retornar uma lista de todos os agendamentos cadastrados  

**Cenário de teste 22: Buscar todos os agendamentos com falha**  
Dado que não há agendamentos cadastrados ou o repositório falha  
Quando o repositório de agendamento falha na operação de busca  
Então uma mensagem de falha deve ser retornada pelo método


# Referências

Inclua todas as referências (livros, artigos, sites, etc) utilizados no desenvolvimento do trabalho.
