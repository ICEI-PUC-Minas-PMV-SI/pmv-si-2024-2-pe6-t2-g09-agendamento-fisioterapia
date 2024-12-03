# Link do Repositório onde Front-end Móvel foi desenvolvido
A aplicação está na Branch App

https://github.com/ICEI-PUC-Minas-PMV-SI/pmv-si-2024-2-pe6-t2-g09-agendamento-fisioterapia 

# Front-end Móvel
O principal objetivo do nosso front-end mobile é otimizar o controle do fisioterapeuta sobre os agendamentos de consultas de fisioterapia. A aplicação será desenvolvida para permitir que o profissional gerencie seus horários de forma eficiente e prática, proporcionando maior organização e produtividade no dia a dia.

Principais Funcionalidades
Agenda Dinâmica
Uma ferramenta moderna e intuitiva será disponibilizada para que o fisioterapeuta visualize e gerencie sua agenda de maneira eficiente.

Facilitará o agendamento de consultas.
Evitará conflitos de horários.
Permitirá ajustes rápidos e simples.
Essa funcionalidade garantirá uma melhor organização da rotina do profissional, promovendo uma experiência mais prática e produtiva.

## Tecnologias Utilizadas
Tecnologias utilizadas na implementação da solução:

Flutter: Utilizamos o Flutter como framework para o desenvolvimento do aplicativo mobile. Ele nos permitiu criar uma interface de usuário responsiva e moderna, além de possibilitar o desenvolvimento multiplataforma (Android e iOS) com um único código base. A escolha do Flutter também se deu por sua alta performance e rica coleção de widgets personalizáveis, que facilitaram a criação de uma experiência intuitiva e eficiente para os usuários.

Android Studio: Para Emular o aplicativo. 

Visual Studio Code: Escolhemos o Visual Studio Code como nosso editor de código, o que torna nosso processo de desenvolvimento mais eficiente e organizado. Com uma vasta gama de extensões, o VS Code nos ajuda a aumentar nossa produtividade.

GitHub: Para garantir que todas as versões do projeto fossem devidamente salvas e compartilhadas entre a equipe, utilizamos o GitHub. Essa plataforma nos permitiu monitorar as mudanças no código, colaborar de maneira estruturada e garantir que todos os desenvolvedores pudessem contribuir sem confusões.

## Arquitetura

A aplicação foi estruturada em uma arquitetura baseada em camadas, onde o front-end mobile, desenvolvido em Flutter, se comunica diretamente com a API do back-end, implementada em C#. Essa API é responsável por buscar e enviar dados, garantindo uma separação clara entre a interface do usuário e a lógica de negócios. A comunicação entre o front-end mobile e o back-end é protegida com JWT (JSON Web Token), assegurando que apenas usuários autenticados possam acessar e manipular os dados, o que aumenta a segurança da aplicação. Essa abordagem não só garante um alto nível de segurança como também facilita a manutenção e escalabilidade, permitindo a adição de novas funcionalidades de forma organizada e eficiente.


## Modelagem da Aplicação

![image](https://github.com/user-attachments/assets/e567e077-0617-4504-acb1-0d6d85c7d2aa)


## Projeto da Interface
A interface mobile da aplicação de Agendamento de Fisioterapia é intuitiva e visualmente limpa, focada em oferecer uma experiência agradável para o fisioterapeuta Davi. Assim que acessar a aplicação o usuário é direcionado para  o login, no  qual o fisioterapeuta Davi já pode-ra gerenciar pacientes e agendamentos. No desenvolvimento da aplicação foi pensando em todos os detalhes como transições suaves e feedback visual melhoram a interatividade, otimizando os  agendamentos.

### Wireframes

Tela de login e cadastro de usuário                                                 
![image](https://github.com/user-attachments/assets/506b1f27-da43-4772-82b3-a3c7f3c0c1ae) 

Tela apagar usuário

![image](https://github.com/user-attachments/assets/5c87b93c-1190-48fb-8363-58f3542b7ea3)


Tela de agendamento e cadastro de agendamento  

![image](https://github.com/user-attachments/assets/6c19e385-abcc-4b81-87b0-4e11e380585e)

Tela de editar agendamento e remover agendamento

![image](https://github.com/user-attachments/assets/ba19bbc4-1102-454e-a169-247a05fc0dba)

Tela inicial e agenda

![image](https://github.com/user-attachments/assets/bea33748-3be6-4875-a91e-3dc9ceb0c286)










### Design Visual

![Imagem do WhatsApp de 2024-11-19 à(s) 19 18 01_f0cf8b32](https://github.com/user-attachments/assets/60762b9d-64ab-4cf6-ad8c-9b16694ce11b) ![Imagem do WhatsApp de 2024-11-19 à(s) 19 18 10_36b2c77c](https://github.com/user-attachments/assets/0d53c0fe-552d-4653-bdb8-f6a140594b6f)

![Imagem do WhatsApp de 2024-11-19 à(s) 19 18 44_52fa0300](https://github.com/user-attachments/assets/61568f33-7b26-45e8-881e-027d37a40218) ![Imagem do WhatsApp de 2024-11-19 à(s) 19 18 45_306ceddd](https://github.com/user-attachments/assets/8f4ebbca-c73d-4ec3-8492-d081d04c4597)

![Imagem do WhatsApp de 2024-11-19 à(s) 19 18 45_4525f486](https://github.com/user-attachments/assets/9623645c-d160-425f-a429-710e90404aca) ![Imagem do WhatsApp de 2024-11-19 à(s) 19 18 46_03c615fd](https://github.com/user-attachments/assets/f33e0efa-ed53-4eb7-9d04-0fe1f34d22e0)

![Imagem do WhatsApp de 2024-11-19 à(s) 19 20 01_d6f83f0a](https://github.com/user-attachments/assets/bcbd2322-4325-45b5-8809-b442c4747d9c) ![Imagem do WhatsApp de 2024-11-20 à(s) 14 26 25_9d557b7a](https://github.com/user-attachments/assets/c3accb85-42f0-46ab-b905-11f11d316686)



### Layout Responsivo

No Flutter, a interface do sistema será projetada para ser totalmente responsiva, garantindo uma experiência consistente para os usuários, independentemente do dispositivo utilizado, como smartphones, tablets ou telas maiores. Para alcançar essa adaptabilidade, será utilizado o MediaQuery, que fornece informações sobre as dimensões, orientação da tela e densidade de pixels do dispositivo em uso.

A aplicação ajustará automaticamente elementos como:

Margens e espaçamentos, garantindo que o layout permaneça legível e organizado;

Tamanhos de fontes, proporcionando uma leitura confortável em diferentes telas;

Disposição de widgets, adaptando-se às mudanças de orientação (retrato ou paisagem) e otimizando o uso do espaço disponível.

### Interações do Usuário
A interface da aplicação de Agendamento de Fisioterapia foi projetada com foco na simplicidade e funcionalidade, proporcionando uma experiência agradável e eficiente. As principais interações incluem: 

Página de Login: 
 1. O fisioterapeuta pode realizar login ou se registrar facilmente através de campos claros e botões visíveis.
 2. Mensagens de erro ou sucesso são exibidas instantaneamente em caso de dados inválidos ou autenticação bem-sucedida, respectivamente.
 3.  Após o login, o fisioterapeuta é direcionado para sua área de trabalho principal, evitando confusão.

Gerenciamento de Agendamentos e Pacientes:
1. O fisioterapeuta pode acessar a agenda com poucos cliques, visualizando compromissos do dia ou da semana.
2. As funções de adicionar, editar ou excluir agendamentos e informações de pacientes são apresentadas de maneira clara, com etapas simplificadas.
3.O sistema notifica sobre alterações ou ações importantes, como cancelamentos ou novos agendamentos.

A interface foi desenvolvida para ser limpa e responsiva, com cores neutras, ícones claros e um layout adaptado para dispositivos móveis e desktops, garantindo uma experiência consistente. O design inclusivo prioriza acessibilidade, com fontes legíveis, botões de tamanho adequado e suporte à navegação por teclado. Elementos interativos, como botões e links, oferecem feedback visual através de mudanças sutis, como alterações de cor e sombreamento, enquanto transições suaves tornam a navegação mais fluida e intuitiva.

## Fluxo de Dados

O fluxo de dados na aplicação foi projetado para ser simples e eficiente. Ao acessar a aplicação, o fisioterapeuta é recebido na tela de login, onde pode optar por realizar o login, caso já tenha cadastro, ou se registrar, caso contrário. Durante o login, as credenciais fornecidas são enviadas à API de autenticação, que verifica os dados e, se corretos, redireciona o usuário para a Home Interna.

Na Home Interna, o usuário encontra duas funcionalidades principais:

Pacientes:
Nesta área, o fisioterapeuta pode visualizar, adicionar, editar e consultar dados de pacientes.
Cada ação (busca, cadastro, atualização ou consulta) interage diretamente com a API de gerenciamento de pacientes, que processa e retorna as informações necessárias em tempo real.

Agendamentos:
O fisioterapeuta pode criar, visualizar e editar agendamentos de sessões ou consultas.
Todas as operações relacionadas a agendamentos são enviadas para a API de agendamentos, que gerencia a criação, atualização e recuperação de informações de forma integrada.

## Requisitos Funcionais

|ID    | Descrição do Requisito  | Prioridade |
|------|-----------------------------------------|----|
|RF-001| O sistema deve permitir ao fisioterapeuta gerenciar os horários de consultas em uma agenda dinâmica.	 | ALTA | 
|RF-002| O sistema deve incluir um mecanismo de recuperação de senha. 	 | MÉDIA |
|RF-003| O sistema deve permitir que usuários (fisioterapeutas) realizem login utilizando e-mail e senha. | MÉDIA |
|RF-003| O sistema deve permitir o gerenciamento de usuários | MÉDIA |



## Requisitos Não Funcionais

|ID     | Descrição do Requisito  |Prioridade |
|-------|-------------------------|----|
|RNF-001| A interfrace deve se intiutiva e de fácil de usar| ALTA |  
|RNF-002| O sistema deve ser compactivel com diferentes dispositivos | ALTA | 
|RNF-003| O sistema deve ser Responsível	| MÉDIA |



## Considerações de Segurança

Autenticação com JWT: O uso de JSON Web Tokens (JWT) permite uma autenticação segura e escalável, onde o servidor gera um token assinado digitalmente ao fazer login. Esse token, que contém informações sobre o usuário, é enviado em cada requisição para validar a identidade do usuário sem a necessidade de sessões no servidor.

Validação de Dados: A validação de dados garante que as entradas do usuário estejam no formato correto e sejam seguras. Enquanto a validação no front-end melhora a experiência do usuário, a validação no back-end é crucial para prevenir ataques, como injeção de SQL, garantindo que apenas dados seguros sejam processados.

Criptografia da Senha no Banco de Dados: As senhas dos usuários são armazenadas de forma segura utilizando algoritmos de hash, o que significa que mesmo que o banco de dados seja comprometido, as senhas não podem ser facilmente recuperadas. Isso protege a privacidade dos usuários e dificulta ataques.

Comunicação com HTTPS: O protocolo HTTPS é utilizado para garantir uma comunicação segura entre o cliente e o servidor. Isso protege os dados transmitidos, como senhas e informações pessoais, de serem interceptados durante o tráfego, assegurando a confidencialidade e integridade das informações.

## Implantação

Requisitos necessários de Hardware e Software:

CPU de 4 núcleos ou mais
Memória RAM no mínimo 8 GB
Armazenato SSD de no mínimo 256GB
Conexão de rede de alta velocidade
Servidor de banco de dados SQLServer
Servidor web
Ambiente de execução: C#: Para backend com .NET Core. e Dart: Para desenvolvimento do aplicativo Flutter.
Windows

## Testes

**Cenário: Cadastro de usuário e login**

Na tela inicial serão demonstrados os campos e-mail e senha para login, caso o usuário ainda não esteja cadastrado, clicando sobre a opção "Criar Conta" será direcionado à tela de cadastro de usuário.

![image](https://github.com/user-attachments/assets/ddc99479-3242-41d7-9cea-cb6e87eeb4be)


Na tela de cadastro de usuário é necessário informar o nome, senha, e-mail, telefone de contato, tipo de usuario e perfil para então realizar o cadastro. 

![image](https://github.com/user-attachments/assets/b0649f9c-9fbf-4062-a421-d927b394fc1a)


Assim que efetuar o registro será retornado automaticamente para a tela de login.

# Referências

Inclua todas as referências (livros, artigos, sites, etc) utilizados no desenvolvimento do trabalho.
