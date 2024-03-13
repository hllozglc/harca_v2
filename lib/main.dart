import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/MainBindings.dart';
import 'package:harcaa_v2/services/database_service.dart';
import 'package:harcaa_v2/viewMainPage.dart';
import 'package:harcaa_v2/views/analysis/viewPieChart.dart';
import 'package:harcaa_v2/views/card/viewCardList.dart';
import 'package:harcaa_v2/views/category/viewCategoryList.dart';
import 'package:harcaa_v2/views/exchangeRate/viewMoneyList.dart';
import 'package:harcaa_v2/views/expenses/viewAddExpensForm.dart';
import 'package:harcaa_v2/views/expenses/viewAllExpenseList.dart';
import 'package:harcaa_v2/views/expenses/viewExpensFilter.dart';
import 'package:harcaa_v2/views/firstScreens/viewOnboard.dart';
import 'package:harcaa_v2/views/firstScreens/viewSplash.dart';
import 'package:harcaa_v2/views/home/viewHome.dart';
import 'package:harcaa_v2/views/settings/viewSettingsMain.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.initialize();
  MainBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) => GetMaterialApp(
        theme: ThemeData(
          primaryColor: MyColor.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Harca',
        initialRoute: '/',
        getPages: [
          GetPage(name: routeSplash, page: () => const SplashScreen()),
          GetPage(name: routeOnboarding, page: () => const Onboarding()),
          GetPage(name: routeMain, page: () => const MainPage()),
          GetPage(name: routeHome, page: () => const HomePage()),
          GetPage(name: routeAllExpense, page: () => const AllExpenses()),
          GetPage(name: routeAddExpense, page: () => const AddExpense()),
          GetPage(name: routeCategoryList, page: () => const CategoryList()),
          GetPage(name: routeFilter, page: () => const ExpenseFilter()),
          GetPage(name: routeMoneyList, page: () => const MoneyList()),
          GetPage(name: routeSettings, page: () => const Settings()),
          GetPage(name: routeCardList, page: () => const CardList()),
          GetPage(name: routeCategoryChart, page: () => const CategoryChart()),
        ],
      ),
    );
  }
}

String get routeSplash => '/';
String get routeOnboarding => '/onboarding';
String get routeMain => '/main';
String get routeHome => '/home';
String get routeAllExpense => '/allexpense';
String get routeAddExpense => '/addexpense';
String get routeCategoryList => '/categorylist';
String get routeFilter => '/expensefilter';
String get routeMoneyList => '/moneylist';
String get routeSettings => '/settings';
String get routeCardList => '/cardlist';
String get routeCategoryChart => '/categorychart';
