import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/model/expense_model.dart';
import 'package:harcaa_v2/widget/emptyData.dart';
import 'package:harcaa_v2/widget/myAppbar.dart';

class CategoryChart extends StatefulWidget {
  const CategoryChart({super.key});

  @override
  State<CategoryChart> createState() => _CategoryChartState();
}

class _CategoryChartState extends State<CategoryChart> {
  AppDataController appCtrl = Get.find<AppDataController>();
  double getCategoryPrice(String category) {
    List<Expense> expenses = appCtrl.expenses.where((p0) => p0.category == category).toList();
    double total = expenses.fold(0, (previousValue, element) => previousValue + element.price!);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(title: 'Raporlarma ve Grafik'),
      body: appCtrl.totalExpense() == 0
          ? const EmptyData(title: 'Grafikler için Bir Kaç Veri Gerekiyor')
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(sectionsSpace: 2, centerSpaceRadius: 90, sections: [
                          _chartItem('Temel Giderler', Colors.red),
                          _chartItem('Yiyecek ve İçecek', Colors.green),
                          _chartItem('Ulaşım', Colors.blue),
                          _chartItem('Sağlık', Colors.teal),
                          _chartItem('Eğlence ve Aktiviteler', Colors.purple),
                          _chartItem('Kişisel Bakım', Colors.yellow),
                          _chartItem('Giyim ve Ayakkabı', Colors.tealAccent),
                          _chartItem('Eğitim ve Gelişim', Colors.grey),
                        ]),
                      ),
                      Text(appCtrl.totalExpense().toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: appCtrl.cate.length,
                    itemBuilder: (context, index) {
                      var model = appCtrl.cate[index];
                      return ListTile(
                        title: Text(model.category ?? "null"),
                        trailing: Text(getCategoryPrice(model.category ?? "null").toString()),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  PieChartSectionData _chartItem(String category, Color color) {
    return PieChartSectionData(
      titleStyle: MyStyle.textStyle().copyWith(fontWeight: FontWeight.bold),
      value: getCategoryPrice(category),
      title: '$category\n${getCategoryPrice(category)}',
      color: color,
    );
  }
}
