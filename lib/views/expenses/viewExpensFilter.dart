import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/library/categoryIcon.dart';
import 'package:harcaa_v2/model/category_model.dart';
import 'package:harcaa_v2/model/expense_model.dart';
import 'package:harcaa_v2/widget/emptyData.dart';
import 'package:harcaa_v2/widget/myAppbar.dart';

class ExpenseFilter extends StatefulWidget {
  const ExpenseFilter({super.key});

  @override
  State<ExpenseFilter> createState() => _ExpenseFilterState();
}

class _ExpenseFilterState extends State<ExpenseFilter> {
  final AppDataController _controller = Get.find<AppDataController>();
  @override
  Widget build(BuildContext context) {
    List<String> categoryNames = _controller.cate.map((Category category) => category.category!).toList();
    List<Expense> filteredList = _controller.expenses.where((expense) => expense.category == _controller.categorySelectedItem.value).toList();
    double total = filteredList.fold(0, (previous, current) => previous + current.price!);
    return Scaffold(
      appBar: myAppBar(title: 'Filtre'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: DropdownButton(
                isExpanded: true,
                hint: const Text('Kategori Seçiniz...'),
                icon: const Icon(Icons.arrow_drop_down),
                style: MyStyle.titleStyle().copyWith(fontSize: 16, color: MyColor.textColor.withOpacity(0.8)),
                value: _controller.categorySelectedItem.value == "" ? null : _controller.categorySelectedItem.value,
                items: categoryNames.map<DropdownMenuItem>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  _controller.categorySelectedItem(newValue.toString());
                  setState(() {});
                },
              ),
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? const EmptyData(title: 'Liste boş')
                : ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      var model = filteredList[index];
                      return ListTile(
                        title: Text(model.title!),
                        subtitle: Text(model.category!),
                        trailing: Text('${model.price.toString()} TL'),
                        leading: FaIcon(filterIcon(model.category!), color: Colors.red),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(30.0),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Toplam:"),
                Text("${total.toString()} TL"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
