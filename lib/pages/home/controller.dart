import 'dart:async';
// import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';

class HomeController extends GetxController implements SipUaHelperListener {
  final incomingCallStream = ''.obs;

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
  final UaSettings settings = UaSettings();
  late SIPUAHelper sipHelper; // Adicionado
  final mediaConstraints = <String, dynamic>{'audio': true, 'video': true};
  StreamSubscription? _timerSubscription;
  @override
  void onInit() async {
    sipHelper = SIPUAHelper(); // Inicializar SIPUAHelper
    super.onInit();
  }

  void setPressedNumber(String number) {
    pressedNumber.value = number;
  }

  void fazerChamada(String destino) async {
    bool voiceOnly = true;
    await Future.delayed(const Duration(seconds: 1));
    MediaStream? mediaStream;

    if (kIsWeb && voiceOnly) {
      mediaStream = await mediaDevices.getDisplayMedia(mediaConstraints);
      mediaConstraints['video'] = false;
      MediaStream userStream =
          await mediaDevices.getUserMedia(mediaConstraints);
      mediaStream.addTrack(userStream.getAudioTracks()[0], addToNative: true);
    } else {
      mediaConstraints['video'] = !voiceOnly;
      mediaStream = await mediaDevices.getUserMedia(mediaConstraints);
    }
    void answerCall() {
      // Verifica se há uma chamada recebida
      if (incomingCallStream.value.isNotEmpty) {
        print('Atendendo chamada: ${incomingCallStream.value}');

        // Restaurar o valor da stream para vazio após atender a chamada
        incomingCallStream.value = '';
      }
    }

    sipHelper.call(destino, voiceonly: voiceOnly, mediaStream: mediaStream);
    // return null;
    if (isCallActive.value == false) {
      isCallActive.value = true;
      callDuration.value = const Duration(seconds: 0);

      startCallTimer();
      // // Construir a URI SIP

      await sipHelper.call(destino); // Enviar a chamada SIP
      sipHelper.register();
    } else {
      endCallTimer();
    }
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    print('Registration state changed: ${state.toString()}');
    // setState(() {});
  }

  @override
  void transportStateChanged(TransportState state) {
    print('TransportState state changed: ${state.toString()}');
  }

  @override
  void callStateChanged(Call call, CallState callState) {
    if (callState.state == CallStateEnum.CALL_INITIATION) {
      Get.toNamed('/call-screen');
    }
    if (callState.state == CallStateEnum.CONNECTING) {
      // Get.toNamed('/call-screen');
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
    // _peerConnection?.dispose();
    super.dispose();
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // TODO: implement onNewMessage
  }

  @override
  void onNewNotify(Notify ntf) {
    // TODO: implement onNewNotify
  }
}

class Contact {
  final String name;
  final String phoneNumber;
  Function? onPressed;

  Contact({required this.name, required this.phoneNumber, this.onPressed});
}
