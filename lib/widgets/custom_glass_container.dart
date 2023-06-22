import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:smartphone/core/colors.dart';

class CustomGlassContainer extends StatelessWidget {
  const CustomGlassContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassmorphicContainer(
        width: MediaQuery.of(context).size.width * 0.9,
        height: Get.height * 0.17,
        borderRadius: 15,
        blur: 7,
        alignment: Alignment.bottomCenter,
        border: 0,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            defaultCyan.withAlpha(99),
            defaultCyan.withAlpha(45),
          ],
          stops: const [0.3, 1],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            const Color(0xFF4579C5).withAlpha(100),
            const Color(0x0fffffff).withAlpha(55),
            const Color(0xFFF75035).withAlpha(10),
          ],
          stops: const [0.06, 0.95, 1],
        ),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Boxicons.bx_barcode_reader,
                            size: 50,
                            color: defaultBlack,
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Boleto Disponível',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: defaultBlack,
                                ),
                              ),
                              Text(
                                'Boleto Disponível',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: defaultBlack,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'R\$ 439,22',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: defaultBlack,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox.shrink(),
                          // CustomButton(
                          //   name: 'Visualizar',
                          //   nameRoute: '/signup',
                          //   containerColor: defaultBlue,
                          //   textColor: defaultBlue,
                          // ),
                          // const SizedBox(width: 8),
                          // const Icon(
                          //   Boxicons.bx_copy_alt,
                          //   size: 30,
                          //   color: defaultBlack,
                          // ),
                          // const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: defaultWhite,
                            shadows: [
                              BoxShadow(
                                color: defaultCyan,
                                blurRadius: 2,
                                offset: Offset(2, 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
