import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/expense_model.dart';

class FavoriteBody extends GetView<HomeController> {
  const FavoriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'favorite_list',
      builder: (state) {
        final favorites = state.favoriteExpense;
        if (favorites.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
            itemBuilder: (_, i) =>
                FavoriteListTile(data: favorites[i], index: i),
            separatorBuilder: (_, i) => const Divider(),
            itemCount: state.favoriteExpense.length,
          );
        }
        return Center(
          child: Text("Vous n'avez pas de dépense favoris",
              style: Theme.of(context).textTheme.caption),
        );
      },
    );
  }
}

class FavoriteListTile extends GetView<HomeController> {
  final ExpenseModel data;
  final int index;

  const FavoriteListTile({Key? key, required this.data, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: controller.handleConfirmDissmis,
      onDismissed: (direction) => controller.handleOnDissmisFavorite(index),
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
      child: Material(
        color: Theme.of(context).primaryColor.withOpacity(0.4),
        elevation: 0,
        child: ListTile(
          title: Text(data.name!),
          trailing: Text('${data.amount}'),
        ),
      ),
    );
  }
}
