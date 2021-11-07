class ExpenseModel {
  final String? name;
  final double? amount;
  final int? count;
  bool isFavorite;

  ExpenseModel({this.name, this.amount, this.count, this.isFavorite = false});

  ExpenseModel.fromJsonToMap(Map<String, dynamic> map)
      : name = map['name'] as String,
        amount = map['amount'] as double,
        count = map['count'] as int,
        isFavorite = map['isFavorite'] as bool;

  double total() {
    return amount! * count!.toDouble();
  }
}
