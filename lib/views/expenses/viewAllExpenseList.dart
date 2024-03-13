import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/main.dart';
import 'package:harcaa_v2/widget/emptyData.dart';
import 'package:harcaa_v2/widget/myAppbar.dart';

class AllExpenses extends StatefulWidget {
  const AllExpenses({super.key});

  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  final AppDataController controller = Get.find<AppDataController>();
  void fetchDatas() async {
    await controller.fetchDatas();
  }

  @override
  void initState() {
    fetchDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('burası tüm harcamalar sayfası harcama sayısı ${controller.expenses.length}');
    return Scaffold(
      appBar: myAppBar(title: 'Tüm Harcamalar'),
      body: Obx(
        () => controller.expenses.isEmpty
            ? const EmptyData(title: 'Henüz hiç harcama eklemediniz !!!')
            : ListView.builder(
                itemCount: controller.expenses.length,
                itemBuilder: (context, index) {
                  var today = controller.expenses[index].dateTime;
                  String date = "${today!.day}/${today.month}/${today.year}";
                  return Dismissible(
                    onDismissed: (direction) => controller.deleteExpense(controller.expenses[index].id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    key: UniqueKey(),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ListTile(
                          title: Text(controller.expenses[index].title ?? 'Null'),
                          subtitle: Text('${controller.expenses[index].category ?? 'Null'} (${controller.expenses[index].card ?? 'Null'})'),
                          leading: const FaIcon(FontAwesomeIcons.arrowDown, color: Colors.red),
                          trailing: Text('${controller.expenses[index].price.toString()} TL'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(date.toString(), style: MyStyle.textStyle().copyWith(fontSize: 12)),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  

  /*  FutureBuilder<List<Expense>> _futureMethod() {
    return FutureBuilder(
      future: _databaseService.fetchExpense(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('Veri Bulunamadı'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var today = snapshot.data![index].dateTime;
              String date = "${today!.day}/${today.month}/${today.year}";
              return Dismissible(
                onDismissed: (direction) => constroller.deleteExpense(snapshot.data![index].id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                key: UniqueKey(),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ListTile(
                      title: Text(snapshot.data![index].title ?? 'Null'),
                      subtitle: Text(snapshot.data![index].category ?? 'Null'),
                      leading: const FaIcon(FontAwesomeIcons.arrowDown, color: Colors.red),
                      trailing: Text('${snapshot.data![index].price.toString()} TL'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(date.toString(), style: MyStyle.textStyle().copyWith(fontSize: 12)),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  } */
}
