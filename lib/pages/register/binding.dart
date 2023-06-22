import 'package:get/get.dart';
import 'package:smartphone/pages/dialpad/controller.dart';
import 'package:smartphone/pages/register/controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DialPadController());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
