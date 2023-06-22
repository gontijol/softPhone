// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartphone/core/colors.dart';

class CustomButton extends Container {
  final name;
  final nameRoute;
  final containerColor;
  final backGroundContainerColor;
  final wSize;
  final hSize;
  final textColor;
  // final Function(String s)? onTap;

  CustomButton({
    Key? key,
    this.wSize = 130.0,
    this.hSize = 30.0,
    this.textColor = defaultCyan,
    this.backGroundContainerColor = Colors.transparent,
    this.containerColor = defaultCyan,
    this.nameRoute,
    this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("$nameRoute"),
      child: Container(
        decoration: BoxDecoration(
            color: backGroundContainerColor,
            border: Border(
              bottom: BorderSide(
                color: containerColor,
                width: 2,
              ),
              left: BorderSide(
                color: containerColor,
                width: 2,
              ),
              right: BorderSide(
                color: containerColor,
                width: 2,
              ),
              top: BorderSide(
                color: containerColor,
                width: 2,
              ),
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        height: hSize,
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.only(
          left: 20,
        ),
        child: Center(
            child: Text(
          '$name',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        )),
      ),
    );
  }
}
