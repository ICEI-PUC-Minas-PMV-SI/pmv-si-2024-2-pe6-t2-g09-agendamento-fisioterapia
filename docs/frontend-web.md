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

A aplicação será estruturada em uma arquitetura baseada em componente , onde o front-end, desenvolvido em React, se comunica diretamente com a API do back-end, implementada em C#. Essa API é responsável por buscar e enviar dados, garantindo uma separação clara entre a interface do usuário e a lógica de negócios. Além disso, a comunicação entre o front-end e o back-end é protegida com JWT (JSON Web Token), assegurando que apenas usuários autenticados possam acessar e manipular os dados, o que aumenta a segurança da aplicação.

## Modelagem da Aplicação

A aplicação possui as seguintes entidades:

Usuário: Cada usuário possui um identificador único (id), um nome (nome), um email (email), uma senha (senha). 

Paciente: Cada paciente possui um identificador único (id), um nome (nome), uma data de nascimento (dataNascimento), informações de contato (contato, como telefone ou email) e um identificador de usuário (usuarioId). 

Agendamento: Cada agendamento possui um identificador único (id), um identificador de paciente (pacienteId) que o relaciona com a entidade Paciente, um identificador de fisioterapeuta (fisioterapeutaId) que o relaciona com a entidade Fisioterapeuta, uma data e hora do agendamento (dataHora). 

Fisioterapeuta: Cada fisioterapeuta possui um identificador único (id), um nome (nome), informações de contato (contato) e um identificador de usuário (usuarioId). 

Essa modelagem organiza as informações necessárias para a aplicação de agendamento de fisioterapia, permitindo o gerenciamento de usuários, pacientes, fisioterapeutas e agendamentos, com relacionamentos que facilitam a integração dos dados entre as entidades.



![image](https://github.com/user-attachments/assets/fa29d60b-89e6-4af0-8b7d-f48b03fa238b)



## Projeto da Interface Web

A interface web da aplicação de Agendamento de Fisioterapia é intuitiva e visualmente clean, focada em oferecer uma experiência agradável para os clientes e para o fisioterapeuta Davi. A página inicial é dedicada aos clientes, com acesso fácil a informações sobre serviços e links para redes sociais. O layout responsivo, baseado no Bootstrap, garante compatibilidade com diversos dispositivos. Após o login, o fisioterapeuta Davi pode gerenciar pacientes e agendamentos. Transições suaves e feedback visual melhoram a interatividade, otimizando a comunicação e agendamentos.
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



### Design Visual

A interface da aplicação de Agendamento de Fisioterapia apresenta um estilo visual moderno e harmonioso. A tipografia utilizada é a fonte Roboto, uma sans-serif que garante legibilidade e um aspecto clean, contribuindo para uma experiência de usuário agradável.

A paleta de cores é composta por tons suaves, incluindo:

Branco (#fff), que proporciona um fundo limpo e espaçoso.
Azul (#386bc0), que é utilizado para elementos de destaque, como botões e links, transmitindo confiança e tranquilidade.
Cinza (#9aa2a8), que é aplicado em textos secundários, detalhes e botões secundários, oferecendo contraste sem poluição visual.
Além desses, outros tons são usados para criar uma combinação suave e coesa, garantindo uma estética agradável em toda a aplicação.

A interface também incorpora uma foto do Davi, o fisioterapeuta, para personalizar e humanizar a experiência do usuário. Ícones de redes sociais são utilizados para facilitar o acesso às plataformas como Instagram e Facebook, reforçando a conexão com os clientes. Esses elementos gráficos são cuidadosamente escolhidos para manter a identidade visual da aplicação e promover uma navegação intuitiva.



### Layout Responsivo

Para garantir que a interface do nosso projeto de Agendamento de Fisioterapia seja acessível em diversos dispositivos, utilizaremos:

Bootstrap: A biblioteca foi importada para facilitar a criação de um layout responsivo com componentes flexíveis, como Container, Row e Col, permitindo que os elementos se ajustem automaticamente a diferentes tamanhos de tela.

Classes de Visibilidade: Usaremos classes do Bootstrap para mostrar ou ocultar elementos conforme necessário, garantindo uma interface otimizada para dispositivos variados.

Navegação Adaptável: O componente Navbar do Bootstrap garantirá que a navegação seja intuitiva em todos os dispositivos.

### Interações do Usuário

A interface da aplicação de Agendamento de Fisioterapia foi projetada para ser intuitiva e livre de poluição visual, garantindo uma experiência fluida para os usuários. As principais interações incluem:

Página Inicial para Clientes: A home page é exclusiva para os clientes do fisioterapeuta, permitindo fácil acesso a informações relevantes e links diretos para redes sociais, como Instagram e Facebook, além de um botão para enviar mensagens via WhatsApp. Isso facilita a comunicação e interação com o fisioterapeuta.

Menu de Navegação: O menu de login permite que os usuários façam login ou se registrem facilmente. Após o login, o fisioterapeuta tem acesso a uma área dedicada onde pode gerenciar pacientes e agendamentos, além de visualizar um dashboard que fornece dados sobre a quantidade de agendamentos na semana.

Feedback Visual: Os elementos interativos, como botões de navegação e links, fornecerão feedback visual ao serem clicados, garantindo que os usuários saibam que suas ações foram reconhecidas.

Gerenciamento de Agendamentos: O fisioterapeuta poderá acessar facilmente a funcionalidade de gerenciamento de agendamentos e pacientes, permitindo uma gestão eficiente e intuitiva de suas atividades.

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
