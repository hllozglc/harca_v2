import 'package:isar/isar.dart';

part 'card_model.g.dart';

@collection
class MyCard {
  Id id = Isar.autoIncrement;
  String? name;
}
