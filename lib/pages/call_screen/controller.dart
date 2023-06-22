import 'dart:async';

import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';

class CallController extends GetxController {
  // String? get remoteIdentity => call!.remote_identity;

  // String get direction => call!.direction;

  // Call? get call => widget._call;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  initCall() async {
    // startTimer();
  }

  // void startTimer() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
  //     Duration duration = Duration(seconds: timer.tick);

  //     timeLabel.value = [duration.inMinutes, duration.inSeconds]
  //         .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
  //         .join(':');
  //   });
  //   // timer.cancel();
  // }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // TODO: implement onNewMessage
  }

  @override
  void onNewNotify(Notify ntf) {
    // TODO: implement onNewNotify
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    // TODO: implement registrationStateChanged
  }

  @override
  void transportStateChanged(TransportState state) {
    // TODO: implement transportStateChanged
  }
}
