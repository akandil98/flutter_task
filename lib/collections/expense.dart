import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? type;
  String? amount;
  DateTime? date;

  Expense({
    required this.type,
    required this.amount,
    required this.date,
  });
}
