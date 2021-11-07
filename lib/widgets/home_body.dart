import 'package:flutter/material.dart';
import 'package:flutter_expense_manager/controllers/home_controller.dart';
import 'package:flutter_expense_manager/models/expense_model.dart';
import 'package:get/get.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: 'expenses_list',
        builder: (state) {
          final expenses = state.myAccount.expenses;
          if (expenses!.isNotEmpty) {
            return ListView.separated(
                padding: const EdgeInsets.only(top: 20),
                separatorBuilder: (_, i) => const Divider(),
                itemCount: expenses.length,
                itemBuilder: (_, i) =>
                    ExpenseListTile(index: i, data: expenses[i]));
          }
          return Center(
            child: Text("Vous n'avez pas d'article ici.",
                style: Theme.of(context).textTheme.caption),
          );
        });
  }
}

class ExpenseListTile extends GetView<HomeController> {
  final int index;
  final ExpenseModel data;

  const ExpenseListTile({Key? key, required this.index, required this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bool isFavorite = controller.favoriteExpense
            .indexWhere((element) => element.name == data.name) !=
        -1;
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => controller.handleOnDissmissExpense(index),
      background: Container(
        color: Colors.red[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.delete, color: Colors.white),
              Icon(Icons.delete, color: Colors.white),
            ],
          ),
        ),
      ),
      confirmDismiss: controller.handleConfirmDissmis,
      child: ListTile(
        leading: IconButton(
          icon: !isFavorite
              ? const Icon(Icons.book_outlined)
              : Icon(Icons.book_outlined,
                  color: Theme.of(context).primaryColor),
          onPressed: () => controller.toggleFavoriteExpense(index),
        ),
        trailing: Text("${data.amount}Ar"),
        title: Text(data.name!.capitalizeFirst!),
        subtitle: Text("Nombre: ${data.count}"),
      ),
    );
  }
}
