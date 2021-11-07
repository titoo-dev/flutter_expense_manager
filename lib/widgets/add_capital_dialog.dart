import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

class AddCapitalDialog extends GetView<HomeController> {
  const AddCapitalDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Ajouter Capital "),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        TextFormField(
          onChanged: controller.validateCapitalForm,
          keyboardType: TextInputType.number,
          controller: controller.capitalController,
          decoration: const InputDecoration(
            suffixText: "Ar",
            labelText: "Montant",
            hintText: "Montant",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: controller.handleCancelCapitalDialog,
                child: const Text("Annuler")),
            const SizedBox(
              width: 14,
            ),
            ElevatedButton(
                onPressed: controller.handleSaveCapital,
                child: const Text("Ajouter")),
          ],
        )
      ],
    );
  }
}
