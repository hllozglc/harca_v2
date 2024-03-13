import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/library/timeZone.dart';
import 'package:harcaa_v2/main.dart';
import 'package:harcaa_v2/model/currency_model.dart';
import 'package:harcaa_v2/model/expense_model.dart';
import 'package:harcaa_v2/services/api_service.dart';
import 'package:harcaa_v2/services/database_service.dart';
import 'package:harcaa_v2/views/analysis/viewPieChart.dart';
import 'package:harcaa_v2/widget/emptyData.dart';
import 'package:harcaa_v2/widget/mainMenuCard.dart';
import 'package:harcaa_v2/widget/myTextField.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppDataController _controller = Get.find<AppDataController>();
  double getCategoryPrice(String category) {
    List<Expense> expenses = _controller.expenses.where((p0) => p0.category == category).toList();
    double total = expenses.fold(0, (previousValue, element) => previousValue + element.price!);
    return total;
  }

  final ApiService _apiService = ApiService();
  void getCurrency() async {
    await _apiService.fetchCurrencyUSD();
    await _apiService.fetchCurrencyEUR();
  }

  @override
  void initState() {
    getCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double ort = _controller.totalExpense() / _controller.expenses.length;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(onPressed: () => print('click'), icon: const FaIcon(FontAwesomeIcons.solidBell, color: Colors.white)),
          IconButton(onPressed: () => Get.toNamed(routeSettings), icon: const FaIcon(FontAwesomeIcons.gear, color: Colors.white)),
        ],
        backgroundColor: MyColor.primaryColor,
        elevation: 0,
        title: Obx(
          () => RichText(
            text: TextSpan(
              text: 'Merhaba, ${_controller.name}',
              style: MyStyle.textStyle().copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: "\n${TimeHelper().timeZone()}", style: MyStyle.textStyle().copyWith(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(color: Colors.white, height: MediaQuery.of(context).size.height / 3),
              Container(
                padding: EdgeInsets.only(top: 20.h),
                height: 180.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  color: MyColor.primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xff05B6E6)),
                              padding: const EdgeInsets.all(16),
                              child: const FaIcon(FontAwesomeIcons.wallet, color: Colors.white),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'BÜTÇE DURUMU',
                                  style: MyStyle.titleStyle().copyWith(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                Obx(
                                  () => Text(
                                    '${_controller.totalExpense()} TL',
                                    style: MyStyle.titleStyle().copyWith(
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(routeAllExpense),
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(100)),
                              child: Text(
                                '${ort.toStringAsFixed(2)} Ort',
                                style: MyStyle.titleStyle().copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      MainMenuCard(
                        icon: FontAwesomeIcons.circlePlus,
                        title: 'Harca',
                        text: 'Yeni bir harcama ekleyin',
                        color: const Color(0xffDDF2FD),
                        onTap: () => Get.toNamed(routeAddExpense),
                      ),
                      SizedBox(height: 10.h),
                      MainMenuCard(
                        icon: FontAwesomeIcons.filter,
                        title: 'Filtrele',
                        text: 'Harcamalarınızı Filtreleyin.',
                        color: const Color(0xffDDF2FD),
                        onTap: () => Get.toNamed(routeFilter),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Döviz',
                  style: MyStyle.textStyle().copyWith(fontSize: 18),
                ),
                TextButton(
                    onPressed: () {
                      getCurrency();
                      setState(() {});
                    },
                    child: const Text('yenile'))
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: _currencyLayout(
                context: context,
                future: _apiService.fetchCurrencyUSD(),
                icon: FontAwesomeIcons.dollarSign,
                title: 'USD',
              )),
              Expanded(
                child: _currencyLayout(
                  context: context,
                  title: 'Euro',
                  future: _apiService.fetchCurrencyEUR(),
                  icon: FontAwesomeIcons.euroSign,
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, top: 20, left: 0, right: 0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          curveSmoothness: 0,
                          color: Colors.red,
                          barWidth: 1,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                          spots: [
                            FlSpot(1, 10),
                            FlSpot(2, 20),
                            FlSpot(3, 30),
                            FlSpot(4, 10),
                            FlSpot(5, 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    _controller.totalExpense() == 0
                        ? const Flexible(flex: 3, child: EmptyData(title: 'Null data'))
                        : Flexible(
                            flex: 3,
                            child: PieChart(
                              PieChartData(sectionsSpace: 2, centerSpaceRadius: 50, sections: [
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
                          ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(margin: const EdgeInsets.all(3), height: 10, width: 10, color: Colors.red),
                              const Text('Temel Giderler', maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Container(margin: const EdgeInsets.all(3), height: 10, width: 10, color: Colors.green),
                              const Text('Yiyecek ve İçecek', maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Container(margin: const EdgeInsets.all(3), height: 10, width: 10, color: Colors.blue),
                              const Text('Sağlık', maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Container(margin: const EdgeInsets.all(3), height: 10, width: 10, color: Colors.teal),
                              const Text('Ulaşım', maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Container(margin: const EdgeInsets.all(3), height: 10, width: 10, color: Colors.purple),
                              const Text('Eğlence ve Aktiviteler', maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Container(margin: const EdgeInsets.all(3), height: 10, width: 10, color: Colors.yellow),
                              const Text('Kişisel Bakım', maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Container(margin: const EdgeInsets.all(3), height: 10, width: 10, color: Colors.tealAccent),
                              const Text('Giyim ve Ayakkabı', maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            children: [
                              Container(margin: const EdgeInsets.all(3), height: 10, width: 10, color: Colors.grey),
                              const Text('Eğitim ve Gelişim', maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
      showTitle: false,
      color: color,
    );
  }

  Widget _currencyLayout({
    required BuildContext context,
    required Future<Currency>? future,
    required IconData icon,
    required String title,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [MyColor.primaryColor, MyColor.cardColor1]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, size: 45),
          title: Text(title),
          subtitle: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: LinearProgressIndicator(minHeight: 1),
                );
              } else {
                if (snapshot.hasData && snapshot.data != null) {
                  final currency = snapshot.data!;
                  final eurValue = currency.data?.TRY ?? 0.0;
                  return Text(
                    eurValue.toStringAsFixed(4),
                    style: MyStyle.textStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  );
                } else {
                  return const Text('null');
                }
              }
            },
          ),
        ));
  }

  Widget _rowItem({IconData? icon, Color? color, void Function()? onTap, String? title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: color ?? MyColor.primaryColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(1, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(icon, color: Colors.white),
            Text(
              title ?? 'Null',
              style: MyStyle.textStyle().copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
