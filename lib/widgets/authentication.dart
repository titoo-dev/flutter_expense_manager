import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class Authentication extends GetView<AuthController> {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.handleUnfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Text("Bienvenue chez Expense Manager",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Theme.of(context).primaryColor)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Column(
                      children: [
                        TextFormField(
                            focusNode: controller.nicknameFocusNode,
                            controller: controller.nicknameController,
                            onChanged: controller.validateForm,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Pseudo",
                                labelText: "Pseudo",
                                prefixIcon:
                                    Icon(Icons.alternate_email_outlined))),
                        const SizedBox(
                          height: 14,
                        ),
                        GetX<AuthController>(builder: (state) {
                          return TextFormField(
                              focusNode: controller.passwordFocusNode,
                              controller: controller.passwordController,
                              onChanged: controller.validateForm,
                              obscureText: !state.isPasswordVisible.value,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  suffixIcon: GestureDetector(
                                      onTap: state.togglePasswordVisibility,
                                      child: state.isPasswordVisible.value
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  hintText: "Mot de passe",
                                  labelText: "Mot de passe",
                                  prefixIcon: const Icon(Icons.lock)));
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        GetX<AuthController>(builder: (state) {
                          return MaterialButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: state.isFormValide.value
                                ? state.submitForm
                                : null,
                            child: Text("S'authentifier".toUpperCase()),
                          );
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
