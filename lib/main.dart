import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'widgets/authentication.dart';
import 'package:get/get.dart';
import 'controllers/home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Authentication(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      onInit: () {
        Get.put(AuthController());
        Get.put(HomeController());
      },
    );
  }
}
