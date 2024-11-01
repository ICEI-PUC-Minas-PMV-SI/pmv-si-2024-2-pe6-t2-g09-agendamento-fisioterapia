# Link Repositório no qual Front-end foi desenvolvido 

https://github.com/Allandpn/PUCMInas-Eixo06

# Front-end Web

O principal objetivo do nosso Front-end Web é otimizar o processo de agendamento de consultas de fisioterapia, ao mesmo tempo em que aumenta a visibilidade dos serviços especializados oferecidos pelo fisioterapeuta Davi.
A aplicação permitirá que o fisioterapeuta gerencie eficientemente seus horários, além de facilitar a comunicação com seus pacientes de forma prática e ágil. Entre as principais funcionalidades, estão:
- Contato direto via WhatsApp: Um link rápido e acessível para que os pacientes possam entrar em contato diretamente com o fisioterapeuta, agilizando o atendimento e o esclarecimento de dúvidas. 
 - Integração com Instagram: Através de uma API, será possível exibir as atualizações e conteúdos das redes sociais do fisioterapeuta, oferecendo uma vitrine de seus serviços e resultados para os pacientes. 
 - Agenda dinâmica: Ferramenta para que o fisioterapeuta possa visualizar e gerenciar sua agenda de forma eficiente, facilitando o agendamento de consultas e garantindo uma melhor organização dos horários. 
Essa solução busca não só otimizar a gestão de agendamentos, mas também estreitar o relacionamento com os pacientes e ampliar a visibilidade dos serviços oferecidos.


## Tecnologias Utilizadas
Tecnologias utilizadas na implementação da solução: 

- React: No front-end da aplicação, optamos por utilizar o React, uma das principais bibliotecas JavaScript para a criação de interfaces dinâmicas e responsivas. É importante ressaltar que o React não apenas melhora a velocidade do site, mas também proporciona uma experiência mais agradável para os usuários. A biblioteca nos permite desenvolver componentes reutilizáveis, facilitando o desenvolvimento mobile.

- CSS: Para estilizar a aplicação, utilizamos CSS, que nos permite criar layouts atraentes e responsivos. Com a ajuda de pré-processadores como SASS ou ferramentas como Tailwind CSS, conseguimos otimizar nosso fluxo de trabalho, proporcionando um design mais consistente e flexível.

- Visual Studio Code: Escolhemos o Visual Studio Code como nosso editor de código, o que torna nosso processo de desenvolvimento mais eficiente e organizado. Com uma vasta gama de extensões, o VS Code nos ajuda a aumentar nossa produtividade.

- GitHub: Para garantir que todas as versões do projeto fossem devidamente salvas e compartilhadas entre a equipe, utilizamos o GitHub. Essa plataforma nos permitiu monitorar as mudanças no código, colaborar de maneira estruturada e garantir que todos os desenvolvedores pudessem contribuir sem confusões.

- Outras Tecnologias: Além das ferramentas mencionadas, também consideramos o uso de bibliotecas adicionais, como Axios para gerenciar requisições HTTP, e frameworks como Bootstrap ou Material-UI para facilitar a criação de componentes com design pré-definido.

## Arquitetura

A aplicação será estruturada em uma arquitetura modular, onde o front-end, desenvolvido em React, se comunica diretamente com a API do back-end, implementada em C#. Essa API é responsável por buscar e enviar dados, garantindo uma separação clara entre a interface do usuário e a lógica de negócios. Além disso, a comunicação entre o front-end e o back-end é protegida com JWT (JSON Web Token), assegurando que apenas usuários autenticados possam acessar e manipular os dados, o que aumenta a segurança da aplicação.

## Modelagem da Aplicação
[Descreva a modelagem da aplicação, incluindo a estrutura de dados, diagramas de classes ou entidades, e outras representações visuais relevantes.]

1. Entidades e Estrutura de Dados
   
Usuário

id: Identificador único

nome: Nome do usuário

email: Email do usuário
senha: Senha para autenticação
tipo: Tipo de usuário (ex: administrador, paciente, fisioterapeuta)
dataCadastro: Data de cadastro na aplicação
Paciente

id: Identificador único
nome: Nome do paciente
dataNascimento: Data de nascimento
contato: Contato telefônico ou email
historicoMedico: Histórico de condições médicas relevantes
usuarioId: Relacionamento com a entidade Usuário
Agendamento

id: Identificador único
pacienteId: Identificador do paciente relacionado
fisioterapeutaId: Identificador do fisioterapeuta responsável
dataHora: Data e hora do agendamento
status: Status do agendamento (ex: confirmado, pendente, concluído)
observacoes: Observações adicionais sobre a sessão
Fisioterapeuta

id: Identificador único
nome: Nome do fisioterapeuta
especialidade: Área de especialidade
contato: Informações de contato
usuarioId: Relacionamento com a entidade Usuário

![entidades_diagrama](https://github.com/user-attachments/assets/c13f5357-3b4b-4ca0-bcc4-3bc3e9444db0)


## Projeto da Interface Web
[Descreva o projeto da interface Web da aplicação, incluindo o design visual, layout das páginas, interações do usuário e outros aspectos relevantes.]

### Wireframes

Login Fisioterapeuta 

![image](https://github.com/user-attachments/assets/3ef17341-7f7a-478d-a74f-e6d92fe5df53)

Criação de Conta

![image](https://github.com/user-attachments/assets/034268e3-ac17-40e4-bad1-19b24f4b5fa0)

Login Usuário

![image](https://github.com/user-attachments/assets/b54a7363-3539-46cd-a09c-ecfef311ac18)

Gerencimento Agenda 

![image](https://github.com/user-attachments/assets/631c2656-210f-4afa-9f2a-fb2fb1bed5a6)

Dashboard

![image](https://github.com/user-attachments/assets/23ae923d-d5fd-468e-a608-53227ded68a2)

![image](https://github.com/user-attachments/assets/2ed65016-e236-498e-b9dc-4509afcfeb17)

![image](https://github.com/user-attachments/assets/d19c753f-b2c5-4a23-a470-ae17fc5fe591)


[Inclua os wireframes das páginas principais da interface, mostrando a disposição dos elementos na página.]

### Design Visual
[Descreva o estilo visual da interface, incluindo paleta de cores, tipografia, ícones e outros elementos gráficos.]

### Layout Responsivo
[Discuta como a interface será adaptada para diferentes tamanhos de tela e dispositivos.]

### Interações do Usuário
[Descreva as interações do usuário na interface, como animações, transições entre páginas e outras interações.]

## Fluxo de Dados

Home:

A partir da Home, o usuário pode acessar o Instagram ou o Facebook do fisioterapeuta.
O usuário também tem a opção de enviar uma mensagem diretamente para o WhatsApp do fisioterapeuta.
O usuário pode acessar a tela de Login.

Login
Na tela de Login, o usuário pode optar por Registrar-se caso ainda não tenha uma conta.
Caso o usuário já possua um cadastro e realize o login, as credenciais são enviadas para a API de autenticação.
Se o login for bem-sucedido, o usuário é redirecionado para a Home Interna.

Registrar-se
Na tela de Registrar-se, o usuário preenche as informações necessárias para criar uma conta.
Essas informações são enviadas para a API de cadastro.
Após a criação bem-sucedida da conta, o usuário é automaticamente redirecionado para a Home Interna.

Home Interna:
Na Home Interna, o usuário tem acesso a duas funcionalidades principais:

Pacientes:
Acessando a área de pacientes, o usuário pode ver, adicionar, editar e consultar os dados dos pacientes.
As operações de busca, cadastro, atualização e consulta de informações são enviadas e recebidas pela API de gerenciamento de pacientes.

Agendamentos:
Acessando a área de agendamentos, o usuário pode criar, visualizar e editar agendamentos de sessões ou consultas.
Todas as operações de agendamento são processadas pela API de agendamentos, que lida com a criação, atualização e recuperação de dados relacionados a sessões.


## Requisitos Funcionais

|ID    | Descrição do Requisito  | Prioridade |
|------|-----------------------------------------|----|
|RF-001| 	O sistema deve permitir a integração com o Instagram para exibir as últimas publicações	 | ALTA | 
|RF-002| O sistema deve ter uma seção dedicada no site para informações sobre o serviço | MÉDIA |
|RF-003| O sistema deve oferecer uma funcionalidade para direcionar o usuário ao WhatsApp para facilitar a comunicação. | MÉDIA |


## Requisitos Não Funcionais

|ID     | Descrição do Requisito  |Prioridade |
|-------|-------------------------|----|
|RNF-001| A interfrace deve se intiutiva e de fácil de usar| ALTA |  
|RNF-002| O sistema deve ser compactivel com diferentes navegadores | ALTA | 
|RNF-003| O sistema deve ser Responsível	| MÉDIA |
|RNF-004|O sistema deve funcionar corretamente em diferentes sistemas operacionais móveis e suas versões mais recentes, incluindo iOS e Android| MÉDIA |




## Considerações de Segurança

Autenticação com JWT: O uso de JSON Web Tokens (JWT) permite uma autenticação segura e escalável, onde o servidor gera um token assinado digitalmente ao fazer login. Esse token, que contém informações sobre o usuário, é enviado em cada requisição para validar a identidade do usuário sem a necessidade de sessões no servidor.

Validação de Dados: A validação de dados garante que as entradas do usuário estejam no formato correto e sejam seguras. Enquanto a validação no front-end melhora a experiência do usuário, a validação no back-end é crucial para prevenir ataques, como injeção de SQL, garantindo que apenas dados seguros sejam processados.

Criptografia da Senha no Banco de Dados: As senhas dos usuários são armazenadas de forma segura utilizando algoritmos de hash, o que significa que mesmo que o banco de dados seja comprometido, as senhas não podem ser facilmente recuperadas. Isso protege a privacidade dos usuários e dificulta ataques.

Comunicação com HTTPS: O protocolo HTTPS é utilizado para garantir uma comunicação segura entre o cliente e o servidor. Isso protege os dados transmitidos, como senhas e informações pessoais, de serem interceptados durante o tráfego, assegurando a confidencialidade e integridade das informações.

## Implantação

**Requisitos necessários de Hardware e Software:**

- CPU de 4 núcleos ou mais
- Memória RAM no mínimo 4 GB
- Armazenato SSD de no mínimo 256GB
- Conexão de rede de alta velocidade
- Servidor de banco de dados SQLServer
- Servidor web
- Ambiente de execução: C#, .NET Core e React
- Windows




## Testes

[Descreva a estratégia de teste, incluindo os tipos de teste a serem realizados (unitários, integração, carga, etc.) e as ferramentas a serem utilizadas.]

1. Crie casos de teste para cobrir todos os requisitos funcionais e não funcionais da aplicação.
2. Implemente testes unitários para testar unidades individuais de código, como funções e classes.
3. Realize testes de integração para verificar a interação correta entre os componentes da aplicação.
4. Execute testes de carga para avaliar o desempenho da aplicação sob carga significativa.
5. Utilize ferramentas de teste adequadas, como frameworks de teste e ferramentas de automação de teste, para agilizar o processo de teste.

# Referências

Inclua todas as referências (livros, artigos, sites, etc) utilizados no desenvolvimento do trabalho.
