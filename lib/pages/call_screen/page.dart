import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:smartphone/pages/call_screen/controller.dart';

class CallView extends GetView<CallController> {
  const CallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                '[${controller.direction}] ${EnumHelper.getName(controller.state)}')),
        body: Container(
          child: controller.buildContent(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 24.0),
            child: SizedBox(
              width: 320,
              child: controller.buildActionButtons(),
            )));
  }
}
