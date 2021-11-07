import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class AddExpenseDialog extends GetView<HomeController> {
  const AddExpenseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Enregistrer une dépense"),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          controller: controller.exprenseNameController,
          decoration: const InputDecoration(
            labelText: "Nom",
            hintText: "Nom",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          onChanged: controller.validateExpenseForm,
          keyboardType: TextInputType.number,
          controller: controller.exprenseAmountController,
          decoration: const InputDecoration(
            suffixText: "Ar",
            labelText: "Montant",
            hintText: "Montant",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Row(
          children: [
            GetX<HomeController>(builder: (state) {
              return Text("Nombre: ${state.currentExpenseItemCount.value}");
            }),
            const Spacer(),
            GetX<HomeController>(builder: (state) {
              return ElevatedButton(
                  onPressed: state.currentExpenseItemCount.value != 1
                      ? controller.handleRemoveExpenseItem
                      : null,
                  child: const Icon(Icons.remove));
            }),
            const SizedBox(width: 8),
            ElevatedButton(
                onPressed: controller.handleAppendExpenseItem,
                child: const Icon(Icons.add))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: controller.handleCancelExpenseDialog,
              child: const Text("Annuler"),
            ),
            const SizedBox(
              width: 14,
            ),
            GetX<HomeController>(builder: (state) {
              return ElevatedButton(
                onPressed: state.isExpenseFormValide.value
                    ? controller.handleSaveExpense
                    : null,
                child: const Text("Enregistrer"),
              );
            }),
          ],
        )
      ],
    );
  }
}
