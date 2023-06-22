
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// // ignore: must_be_immutable
// class PasswordFormField extends GetWidget<SignUpController> {
//   final passwordVisible = false.obs;
//   final Function(String s)? onChanged;
//   final Function(String s)? onSaved;
//   final Function(String s)? onSubmit;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;

//   final TextEditingController passController;
//   String? label = '';
//   final FocusNode? focusNode;

//   @override
//   PasswordFormField({
//     this.focusNode,
//     this.textInputAction,
//     this.keyboardType,
//     this.onSaved,
//     this.onSubmit,
//     this.onChanged,
//     required this.passController,
//     required this.label,
//     super.key,
//     Color? fillColor,
//     required OutlineInputBorder enabledBorder,
//     required OutlineInputBorder focusedBorder,
//     required String labelText,
//     required TextStyle labelStyle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => TextFormField(
//           focusNode: focusNode,

//           controller: passController,
//           onChanged: onChanged,
//           onFieldSubmitted: (value) => onSubmit!(value),
//           // onSaved:(value) => onSaved!(value),
//           inputFormatters: [
//             Masks.maskPass,
//           ],
//           cursorColor: defaultBlack,
//           obscureText: !passwordVisible.value,
//           decoration: InputDecoration(
//             errorText: controller.passwordError.value.isNotEmpty
//                 ? controller.passwordError.value
//                 : null,
//             errorStyle: const TextStyle(color: defaultError),
//             suffixIcon: IconButton(
//               color: defaultBlack,
//               icon: Icon(
//                 passwordVisible.value
//                     ? Icons.visibility_outlined
//                     : Icons.visibility_off_outlined,
//               ),
//               onPressed: () => passwordVisible.value = !passwordVisible.value,
//             ),
//             filled: true,
//             fillColor: Colors.grey[300],
//             enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: defaultBlack),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: defaultBlack),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             labelText: label,
//             labelStyle: const TextStyle(color: Colors.black),
//           ),
//         ));
//   }
// }
