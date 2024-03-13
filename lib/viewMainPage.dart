import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/views/expenses/viewAddExpensForm.dart';
import 'package:harcaa_v2/views/expenses/viewAllExpenseList.dart';
import 'package:harcaa_v2/views/home/viewHome.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 0;
  Widget getPages() {
    switch (_pageIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const AddExpense();
      case 2:
        return const AllExpenses();
      default:
        return const HomePage();
    }
  }

  void onItemTapped(int value) {
    setState(() {
      _pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPages(),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        color: MyColor.primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: () {
                setState(() {
                  _pageIndex = 0;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.house, color: _pageIndex == 0 ? MyColor.iconColor : MyColor.bgColor),
                  Text('Ana Sayfa', style: TextStyle(color: _pageIndex == 0 ? MyColor.iconColor : MyColor.bgColor)),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  _pageIndex = 2;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.list, color: _pageIndex == 2 ? MyColor.iconColor : MyColor.bgColor),
                  Text('Harcamalar', style: TextStyle(color: _pageIndex == 2 ? MyColor.iconColor : MyColor.bgColor)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _pageIndex == 1 ? MyColor.iconColor : MyColor.primaryColor,
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: MyColor.bgColor,
        ),
        onPressed: () {
          setState(() {
            _pageIndex = 1;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
