import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:smartphone/core/colors.dart';
import 'package:smartphone/pages/dialpad/controller.dart';

class RegisterController extends GetxController implements SipUaHelperListener {
  final ipConnect = '192.168.1.150'.obs;
  final userName = TextEditingController().obs;
  final password = TextEditingController().obs;
  final realm = TextEditingController().obs;
  final isRegistrationSuccessful = false.obs;
  final phoneController = Get.find<DialPadController>();
  final stateConnection = RegistrationStateEnum.UNREGISTERED.obs;
  final isRegistering = false.obs;
  final hold = false.obs;
  final state = CallStateEnum.NONE.obs;

  // RTCSessionDescription offer = RTCSessionDescription('', '');
  final holdOriginator = ''.obs;
  @override
  void onInit() async {
    password.value.text = 'F0rget96';
    userName.value.text = '1001';
    realm.value.text = '1001';
    super.onInit();
  }

  startingRegister() async {
    await phoneController.sipHelper?.start(phoneController.settings);
    isRegistering.value = true;

    // DELAYED NECESSÁRIO PARA ESPERAR O REGISTRO
    Future.delayed(const Duration(seconds: 3), () {
      registrationStateChanged(phoneController.sipHelper!.registerState);
      Future.delayed(
          const Duration(seconds: 1), () => isRegistering.value = false);
    });
  }

  registrar() async {
    phoneController.settings.webSocketUrl = 'ws://${ipConnect.value}:8089/ws';
    phoneController.settings.webSocketSettings = WebSocketSettings();
    phoneController.settings.uri = 'sip:${realm.value.text}@${ipConnect.value}';
    phoneController.settings.webSocketSettings.allowBadCertificate = true;
    phoneController.settings.register = true;
    phoneController.settings.authorizationUser = userName.value.text;
    phoneController.settings.password = password.value.text;
    phoneController.settings.displayName = userName.value.text;

    try {
      await startingRegister();
    } catch (e) {
      Get.snackbar(
        'Erro',
        e.toString(),
        backgroundColor: defaultError,
      );
    }
  }

  @override
  void callStateChanged(Call call, CallState callState) {
    // TODO: implement callStateChanged
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // TODO: implement onNewMessage
  }

  @override
  void onNewNotify(Notify ntf) {
    print('onNewNotify ${ntf.request.toString()}');
    // ntf.request.toString();
  }

  @override
  void registrationStateChanged(RegistrationState register) {
    stateConnection.value = register.state!;

    if (stateConnection.value == RegistrationStateEnum.REGISTERED) {
      Get.toNamed('/phone');
    } else if (register.state == RegistrationStateEnum.REGISTRATION_FAILED) {
      Get.snackbar(
        'Erro',
        'Falha ao registrar',
        backgroundColor: defaultError,
      );
    } else if (stateConnection.value == RegistrationStateEnum.UNREGISTERED) {
      Get.snackbar(
        'Erro',
        'Falha ao registrar',
        backgroundColor: defaultError,
      );
    } else if (stateConnection.value == RegistrationStateEnum.NONE) {
      Get.snackbar(
        'Erro',
        'Verifique os dados e tente novamente',
        backgroundColor: defaultError,
      );
    }
  }

  @override
  void transportStateChanged(TransportState state) {
    // TODO: implement transportStateChanged
  }
}

@override
void transportStateChanged(TransportState state) {
  // TODO: implement transportStateChanged
}
