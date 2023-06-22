import 'package:flutter/material.dart';
import 'package:smartphone/core/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? error;

  final Function(String s)? onChanged;

  //  error.isNotEmpty
  //                                           ? error
  //                                           : null,

  const CustomTextFormField({
    Key? key,
    this.onChanged,
    this.error,
    required this.labelText,
    this.keyboardType,
    this.textInputAction,
    required this.controller,
    this.focusNode,
    required OutlineInputBorder focusedBorder,
    required OutlineInputBorder enabledBorder,
    Color? fillColor,
    String? errorText,
    required OutlineInputBorder focusedErrorBorder,
    required OutlineInputBorder errorBorder,
    required TextStyle labelStyle,
    required Color cursorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textInputAction: textInputAction,
      cursorColor: defaultBlack,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: defaultError),
        errorText: error != '' ? error : null,
        filled: true,
        fillColor: Colors.grey[300],
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: defaultBlack),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: defaultBlack),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
