import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_manager/widgets/home.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool isFormValide = false.obs;

  final FocusNode nicknameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void validateForm(String value) {
    if (nicknameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      isFormValide.value = true;
    } else {
      isFormValide.value = false;
    }
  }

  void submitForm() {
    showLoading();

    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
      Get.to(const Home(), transition: Transition.cupertino);
    });
  }

  void showLoading() {
    Get.dialog(AlertDialog(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: 14,
          ),
          Text("Chargement...")
        ],
      ),
    ));
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void handleUnfocus() {
    nicknameFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }
}
