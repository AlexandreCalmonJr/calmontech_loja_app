# CalmonTech Loja App

**CalmonTech_Loja_App** é uma aplicação móvel desenvolvida em Flutter que oferece serviços de TI sob demanda, incluindo desenvolvimento de aplicativos, suporte técnico e reparos de dispositivos. O objetivo do app é facilitar o acesso dos clientes aos serviços da CalmonTech com uma interface intuitiva e prática.

## Funcionalidades

- **Navegação intuitiva:** Uma interface simples e fácil de usar, permitindo que os clientes naveguem pelos serviços com facilidade.
- **Lista de Serviços:** Apresenta todos os serviços oferecidos, como:
  - Criação de aplicativos móveis e web.
  - Reparos de computadores e notebooks.
  - Manutenção de smartphones Android.
  - Consultoria e suporte técnico.
- **Sistema de Agendamento:** O cliente pode solicitar um serviço, escolher uma data e hora para atendimento e enviar uma mensagem de descrição do problema.
- **Gerenciamento de Perfis:** O cliente pode criar um perfil com informações de contato, histórico de serviços e preferências.
- **Notificações Push:** Envia notificações sobre status de pedidos, atualizações e promoções.
- **Suporte a Pagamentos:** Integração com métodos de pagamento populares para facilitar a contratação de serviços.
  
## Tecnologias Utilizadas

- **Flutter:** Framework de UI para criar o aplicativo.
- **Firebase:** Autenticação, Firestore para armazenamento de dados e Firebase Storage para imagens.
- **GetX:** Gerenciamento de estado e navegação.
- **Dart:** Linguagem de programação usada no Flutter.

## Requisitos

- Flutter SDK 2.0 ou superior.
- Conta no Firebase configurada com Firestore, Firebase Authentication e Storage.

## Estrutura do Projeto
- lib/: Contém o código principal da aplicação.
- lib/screens/: Telas da aplicação, como Home, Detalhes de Serviço, Perfil, etc.
- lib/controllers/: Controladores usando GetX para o gerenciamento de estado.
- lib/models/: Modelos de dados, como UserModel e ServiceModel.
- lib/services/: Serviços que integram o app com Firebase e outras APIs.
