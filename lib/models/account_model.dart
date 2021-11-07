import 'expense_model.dart';

class AccountModel {
  double capital;
  List<ExpenseModel>? expenses;

  AccountModel({this.capital = 0.0, this.expenses});

  void addExpense(ExpenseModel expense) {
    expenses!.add(expense);
  }

  double compute() {
    double calc = capital;
    for (var element in expenses!) {
      calc -= element.total();
    }
    return calc;
  }
}
