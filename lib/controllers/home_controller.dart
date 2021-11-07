import 'package:flutter/material.dart';
import 'package:flutter_expense_manager/models/expense_model.dart';
import '../models/Account_model.dart';
import '../widgets/add_capital_dialog.dart';
import '../widgets/add_expense_dialog.dart';
import '../widgets/favorite_body.dart';
import '../widgets/home_body.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;

  final List<ExpenseModel> favoriteExpense = [];

  final List<BottomNavigationBarItem> bottomNavbarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border), label: "Favoris"),
  ];

  final ktabPages = <Widget>[const HomeBody(), const FavoriteBody()];

  final myAccount = AccountModel(capital: 0, expenses: []);

  final TextEditingController capitalController = TextEditingController();
  final TextEditingController exprenseNameController = TextEditingController();
  final TextEditingController exprenseAmountController =
      TextEditingController();

  RxInt currentExpenseItemCount = 1.obs;

  RxBool isExpenseFormValide = false.obs;
  RxBool isCapitalFormValide = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: ktabPages.length,
      vsync: this,
    )..addListener(() {
        update(['bottom_navbar']);
      });
  }

  void handleOnTapBottomNavbar(int value) {
    tabController.animateTo(value);
  }

  void handlePressFloatingActionButton() {
    Get.dialog(const AddExpenseDialog(), barrierDismissible: false);
  }

  void handlePressAmount() {
    Get.dialog(const AddCapitalDialog(), barrierDismissible: false);
  }

  void handleAppendExpenseItem() {
    currentExpenseItemCount.value++;
  }

  void handleRemoveExpenseItem() {
    currentExpenseItemCount.value--;
  }

  void handleCancelExpenseDialog() {
    cleanExpenseControllers();
    Get.back();
  }

  void cleanCapitalControllers() {
    capitalController.clear();
  }

  void cleanExpenseControllers() {
    exprenseAmountController.clear();
    exprenseNameController.clear();
    currentExpenseItemCount.value = 1;
  }

  void handleSaveExpense() {
    final ExpenseModel expense = ExpenseModel(
        name: exprenseNameController.text,
        amount: double.parse(exprenseAmountController.text),
        count: currentExpenseItemCount.value);
    if (myAccount.compute() >= expense.total()) {
      myAccount.addExpense(expense);
      cleanExpenseControllers();
      Get.back();
      update(['expenses_list', 'capital']);
    } else {
      Get.snackbar("Erreur", "Votre montant dépasse votre capital actuel",
          backgroundColor: Get.theme.primaryColor, borderRadius: 8);
    }
  }

  void validateCapitalForm(String value) {
    if (capitalController.text.isNotEmpty &&
        capitalController.text.isNumericOnly) {
      isCapitalFormValide.value = true;
    } else {
      isCapitalFormValide.value = false;
    }
  }

  void validateExpenseForm(String value) {
    if (exprenseNameController.text.isNotEmpty &&
        exprenseAmountController.text.isNumericOnly &&
        exprenseAmountController.text.isNotEmpty) {
      isExpenseFormValide.value = true;
    } else {
      isExpenseFormValide.value = false;
    }
  }

  void handleCancelCapitalDialog() {
    cleanCapitalControllers();
    Get.back();
  }

  void handleSaveCapital() {
    myAccount.capital += double.parse(capitalController.text);
    cleanCapitalControllers();
    Get.back();
    update(['capital']);
  }

  void toggleFavoriteExpense(int index) {
    ExpenseModel expense = myAccount.expenses!.elementAt(index);
    if (favoriteExpense.indexWhere((element) => element.name == expense.name) ==
        -1) {
      expense.isFavorite = !expense.isFavorite;
      favoriteExpense.add(expense);
    } else {
      expense.isFavorite = !expense.isFavorite;
      favoriteExpense.removeWhere((element) => element.name == expense.name);
    }
    update(['expenses_list', 'favorite_list']);
  }

  Future<bool?> handleConfirmDissmis(DismissDirection direction) async {
    final bool res = await Get.dialog(
        AlertDialog(
          title: const Text("Attention"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: const Text("Annuler")),
            ElevatedButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: const Text("Supprimer")),
          ],
        ),
        barrierDismissible: false);
    return res;
  }

  void handleOnDissmisFavorite(int index) {
    ExpenseModel expense = myAccount.expenses!.elementAt(index);
    expense.isFavorite = !expense.isFavorite;
    favoriteExpense.removeWhere((element) => element.name == expense.name);
    update(['expenses_list', 'favorite_list']);
  }

  void handleOnDissmissExpense(int index) {
    ExpenseModel expense = myAccount.expenses!.elementAt(index);
    myAccount.expenses!.removeWhere((element) => element.name == expense.name);
    update(['expenses_list', 'favorite_list', 'capital']);
  }
}
