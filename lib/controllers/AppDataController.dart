import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/model/category_model.dart';
import 'package:harcaa_v2/model/expense_model.dart';
import 'package:harcaa_v2/model/user_model.dart';
import 'package:harcaa_v2/model/card_model.dart';
import 'package:harcaa_v2/services/database_service.dart';

class AppDataController extends GetxController {
  final DatabaseService _databaseService = DatabaseService();

  var categorySelectedItem = "".obs;
  void upDateSelectedItemCategory(value) {
    categorySelectedItem.value = value;
  }

  var cardSelectedItem = "".obs;
  void upDateSelectedItemCard(value) {
    cardSelectedItem.value = value;
  }
  //--------------------------------------------------
  //--------------------HARCAMALAR------------------
  //--------------------------------------------------

  RxList<Expense> expenses = <Expense>[].obs;
  RxDouble mainTotalPrice = 0.0.obs;

  Future<void> fetchDatas() async {
    var allDatas = await _databaseService.fetchExpense();
    expenses.assignAll(allDatas);
  }

  void addExpense({String? title, String? category, DateTime? dateTime, double? price, String? card}) async {
    await _databaseService.addExpense(title: title, category: category, dateTime: dateTime, price: price, card: card);
    expenses.add(Expense()
      ..title = title
      ..category = category
      ..card = card
      ..dateTime = dateTime
      ..price = price);
  }

  void deleteExpense(int id) async {
    await _databaseService.deleteExpense(id);
    expenses.removeWhere((element) => element.id == id);
  }

  double totalExpense() {
    double total = 0;
    for (int i = 0; i < expenses.length; i++) {
      total += expenses[i].price ?? 0;
    }
    return total;
  }

  //--------------------------------------------------
  //--------------------KATEGORİLER------------------
  //--------------------------------------------------
  List<Category> defaultCategories = <Category>[
    Category()
      ..id = 1
      ..category = 'Yiyecek ve İçecek',
    Category()
      ..id = 2
      ..category = 'Temel Giderler',
    Category()
      ..id = 4
      ..category = 'Ulaşım',
    Category()
      ..id = 5
      ..category = 'Sağlık',
    Category()
      ..id = 6
      ..category = 'Eğlence ve Aktiviteler',
    Category()
      ..id = 7
      ..category = 'Kişisel Bakım',
    Category()
      ..id = 8
      ..category = 'Eğitim ve Gelişim',
  ];
  List<Category> cate = <Category>[];

  Future<void> deleteCategory(int id) async {
    await _databaseService.deleteCategory(id);
  }

  Future<void> addCategory(String category) async {
    await _databaseService.addCategory(category);
  }

  Future<void> fetchCategory() async {
    var allCategory = await _databaseService.fetchCategory();
    cate.assignAll(allCategory);
  }

  Future<void> initCategory() async {
    await _databaseService.initCategory(defaultCategories);
  }

  //--------------------------------------------------
  //--------------------KULLANICI------------------
  //--------------------------------------------------
  RxString name = RxString('');
  RxString mail = RxString('');
  Future<void> fetchUser() async {
    var user = await _databaseService.fetchUser();
    name.value = user!.name!;
    mail.value = user.mail!;
  }

  Future<void> updateUser(String? name, String? mail) async {
    await _databaseService.updateUser(
      User()
        ..id = 50779988
        ..name = name
        ..mail = mail,
    );
  }

  //--------------------------------------------------
  //--------------------KART------------------
  //--------------------------------------------------
  List<MyCard> cards = <MyCard>[];
  Future<void> fetchCard() async {
    var allCards = await _databaseService.fetchCard();
    cards.assignAll(allCards);
  }

  Future<void> addCard(String card) async {
    await _databaseService.addCard(card);
  }

  Future<void> deleteCard(int id) async {
    await _databaseService.deleteCard(id);
  }
}
