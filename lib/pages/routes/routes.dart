import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smartphone/pages/call_screen/page.dart';
import 'package:smartphone/pages/home/binding.dart';
import 'package:smartphone/pages/home/page.dart';
import 'package:smartphone/pages/register/binding.dart';
import 'package:smartphone/pages/register/page.dart';

class AppRoutes {
  static const String PHONE_PAGE = '/phone';
  static const String REGISTER_PAGE = '/register';

  static final pages = [
    GetPage(
      name: PHONE_PAGE,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: REGISTER_PAGE,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: REGISTER_PAGE,
      page: () => CallView(),
      binding: RegisterBinding(),
    ),
  ];
}
