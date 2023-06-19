import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';

class HomeController extends GetxController {
  final numeroController = ''.obs;
  final pressedNumber = ''.obs;
  final minFontSize = 14.0.obs;
  final maxFontSize = 48.0.obs;
  final isButtonPressed = false.obs;
  final isCallActive = false.obs;
  final scale = 0.0.obs;
  final currentTextLength = 0.obs;
  final callDuration = const Duration(seconds: 0).obs;
  final timerText = ''.obs;
  final minutes = ''.obs;
  final seconds = ''.obs;
  final ipConnect = '192.168.1.13'.obs;
  final UaSettings settings = UaSettings();
  final port = '5060';
  RTCPeerConnection? _peerConnection;
  late SIPUAHelper _sipHelper; // Adicionado

  final rtcOfferConstraints = <String, dynamic>{
    'offerToReceiveAudio': true,
    'offerToReceiveVideo': false,
  };

  StreamSubscription? _timerSubscription;

  @override
  void onInit() async {
    _sipHelper = SIPUAHelper(); // Inicializar SIPUAHelper
    // final websocketUrl = 'ws://${ipConnect.value}:5060';
    // final channel = IOWebSocketChannel.connect(websocketUrl);
    // channel.stream.handleError((error) {
    //   print('Erro no WebSocket: $error');
    // });
    // channel.stream.listen((message) {
    //   print('Mensagem recebida: $message');
    //   channel.sink.add('received!');
    //   // Processar a mensagem recebida do WebSocket
    //   // ... (faça o que for necessário com a mensagem)
    // });

    await registrar();
    super.onInit();
  }

  registrar() async {
    // Construir as credenciais
    final credentials = {
      'uri': 'sip:1000@${ipConnect.value}:5060',
      'username': '1000',
      'password': 'F0rget96',
      'realm': '${ipConnect.value}:$port',
      'wss': 'ws://${ipConnect.value}:8080/ws'
    };
    settings.webSocketUrl = 'ws://192.168.1.10:8080/ws';
    settings.uri = credentials['uri'];
    settings.webSocketSettings = WebSocketSettings();
    settings.webSocketSettings.allowBadCertificate = true;
    settings.webSocketSettings.userAgent = 'Dart/2.12 (dart:io)';
    settings.register = true;
    settings.authorizationUser = credentials['username'];
    settings.password = credentials['password'];
    settings.displayName = credentials['username'];
    settings.userAgent = 'Dart SIP Client v1.0.0';
    settings.dtmfMode = DtmfMode.RFC2833;
    settings.ha1 = null;
    settings.webSocketSettings.allowBadCertificate = true;

    await _sipHelper.start(settings);
    print(_sipHelper.toString());
    print(settings.toString());
  }

  // _initWebRTC() async {
  //   try {
  //     _peerConnection = await createPeerConnection({'iceServers': []}, {});
  //     print('WebRTC initialized successfully.');
  //   } catch (error) {
  //     print('Failed to initialize WebRTC: $error');
  //   }
  // }

  void setPressedNumber(String number) {
    pressedNumber.value = number;
  }

  void fazerChamada(String destino) async {
    await Future.delayed(const Duration(seconds: 1));

    if (isCallActive.value == false) {
      isCallActive.value = true;
      callDuration.value = const Duration(seconds: 0);

      startCallTimer();
      // // Construir a URI SIP
      final sipUri = 'sip:$destino@${ipConnect.value}:5060';
      await _sipHelper.call(sipUri); // Enviar a chamada SIP
      _sipHelper.register();

      // // Configurar as opções para o PeerConnection

      // // Criar a oferta de chamada
      final offer = await _peerConnection!.createOffer(rtcOfferConstraints);

      // // Definir a oferta local
      await _peerConnection!.setLocalDescription(offer);

      // Enviar a oferta SIP e as credenciais para o destino da chamada

      // Aguardar a resposta do destino (por exemplo, servidor SIP)
      // Aqui você precisa receber a resposta SIP e passá-la para o método setRemoteDescription
    } else {
      endCallTimer();
    }
  }

  void changeValueScale() {
    scale.value = (1 -
        ((currentTextLength.value > 0
                        ? currentTextLength.value.toDouble()
                        : 0) /
                    10)
                .clamp(0.0, 1.0) *
            0.5);
  }

  void setButtonPressedValue(bool value) {
    isButtonPressed.value = value;
  }

  void startCallTimer() {
    minutes.value =
        (callDuration.value.inSeconds ~/ 60).toString().padLeft(2, '0');
    seconds.value =
        (callDuration.value.inSeconds % 60).toString().padLeft(2, '0');
    timerText.value = '$minutes:$seconds';

    _timerSubscription?.cancel();
    _timerSubscription = Stream.periodic(const Duration(seconds: 1), (_) {
      callDuration.value += const Duration(seconds: 1);
      minutes.value =
          (callDuration.value.inSeconds ~/ 60).toString().padLeft(2, '0');
      seconds.value =
          (callDuration.value.inSeconds % 60).toString().padLeft(2, '0');
      timerText.value = '$minutes:$seconds';
    }).listen(null);
  }

  void endCallTimer() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    isCallActive.value = false;

    Future.delayed(const Duration(seconds: 2), () {
      timerText.value = '';
      callDuration.value = const Duration(seconds: 0);
    });
  }

  List<Contact> contacts = [
    Contact(name: 'João', phoneNumber: '1234567890'),
    Contact(name: 'Maria', phoneNumber: '9876543210'),
    Contact(name: 'Pedro', phoneNumber: '5555555555'),
    Contact(name: 'Pedro', phoneNumber: '5555555555'),
    Contact(name: 'Pedro', phoneNumber: '5555555555'),
    Contact(name: 'Pedro', phoneNumber: '5555555555'),
    Contact(name: 'Pedro', phoneNumber: '5555555555'),
    Contact(name: 'Pedro', phoneNumber: '5555555555'),
    Contact(name: 'Pedro', phoneNumber: '5555555555'),
  ];

  // Métodos de manipulação de eventos SIP

  @override
  void dispose() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    _peerConnection?.dispose();
    super.dispose();
  }
}

class Contact {
  final String name;
  final String phoneNumber;
  Function? onPressed;

  Contact({required this.name, required this.phoneNumber, this.onPressed});
}
