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

[Instruções para implantar a aplicação distribuída em um ambiente de produção.]

1. Defina os requisitos de hardware e software necessários para implantar a aplicação em um ambiente de produção.
2. Escolha uma plataforma de hospedagem adequada, como um provedor de nuvem ou um servidor dedicado.
3. Configure o ambiente de implantação, incluindo a instalação de dependências e configuração de variáveis de ambiente.
4. Faça o deploy da aplicação no ambiente escolhido, seguindo as instruções específicas da plataforma de hospedagem.
5. Realize testes para garantir que a aplicação esteja funcionando corretamente no ambiente de produção.

## Testes

Os testes realizados utilizaram estratégias de testes unitários, usando métodos da classe de serviço. Através dessa abordagem, garantimos que cada método funcionasse corretamente de forma independente.
Além dos testes unitários, foram utilizadas ferramentas como Postman/Insomnia para realizar testes manuais na API. Testes foram feitos para verificar as requisições HTTP, como POST, GET, PUT e DELETE, diretamente no código, observando o comportamento da aplicação em tempo real e a comunicação correta entre as camadas da API."

 <h4>Casos de Teste:</h4>


Caso de Teste 1: Adicionar Agendamento com Sucesso
Objetivo: Verificar se o método AdicionarAgendamentoAsync adiciona corretamente um agendamento quando todas as condições são atendidas. Caso alguma condição não atenda ao requisito, o método deve retornar a mensagem de erro correspondente ao usuário.

Dado que um agendamento válido é fornecido,
Quando o repositório de agendamento retorna sucesso na operação de adição,
Então o método deve:
Retornar uma resposta de sucesso contendo o agendamento criado.

Cenário alternativo:
Dado que um agendamento inválido ou erro de repositório ocorre,
Quando o repositório de agendamento falha na operação de adição,
Então o método deve:
Retornar uma mensagem de falha ("Falha ao Cadastrar Agendamento").


# Referências

Inclua todas as referências (livros, artigos, sites, etc) utilizados no desenvolvimento do trabalho.
