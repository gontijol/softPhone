import 'package:get/get.dart';
import 'package:smartphone/pages/dialpad/controller.dart';

class DialPadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DialPadController>(() => DialPadController());
  }
}
