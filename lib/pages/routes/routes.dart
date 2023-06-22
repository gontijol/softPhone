import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smartphone/pages/call_screen/page.dart';
import 'package:smartphone/pages/dialpad/binding.dart';
import 'package:smartphone/pages/dialpad/page.dart';
import 'package:smartphone/pages/register/binding.dart';
import 'package:smartphone/pages/register/page.dart';

class AppRoutes {
  static const String PHONE_PAGE = '/phone';
  static const String REGISTER_PAGE = '/register';
  static const String CALL_PAGE = '/call_screen';

  static final pages = [
    GetPage(
      name: PHONE_PAGE,
      page: () => const DialPadView(),
      binding: DialPadBinding(),
    ),
    GetPage(
      name: REGISTER_PAGE,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: CALL_PAGE,
      page: () => const CallView(),
      binding: RegisterBinding(),
    ),
  ];
}
