import 'package:get/get.dart';
import 'package:smartphone/pages/home/controller.dart';
import 'package:smartphone/pages/register/controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
