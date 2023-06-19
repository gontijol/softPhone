# Projeto de Softphone em Flutter

Este é um projeto de um Softphone desenvolvido em Flutter, projetado para rodar em dispositivos Android. O Softphone utiliza o protocolo SIP com WebSocket, implementado por meio de uma interface que converte UDP para WebSocket em JavaScript.

## Funcionalidades

- Realizar e receber chamadas telefônicas através do servidor Issabel.
- Interface de usuário intuitiva e fácil de usar.
- Suporte a protocolo SIP com WebSocket para comunicação eficiente.

## Requisitos

- Flutter SDK (vX.X.X): [link para download](https://flutter.dev)
- Dispositivo Android ou emulador para testar o aplicativo.

## Instalação

1. Clone este repositório em sua máquina local:

``git clone https://github.com/seu-usuario/seu-projeto.git``

2. Navegue até o diretório do projeto:

``cd seu-projeto``

3. Execute o seguinte comando para instalar as dependências do Flutter:

``flutter pub get``

4. Instale e configure o servidor Issabel para se comunicar com o Softphone.

5. Faça o download do projeto WebSocketUDP disponível em https://github.com/gontijol/websocketUDP.

6. Siga as instruções fornecidas no repositório do projeto WebSocketUDP para configurar e executar a interface que converte UDP para WebSocket em JavaScript.

7. Certifique-se de ter as informações de configuração corretas para o servidor Issabel e a interface WebSocketUDP.

8. No código-fonte do projeto, localize o arquivo lib/config.dart e atualize as informações de configuração de acordo com seu ambiente:

```const String issabelServer = 'endereço_do_servidor_issabel';
const String sipUsername = 'nome_de_usuário_sip';
const String sipPassword = 'senha_sip';
const String websocketUDPUrl = 'url_da_interface_websocketUDP';
```

9. Conecte seu dispositivo Android ou inicie um emulador.

10. Execute o aplicativo Flutter:

``flutter run``

## Notas importantes
- Este projeto ainda está incompleto e requer alguns ajustes para estar totalmente funcional.
- Certifique-se de ter uma conexão estável com a internet ao executar o aplicativo.
- Se encontrar algum problema ou tiver alguma dúvida, sinta-se à vontade para entrar em contato com a equipe de desenvolvimento.

## Contribuição

Contribuições são bem-vindas! Se você quiser melhorar este projeto, siga as etapas abaixo:

1. Fork este repositório.

2. Crie uma nova branch com a sua contribuição:

```git checkout -b minha-contribuicao```

