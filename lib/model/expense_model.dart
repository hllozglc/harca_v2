import 'package:isar/isar.dart';

part 'expense_model.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;
  String? title;
  String? category;
  String? card;
  double? price;
  DateTime? dateTime;
}
