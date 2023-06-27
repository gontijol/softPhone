import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartphone/core/colors.dart';
import 'package:smartphone/pages/dialpad/controller.dart';

class DialPadView extends GetView<DialPadController> {
  const DialPadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DialPadController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Obx(
                            () => Visibility(
                              visible:
                                  controller.numeroController.value.isNotEmpty,
                              replacement: const SizedBox.shrink(),
                              child: Center(
                                child: Container(
                                  height: 75,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        defaultWhite.withOpacity(0.0),
                                        defaultWhite.withOpacity(0.0),
                                        defaultWhite.withOpacity(0.0),
                                        defaultWhite.withOpacity(0.1),
                                        defaultWhite.withOpacity(0.1),
                                        defaultWhite.withOpacity(0.4),
                                        defaultWhite.withOpacity(0.8),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(() {
                            final fontSize = Tween<double>(
                              begin: controller.maxFontSize.value,
                              end: controller.minFontSize.value,
                            ).transform(controller.scale.value);

                            return Container(
                              height: 75,
                              width: 500,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.0),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    defaultWhite.withOpacity(0.0),
                                    defaultWhite.withOpacity(0.0),
                                    defaultWhite.withOpacity(0.0),
                                    defaultWhite.withOpacity(0.1),
                                    defaultWhite.withOpacity(0.1),
                                    defaultWhite.withOpacity(0.2),
                                    defaultWhite.withOpacity(0.3),
                                  ],
                                ),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 36.0),
                                  Expanded(
                                    child: FittedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          controller.numeroController.value
                                                  .isEmpty
                                              ? '              NÚMERO              '
                                              : controller
                                                  .numeroController.value,
                                          style: TextStyle(
                                            fontSize: fontSize,
                                            color: controller.numeroController
                                                    .value.isEmpty
                                                ? defaultWhite.withOpacity(0.4)
                                                : defaultWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 36.0)
                                ],
                              ),
                            );
                          }),
                          Obx(() => Visibility(
                                visible: controller
                                    .numeroController.value.isNotEmpty,
                                child: IconButton(
                                  onPressed: () {
                                    if (controller
                                        .numeroController.value.isNotEmpty) {
                                      controller.numeroController.value =
                                          controller
                                              .numeroController.value
                                              .substring(
                                                  0,
                                                  controller.numeroController
                                                          .value.length -
                                                      1);
                                    }
                                  },
                                  icon: const Icon(Icons.backspace),
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _buildNumberRow(['1', '2', '3']),
                        const SizedBox(height: 20.0),
                        _buildNumberRow(['4', '5', '6']),
                        const SizedBox(height: 20.0),
                        _buildNumberRow(['7', '8', '9']),
                        const SizedBox(height: 20.0),
                        _buildNumberRow([
                          '.',
                          '0',
                          '',
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 60.0,
                        height: 30.0,
                        child: IconButton(
                          onPressed: () => {print('oi')},
                          icon: const Icon(Icons.keyboard),
                          color: defaultWhite,
                        ),
                      ),
                      Center(
                        child: Obx(() {
                          return InkWell(
                            onTap: () {
                              controller.isCallActive.value == false
                                  ? {
                                      controller.fazerChamada(
                                          controller.numeroController.value),
                                    }
                                  : {
                                      controller.stopCall(),

                                      // controller.disposeRenderers(),
                                    };
                            },
                            borderRadius: BorderRadius.circular(32.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20.0),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: controller.isCallActive.value
                                      ? defaultError.withOpacity(0.4)
                                      : defaultLime.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  !controller.isCallActive.value
                                      ? Icons.call
                                      : Icons.call_end,
                                  size: 32.0,
                                  color: defaultWhite,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      Obx(
                        () => SizedBox(
                          width: 60.0,
                          height: 30.0,
                          child: Text(
                            '${controller.timerText}',
                            style: TextStyle(
                              color: defaultWhite.withOpacity(0.4),
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Material(
      color: defaultBlack,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              defaultBlack,
              defaultCyan.withOpacity(0.01),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: numbers
            .map(
              (number) => _buildNumberButton(number),
            )
            .toList(),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    final controller = Get.put(DialPadController());

    if (number.isEmpty) {
      return Expanded(
        child: Container(
          // width: Get.width / 3,
          // height: Get.height / 6,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    color: Colors.transparent,
                    width: Get.width,
                    height: Get.height,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: Get.width / 1.2,
                          height: Get.height / 2.0,
                          decoration: BoxDecoration(
                            color: defaultBlack.withOpacity(0.22),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Row(
                            children: [
                              Column(children: [
                                Text(
                                  'Fulano chamando',
                                  style: TextStyle(
                                    color: defaultWhite,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  isDismissible: false,
                );

                // Get.bottomSheet(
                //   Opacity(
                //     opacity: 0.92,
                //     child: Container(
                //       width: Get.width,
                //       color: defaultCyan,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.stretch,
                //         children: [
                //           const Padding(
                //             padding: EdgeInsets.all(16.0),
                //             child: Text(
                //               'Lista de Contatos',
                //               style: TextStyle(
                //                 color: defaultBlack,
                //                 fontSize: 24.0,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //           Expanded(
                //             child: ListView.builder(
                //               itemCount: controller.contacts.length,
                //               itemBuilder: (context, index) {
                //                 final contact = controller.contacts[index];

                //                 return ListTile(
                //                   title: Text(
                //                     contact.name,
                //                     style: const TextStyle(
                //                       color: defaultBlack,
                //                       fontSize: 18.0,
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                   subtitle: Text(
                //                     contact.phoneNumber,
                //                     style: const TextStyle(
                //                       color: defaultBlack,
                //                       fontSize: 12.0,
                //                       fontWeight: FontWeight.w300,
                //                     ),
                //                   ),
                //                   isThreeLine: true,
                //                   trailing: IconButton(
                //                     onPressed: () {
                //                       // Ação a ser executada ao selecionar um contato
                //                       print(
                //                           'Contato selecionadosss: ${contact.name}');
                //                     },
                //                     icon: const Icon(Icons.call),
                //                     color: defaultBlack,
                //                   ),
                //                   onTap: () {
                //                     // Ação a ser executada ao selecionar um contato
                //                     print(
                //                         'Contato selecionado: ${contact.name}');
                //                   },
                //                 );
                //               },
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // );
              },
              iconSize: 40,
              icon: const Icon(Icons.contacts),
              color: defaultWhite.withOpacity(0.4)),
        ),
      );
    }

    return Expanded(
      child: Obx(
        () {
          final isPressed = controller.pressedNumber.value == number;

          return AnimatedOpacity(
            opacity: isPressed && controller.isButtonPressed.value ? 0.4 : 1.0,
            duration: const Duration(milliseconds: 1),
            child: InkWell(
              onTap: () {
                controller.numeroController.value += number;
                controller.setPressedNumber(number);
                controller.setButtonPressedValue(true);

                // Aguarde um tempo para voltar à opacidade normal
                Future.delayed(const Duration(milliseconds: 200), () {
                  controller.setButtonPressedValue(false);
                  controller.setPressedNumber('');
                });
              },
              borderRadius: BorderRadius.circular(32.0),
              child: Container(
                width: Get.width / 3,
                height: Get.height / 6,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
