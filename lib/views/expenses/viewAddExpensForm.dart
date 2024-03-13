import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/main.dart';
import 'package:harcaa_v2/model/card_model.dart';
import 'package:harcaa_v2/model/category_model.dart';
import 'package:harcaa_v2/widget/myAppbar.dart';
import 'package:harcaa_v2/widget/myTextField.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final AppDataController _controller = Get.find<AppDataController>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController test = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> categoryNames = _controller.cate.map((Category category) => category.category!).toList();
    List<String> cardNames = _controller.cards.map((MyCard card) => card.name!).toList();

    return Scaffold(
      appBar: myAppBar(title: 'Harcama Ekle'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: MytextField(label: 'Başlık', controller: _titleController),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: MytextField(label: 'Fiyat', controller: _priceController),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton<String>(
                    hint: const Text('Kategori Seçiniz...'),
                    icon: const Icon(Icons.arrow_drop_down),
                    style: MyStyle.titleStyle().copyWith(fontSize: 16, color: MyColor.textColor.withOpacity(0.8)),
                    value: _controller.categorySelectedItem.value == "" ? null : _controller.categorySelectedItem.value,
                    items: categoryNames.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      _controller.upDateSelectedItemCategory(newValue.toString());
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton<String>(
                    hint: const Text('Kart Seçiniz...'),
                    icon: const Icon(Icons.arrow_drop_down),
                    style: MyStyle.titleStyle().copyWith(fontSize: 16, color: MyColor.textColor.withOpacity(0.8)),
                    value: _controller.cardSelectedItem.value == "" ? null : _controller.cardSelectedItem.value,
                    items: cardNames.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      _controller.upDateSelectedItemCard(newValue.toString());
                    },
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                try {
                  _controller.addExpense(title: _titleController.text, category: _controller.categorySelectedItem.value,card: _controller.cardSelectedItem.value, price: double.parse(_priceController.text) * -1, dateTime: DateTime.now());
                  print('Database add element');
                  Get.offAllNamed(routeMain);
                  Get.snackbar('Başarılı', 'Harcama Başarıyla Eklendi', backgroundColor: Colors.green.withOpacity(0.3));
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Ekle'))
        ],
      ),
    );
  }
}
