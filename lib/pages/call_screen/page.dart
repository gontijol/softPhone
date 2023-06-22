import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartphone/core/colors.dart';
// import 'package:smartphone/pages/call_screen/controller.dart';

class CallView extends GetView {
  const CallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: defaultBlue,
        child: const Center(
          child: Text('CallView'),
        ),
      ),
    );
  }
}
