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

- CPU de 4 núcleos ou mais

- Memória RAM no minimo 16 GB

- Armazenamento SSD de no mínimo 500 GB

- Conexão de rede de alta velocidade

**Requisitos necessários de Software:**

- Servidor de banco de dados SQLServer

- Servidor web

- Ambiente de execução: C# e .NET Core

- Windows

**Preparando o ambiente**

Instalar .NET8.0 (https://dotnet.microsoft.com/en-us/download/dotnet/8.0);

Instalar SQL Server 2022 (https://www.microsoft.com/en-us/sql-server/sql-server-downloads);

instalar Visual Studio (https://visualstudio.microsoft.com/downloads/);

Instalar Git (https://git-scm.com/downloads);

Criar Database Engine com SQL Server (https://learn.microsoft.com/en-us/sql/relational-databases/database-engine-tutorials?view=sql-server-ver16).




**Executando no Ambiente**

Clonar repositório do projeto em ambiente local;  
git clone https://github.com/ICEI-PUC-Minas-PMV-SI/pmv-si-2024-2-pe6-t2-g09-agendamento-fisioterapia.git

Abrir a aplicação no Visual Studio;

Configurar conexão com o banco no appsettings.json. Substituir parâmetro "Server" em "DefaultConnection" para o servidor do SQL Server criado anteriormente;

Executar migrações para o banco de dados, abrir Console de Gerenciamento de Pacotes (Ferramenteas > Gerenciador de Pacotes NuGet > Console de Gerenciamento de Pacotes) e rodar os comandos:

*Add-Migration InitialCreate*

*Update-Database*

Rodar o projeto pelo botão iniciar no Visual Studio (Ctrl+F5);

Acessar Swagger do projeto em: https://localhost:5000/swagger.

**Plataforma de Hopedagem:**

Será realizada a implantação na plataforma do Heroku e para configuração do ambiente será utilizado o buildpack.

## Testes


Foram realizados testes de validação da API que conforme as imagens abaixo pode se observar o retorno de acordo com a solicitação dos métodos GET/PUT/POST/DELETE que validam a funcionalidade dos mesmos.


## Casos de teste AGENDAMENTO:

### Cenário: Consultar um agendamento existente
- **Dado** que estou na aplicação
- **E** existe um agendamento com o ID "123"
- **Quando** faço uma requisição GET para "/agendamentos/123"
- **Então** devo receber o status 200
- **E** o corpo da resposta deve ter os dados do agendamento com o ID "123"

### Cenário: Criar um novo agendamento
- **Dado** que estou na aplicação
- **E** forneço os dados válidos para o novo agendamento
- **Quando** faço uma requisição POST para "/agendamentos"
- **Então** devo receber o status 201
- **E** o corpo da resposta deve ter os dados do novo agendamento criado

### Cenário: Excluir um agendamento existente
- **Dado** que estou na aplicação
- **E** existe um agendamento com o ID "123"
- **Quando** faço uma requisição DELETE para "/agendamentos/123"
- **Então** devo receber o status 200
- **E** uma mensagem confirmando que o agendamento foi excluído

### Cenário: Atualizar um agendamento existente com POST
- **Dado** que estou na aplicação
- **E** existe um agendamento com o ID "123"
- **E** forneço novos dados válidos para esse agendamento
- **Quando** faço uma requisição POST para "/agendamentos/123"
- **Então** devo receber o status 200
- **E** o corpo da resposta deve ter os dados atualizados do agendamento

---

## Casos de teste USUÁRIO:

### Cenário: Criar um novo usuário
- **Dado** que estou na aplicação
- **E** forneço dados válidos para o novo usuário
- **Quando** faço uma requisição POST para "/usuario"
- **Então** devo receber o status 201
- **E** o corpo da resposta deve ter os dados do novo usuário criado

### Cenário: Consultar um usuário existente
- **Dado** que estou autenticado na aplicação
- **E** existe um usuário com o ID "123"
- **Quando** faço uma requisição GET para "/usuario/123"
- **Então** devo receber o status 200
- **E** o corpo da resposta deve ter os dados do usuário com o ID "123"

### Cenário: Atualizar um usuário existente
- **Dado** que estou autenticado na aplicação
- **E** existe um usuário com o ID "123"
- **E** forneço novos dados válidos para esse usuário
- **Quando** faço uma requisição PUT para "/usuario/123"
- **Então** devo receber o status 200
- **E** o corpo da resposta deve ter os dados atualizados do usuário

### Cenário: Autenticar um usuário com sucesso
- **Dado** que forneço um ID e senha válidos
- **Quando** faço uma requisição POST para "/usuario/authenticate"
- **Então** devo receber o status 200
- **E** o corpo da resposta deve conter um token de autenticação

### Cenário: Listar todos os usuários
- **Dado** que estou autenticado na aplicação
- **Quando** faço uma requisição GET para "/usuario"
- **Então** devo receber o status 200
- **E** o corpo da resposta deve conter uma lista de todos os usuários

### Cenário: Excluir um usuário existente
- **Dado** que estou autenticado na aplicação
- **E** existe um usuário com o ID "123"
- **Quando** faço uma requisição DELETE para "/usuarios/123"
- **Então** devo receber o status 200
- E uma mensagem confirmando que o usuário foi excluído



Evidência de Teste: 

Consta-se abaixo os prints dos testes da funcionalidade AGENDAMENTO:

GET
![Imagem do WhatsApp de 2024-09-28 à(s) 21 29 13_c4534e60](https://github.com/user-attachments/assets/f7de7f03-08da-4774-a66b-c35202a2c742)

GET
![Imagem do WhatsApp de 2024-09-28 à(s) 21 29 12_eae623c6](https://github.com/user-attachments/assets/6aa2a940-f48d-43d9-a5be-f7bb62171bc1)

DELETE
![Imagem do WhatsApp de 2024-09-28 à(s) 21 29 12_5fce34f3](https://github.com/user-attachments/assets/2ab03537-a5c0-4c2d-9317-d332ee8b423b)

POST
![Imagem do WhatsApp de 2024-09-28 à(s) 21 29 12_499adf51](https://github.com/user-attachments/assets/cb344103-9373-44ed-a80c-28d54460fe87)




Dessa forma consta-se abaixo os prints dos testes da funcionalidade USUARIO :

POST
![image](https://github.com/user-attachments/assets/cc97f14d-b66d-47cc-aa00-a16452128d57)

POST Authenticate:
![image](https://github.com/user-attachments/assets/9e25b4c5-4e78-4264-b2ef-32bbcf17f0d4)


DELETE:
![image](https://github.com/user-attachments/assets/97245e7e-6169-49d5-b6c8-5b3f4aa64b5d)

GET: 
![image](https://github.com/user-attachments/assets/ab5c8e60-b547-4c57-a6cf-510e6bb43589)


PUT: 

![image](https://github.com/user-attachments/assets/16db116f-d4cf-499c-b9b2-cd179e9e84d7)




# Referências

Inclua todas as referências (livros, artigos, sites, etc) utilizados no desenvolvimento do trabalho.
