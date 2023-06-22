import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartphone/core/colors.dart';
import 'package:smartphone/pages/register/controller.dart';

class RegisterView extends GetView<RegisterController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                defaultCyan,
                defaultCyan,
                defaultBlue,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: Obx(
            () => Center(
              child: controller.isRegistering.value == true
                  ? const CircularProgressIndicator(
                      color: defaultBlue,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Bem-vindo!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Obx(() {
                              return TextFormField(
                                controller: controller.realm.value,
                                decoration: const InputDecoration(
                                  labelText: 'Ramal',
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Por favor, insira o ramal';
                                //   }
                                //   return null;
                                // },
                              );
                            }),
                            const SizedBox(height: 16),
                            Obx(() {
                              return TextFormField(
                                controller: controller.userName.value,
                                decoration: const InputDecoration(
                                  labelText: 'Login',
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Por favor, insira o login';
                                //   }
                                //   return null;
                                // },
                              );
                            }),
                            const SizedBox(height: 16),
                            Obx(() {
                              return TextFormField(
                                controller: controller.password.value,
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                obscureText: true,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Por favor, insira a senha';
                                //   }
                                //   return null;
                                // },
                              );
                            }),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    const Size(200, 48)),
                                foregroundColor:
                                    MaterialStateProperty.all(defaultWhite),
                                backgroundColor:
                                    MaterialStateProperty.all(defaultBlue),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.registrar();
                                }
                              },
                              child: const Text('Cadastrar'),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
