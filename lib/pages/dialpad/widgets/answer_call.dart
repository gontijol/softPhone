import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartphone/pages/dialpad/controller.dart';

class AnswerCall extends DialPadController {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: const Text('Answer Call'),
      content: const Text('Do you want to answer the call?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
