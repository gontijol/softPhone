// ignore_for_file: avoid_print

import 'dart:async';
// import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:smartphone/pages/call_screen/controller.dart';

class DialPadController extends GetxController implements SipUaHelperListener {
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

  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  MediaStream? localStream;
  MediaStream? remoteStream;
  EdgeInsetsGeometry? localVideoMargin;
  late Timer timer;
  final localVideoHeight = 0.0.obs;
  final localVideoWidth = 0.0.obs;
  final showNumPad = false.obs;
  final timeLabel = '00:00'.obs;
  final audioMuted = false.obs;
  final videoMuted = false.obs;
  final speakerOn = false.obs;
  final hold = false.obs;
  final hasListener = false.obs;
  final holdOriginator = ''.obs;
  final state = CallStateEnum.NONE.obs;

  RTCSessionDescription? localSdp;

  late Call call;
  Call? get currentCall => call;

  bool get voiceOnly =>
      (localStream == null || localStream!.getVideoTracks().isEmpty) &&
      (remoteStream == null || remoteStream!.getVideoTracks().isEmpty);

  String? get remoteIdentify => call.remote_identity;

  // RTCSessionDescription? get remoteSdp =>

  String? get direction => currentCall!.direction;

  CallState? callState;

  String? get currentCallId => currentCall!.id;

  CallStateEnum? get callStateValue => currentCall!.state;

  final mediaConstraints = <String, dynamic>{'audio': true, 'video': true};
  StreamSubscription? _timerSubscription;
  late final SIPUAHelper? sipHelper = SIPUAHelper(); // Inicializar SIPUAHelper

  @override
  void onInit() async {
    // session
    // call = Get.find<Call>();
    Get.lazyPut(() => CallController());

    sipHelper!.addSipUaHelperListener(this);
    // print('listener${sipHelper.hasListeners.call}'); // Adicionar listener
    super.onInit();
    // callStateChanged(call, CallStateEnum.NONE);
    // print(callStateValue);
  }

  void setPressedNumber(String number) {
    pressedNumber.value = number;
  }

  listener() async {
    sipHelper!.findCall(currentCall!.id!); // Adicionar listener
    sipHelper!.addSipUaHelperListener(this); // Adicionar listener
  }

  initCall() async {
    initRenderers();
  }

  void handleHold() {
    if (hold.value) {
      currentCall?.unhold();
    } else {
      currentCall?.hold();
    }
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

    // return null;

    if (isCallActive.value == false) {
      // callStateChanged(
      //   Call(destino, call.session, CallStateEnum.CALL_INITIATION),
      //   CallState(callStateValue!),
      // );
      isCallActive.value = true;
      callDuration.value = const Duration(seconds: 0);
      startCallTimer();
      await sipHelper!.call(destino,
          voiceonly: voiceOnly,
          mediaStream: mediaStream); // Enviar a chamada SIP
      sipHelper!.register();
      print('state changed');
      callStateChanged(
        currentCall!,
        callState!,
      );

      print('debugzoado $callStateValue');
      print('state changed done');

      print('Chamada iniciada');
      // print('Chamada iniciada: ${call.id}');
      // print('Chamada estado: ${call.state}');
      // print('Chamada session: ${call.session}');
      // currentCallId;
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

  endCall() {
    // sipHelper.on(, (event) {});
    //TODO: IMPLEMENTAR O END CALL

    // print(sipHelper.findCall(currentCallId!.toString()));
    // sipHelper.findCall(currentCallId!)?.hangup();
  }

  void endCallTimer() async {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    isCallActive.value = false;

    Future.delayed(const Duration(seconds: 2), () {
      timerText.value = '';
      callDuration.value = const Duration(seconds: 0);
    });
    await endCall();
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
  void initRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
    // startCallTimer();
  }

  void disposeRenderers() async {
    await localRenderer.dispose();
    await remoteRenderer.dispose();
    endCallTimer();
  }

  void handelStreams(CallState event) async {
    MediaStream? stream = event.stream;
    if (event.originator == 'local') {
      localRenderer.srcObject = stream;
      if (!kIsWeb && !WebRTC.platformIsDesktop) {
        event.stream?.getAudioTracks().first.enableSpeakerphone(false);
      }
      localStream = stream;
    }
    if (event.originator == 'remote') {
      remoteRenderer.srcObject = stream;
      remoteStream = stream;
    }

    resizeLocalVideo();
  }

  void resizeLocalVideo() {
    localVideoMargin = remoteStream != null
        ? const EdgeInsets.only(top: 15, right: 15)
        : const EdgeInsets.all(0);
    localVideoWidth.value = remoteStream != null ? Get.width / 4 : Get.width;
    localVideoHeight.value = remoteStream != null ? Get.width / 4 : Get.width;
  }

  @override
  void callStateChanged(Call call, CallState callState) {
    if (callState.state == CallStateEnum.HOLD || //
        callState.state == CallStateEnum.UNHOLD) {
      hold.value = callState.state == CallStateEnum.HOLD;
      holdOriginator.value = callState.originator!;
      return;
    }
    if (callState.state == CallStateEnum.MUTED) {
      return;
    }
    if (callState.state == CallStateEnum.ENDED) {
      return;
    }
    if (callState.state == CallStateEnum.UNMUTED) {
      return;
    }
    if (callState.state == CallStateEnum.STREAM) {
      state.value = callState.state;
      return;
    }

    switch (callState.state) {
      case CallStateEnum.STREAM:
        break;
      case CallStateEnum.ENDED:
        // disposeRenderers();
        break;
      case CallStateEnum.FAILED:
        Get.back();
        break;
      case CallStateEnum.UNMUTED:
      case CallStateEnum.MUTED:
      case CallStateEnum.CONNECTING:
      case CallStateEnum.PROGRESS:
      case CallStateEnum.ACCEPTED:
      case CallStateEnum.CONFIRMED:
      case CallStateEnum.HOLD:
      case CallStateEnum.UNHOLD:
      case CallStateEnum.NONE:
      case CallStateEnum.CALL_INITIATION:
        initCall();
        // Get.toNamed('/call_screen');
        break;
      case CallStateEnum.REFER:
        break;
    }
  }

  @override
  void dispose() {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    // _peerConnection?.dispose();
    disposeRenderers();
    super.dispose();
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // TODO: implement onNewMessage
  }

  @override
  void onNewNotify(Notify ntf) {
    print(ntf.request);
  }

  // Exemplo de uso do EventCallState
// on(Function() EventCallState, (EventCallState event) {
//   // Lógica para lidar com o evento EventCallState
// });
}

class Contact {
  final String name;
  final String phoneNumber;
  Function? onPressed;

  Contact({required this.name, required this.phoneNumber, this.onPressed});
}

// class EventCallState implements EventType {
//   // Aqui você pode adicionar propriedades e métodos específicos do evento EventCallState
// }
