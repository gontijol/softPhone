// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smartphone/core/colors.dart';
// import 'package:smartphone/pages/register/controller.dart';

// class RegisterView extends GetView<RegisterController> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   RegisterView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: Get.width,
//           height: Get.height,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 defaultCyan,
//                 defaultCyan,
//                 defaultBlue,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Obx(
//             () => Center(
//               child: controller.isRegistering.value == true
//                   ? const CircularProgressIndicator(
//                       color: defaultBlue,
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Bem-vindo!',
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             Obx(() {
//                               return TextFormField(
//                                 controller: controller.realm.value,
//                                 decoration: const InputDecoration(
//                                   labelText: 'Ramal',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                 ),
//                                 // validator: (value) {
//                                 //   if (value!.isEmpty) {
//                                 //     return 'Por favor, insira o ramal';
//                                 //   }
//                                 //   return null;
//                                 // },
//                               );
//                             }),
//                             const SizedBox(height: 16),
//                             Obx(() {
//                               return TextFormField(
//                                 controller: controller.userName.value,
//                                 decoration: const InputDecoration(
//                                   labelText: 'Login',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                 ),
//                                 // validator: (value) {
//                                 //   if (value!.isEmpty) {
//                                 //     return 'Por favor, insira o login';
//                                 //   }
//                                 //   return null;
//                                 // },
//                               );
//                             }),
//                             const SizedBox(height: 16),
//                             Obx(() {
//                               return TextFormField(
//                                 controller: controller.password.value,
//                                 decoration: const InputDecoration(
//                                   labelText: 'Senha',
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                 ),
//                                 obscureText: true,
//                                 // validator: (value) {
//                                 //   if (value!.isEmpty) {
//                                 //     return 'Por favor, insira a senha';
//                                 //   }
//                                 //   return null;
//                                 // },
//                               );
//                             }),
//                             const SizedBox(height: 24),
//                             ElevatedButton(
//                               style: ButtonStyle(
//                                 fixedSize: MaterialStateProperty.all(
//                                     const Size(200, 48)),
//                                 foregroundColor:
//                                     MaterialStateProperty.all(defaultWhite),
//                                 backgroundColor:
//                                     MaterialStateProperty.all(defaultBlue),
//                               ),
//                               onPressed: () async {
//                                 if (_formKey.currentState!.validate()) {
//                                   await controller.registrar();
//                                 }
//                               },
//                               child: const Text('Cadastrar'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartphone/core/colors.dart';
import 'package:smartphone/core/masks.dart';
import 'package:smartphone/pages/register/controller.dart';
import 'package:smartphone/widgets/custom_button.dart';

class RegisterView extends GetView<RegisterController> {
  final _passwordVisible = false.obs;

  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: defaultBlack,
            ),
            Opacity(
              opacity: 0.2,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.all(20.0),
                    width: Get.width * 0.8,
                    height: Get.height * 0.6,
                    decoration: const BoxDecoration(
                      color: defaultWhite,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: controller.isRegistering.value == false
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Get.width * 0.50,
                                child: Image.asset(
                                    'assets/images/logo-antiga.png'),
                              ),
                              const SizedBox(height: 40),
                              Obx(
                                () => TextFormField(
                                  controller: controller.realm.value,
                                  // onChanged: (value) {
                                  //   controller.emailError.value = '';
                                  // },
                                  cursorColor: defaultBlack,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    // errorText: controller.emailError.value.isNotEmpty
                                    //     ? controller.emailError.value
                                    //     : null,
                                    errorStyle:
                                        const TextStyle(color: defaultError),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: defaultBlack),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: defaultBlack),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Ramal',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    // focusedErrorBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     color: controller.emailError.value.isEmpty
                                    //         ? defaultBlack
                                    //         : defaultError,
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    // errorBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     color: controller.emailError.value.isEmpty
                                    //         ? defaultBlack
                                    //         : defaultError,
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => TextFormField(
                                  controller: controller.userName.value,
                                  // onChanged: (value) {
                                  //   controller.emailError.value = '';
                                  // },
                                  cursorColor: defaultBlack,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    // errorText: controller.emailError.value.isNotEmpty
                                    //     ? controller.emailError.value
                                    //     : null,
                                    errorStyle:
                                        const TextStyle(color: defaultError),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: defaultBlack),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: defaultBlack),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Usuário',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    // focusedErrorBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     color: controller.emailError.value.isEmpty
                                    //         ? defaultBlack
                                    //         : defaultError,
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    // errorBorder: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //     color: controller.emailError.value.isEmpty
                                    //         ? defaultBlack
                                    //         : defaultError,
                                    //   ),
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => TextFormField(
                                  inputFormatters: [Masks.maskPass],
                                  controller: controller.password.value,
                                  cursorColor: defaultBlack,
                                  obscureText: !_passwordVisible.value,
                                  onChanged: (value) {
                                    // controller.passwordError.value = '';
                                  },
                                  decoration: InputDecoration(
                                    // errorStyle: TextStyle(
                                    //     color: controller.passwordError.value.isNotEmpty
                                    //         ? defaultError
                                    //         : defaultBlack),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    suffixIcon: IconButton(
                                      color: defaultBlack,
                                      icon: Icon(
                                        _passwordVisible.value
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                      ),
                                      onPressed: () => _passwordVisible.value =
                                          !_passwordVisible.value,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: defaultBlack),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: defaultBlack),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // errorText: controller.passwordError.value.isNotEmpty
                                    //     ? controller.passwordError.value
                                    //     : null,
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // color: controller.passwordError.value.isEmpty
                                          //     ? defaultBlack
                                          //     : defaultError,
                                          ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // color: controller.passwordError.value.isEmpty
                                          //     ? defaultBlack
                                          //     : defaultError,
                                          ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Password',
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomGradientButton(
                                onPressed: () async {
                                  await controller.registrar();
                                },
                                text: 'Entrar',
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    Size(Get.width * 0.7, 50),
                                  ),
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                    const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                            color: defaultCyan,
                          )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
