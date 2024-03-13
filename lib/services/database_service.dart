import 'dart:async';

import 'package:harcaa_v2/model/card_model.dart';
import 'package:harcaa_v2/model/category_model.dart';
import 'package:harcaa_v2/model/expense_model.dart';
import 'package:harcaa_v2/model/user_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema, CategorySchema, UserSchema, MyCardSchema], directory: dir.path);
  }

  //--------------------------------------------------
  //--------------------HARCAMALAR------------------
  //--------------------------------------------------
  Future<void> addExpense({String? title, String? category, DateTime? dateTime, double? price, String? card}) async {
    final newExpens = Expense()
      ..title = title
      ..category = category
      ..card = card
      ..dateTime = dateTime
      ..price = price;
    await isar.writeTxn(() => isar.expenses.put(newExpens));
  }

  Future<void> deleteExpense(int id) async {
    await isar.writeTxn(() => isar.expenses.delete(id));
  }

  Future<List<Expense>> fetchExpense() async {
    List<Expense> allExpense = await isar.expenses.where().findAll();
    return allExpense.reversed.toList();
  }
  //--------------------------------------------------
  //--------------------KATEGORİLER------------------
  //--------------------------------------------------

  Future<void> deleteCategory(int id) async {
    await isar.writeTxn(() => isar.categorys.delete(id));
  }

  Future<void> addCategory(String category) async {
    final newCategory = Category()..category = category;
    await isar.writeTxn(() => isar.categorys.put(newCategory));
  }

  Future<void> initCategory(defaultCategories) async {
    await isar.writeTxn(() => isar.categorys.putAll(defaultCategories));
  }

  Future<List<Category>> fetchCategory() async {
    List<Category> allCategory = await isar.categorys.where().findAll();
    return allCategory.reversed.toList();
  }

  //--------------------------------------------------
  //--------------------KULLANICI------------------
  //--------------------------------------------------
  Future<User?> fetchUser() async {
    User? user = await isar.users.where().findFirst();
    return user;
  }

  Future<void> updateUser(User user) async {
    await isar.writeTxn(() => isar.users.put(user));
  }

  //--------------------------------------------------
  //--------------------KART-------------------------
  //--------------------------------------------------
  Future<List<MyCard>> fetchCard() async {
    List<MyCard> allCard = await isar.myCards.where().findAll();
    return allCard;
  }

  Future<void> addCard(String name) async {
    final newCard = MyCard()..name = name;
    await isar.writeTxn(() => isar.myCards.put(newCard));
  }

  Future<void> deleteCard(int id) async {
    await isar.writeTxn(() => isar.myCards.delete(id));
  }
}
