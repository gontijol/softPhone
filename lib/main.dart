import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartphone/pages/register/binding.dart';
import 'package:smartphone/pages/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // BackgroundService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App ISSABEL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/register',
      getPages: AppRoutes.pages,
      initialBinding: RegisterBinding(),
    );
  }
}
