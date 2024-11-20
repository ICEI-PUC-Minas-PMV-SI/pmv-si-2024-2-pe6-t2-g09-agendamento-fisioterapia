# Link do Repositório onde aplicação  mobile foi desenvolvida
Colocar o Link

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

Visual Studio Code: Escolhemos o Visual Studio Code como nosso editor de código, o que torna nosso processo de desenvolvimento mais eficiente e organizado. Com uma vasta gama de extensões, o VS Code nos ajuda a aumentar nossa produtividade.

GitHub: Para garantir que todas as versões do projeto fossem devidamente salvas e compartilhadas entre a equipe, utilizamos o GitHub. Essa plataforma nos permitiu monitorar as mudanças no código, colaborar de maneira estruturada e garantir que todos os desenvolvedores pudessem contribuir sem confusões.


## Arquitetura

A aplicação foi estruturada em uma arquitetura baseada em camadas, onde o front-end mobile, desenvolvido em Flutter, se comunica diretamente com a API do back-end, implementada em C#. Essa API é responsável por buscar e enviar dados, garantindo uma separação clara entre a interface do usuário e a lógica de negócios. A comunicação entre o front-end mobile e o back-end é protegida com JWT (JSON Web Token), assegurando que apenas usuários autenticados possam acessar e manipular os dados, o que aumenta a segurança da aplicação. Essa abordagem não só garante um alto nível de segurança como também facilita a manutenção e escalabilidade, permitindo a adição de novas funcionalidades de forma organizada e eficiente.


## Modelagem da Aplicação

![image](https://github.com/user-attachments/assets/e567e077-0617-4504-acb1-0d6d85c7d2aa)


## Projeto da Interface
[Descreva o projeto da interface móvel da aplicação, incluindo o design visual, layout das páginas, interações do usuário e outros aspectos relevantes.]

### Wireframes
[Inclua os wireframes das páginas principais da interface, mostrando a disposição dos elementos na página.]

### Design Visual
[Descreva o estilo visual da interface, incluindo paleta de cores, tipografia, ícones e outros elementos gráficos.]

### Layout Responsivo
[Discuta como a interface será adaptada para diferentes tamanhos de tela e dispositivos.]

### Interações do Usuário
[Descreva as interações do usuário na interface, como animações, transições entre páginas e outras interações.]

## Fluxo de Dados

[Diagrama ou descrição do fluxo de dados na aplicação.]




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

[Discuta as considerações de segurança relevantes para a aplicação distribuída, como autenticação, autorização, proteção contra ataques, etc.]

## Implantação

[Instruções para implantar a aplicação distribuída em um ambiente de produção.]

1. Defina os requisitos de hardware e software necessários para implantar a aplicação em um ambiente de produção.
2. Escolha uma plataforma de hospedagem adequada, como um provedor de nuvem ou um servidor dedicado.
3. Configure o ambiente de implantação, incluindo a instalação de dependências e configuração de variáveis de ambiente.
4. Faça o deploy da aplicação no ambiente escolhido, seguindo as instruções específicas da plataforma de hospedagem.
5. Realize testes para garantir que a aplicação esteja funcionando corretamente no ambiente de produção.

## Testes

[Descreva a estratégia de teste, incluindo os tipos de teste a serem realizados (unitários, integração, carga, etc.) e as ferramentas a serem utilizadas.]

1. Crie casos de teste para cobrir todos os requisitos funcionais e não funcionais da aplicação.
2. Implemente testes unitários para testar unidades individuais de código, como funções e classes.
3. Realize testes de integração para verificar a interação correta entre os componentes da aplicação.
4. Execute testes de carga para avaliar o desempenho da aplicação sob carga significativa.
5. Utilize ferramentas de teste adequadas, como frameworks de teste e ferramentas de automação de teste, para agilizar o processo de teste.

# Referências

Inclua todas as referências (livros, artigos, sites, etc) utilizados no desenvolvimento do trabalho.
