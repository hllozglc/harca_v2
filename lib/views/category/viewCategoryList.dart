import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/widget/myAppbar.dart';
import 'package:harcaa_v2/widget/myTextField.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final AppDataController _controller = Get.find<AppDataController>();
  final TextEditingController _categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Kategorilerim',
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Ekle'),
                      content: MytextField(label: 'Kategori Adı', controller: _categoryNameController),
                      actions: [
                        TextButton(
                          child: const Text("Ekle"),
                          onPressed: () async {
                            await _controller.addCategory(_categoryNameController.text);
                            Get.back();
                            await _controller.fetchCategory();
                            setState(() {
                              print('setstate');
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const FaIcon(FontAwesomeIcons.plus))
        ],
      ),
      body: ListView.builder(
        itemCount: _controller.cate.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(_controller.cate[index].category!),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Uyarı"),
                      content: Text("'${_controller.cate[index].category}' kategorisini silmek istediğinize emin misiniz?"),
                      actions: [
                        TextButton(
                          child: const Text("İptal"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: const Text("Evet"),
                          onPressed: () async {
                            await _controller.deleteCategory(_controller.cate[index].id);
                            Get.back();
                            await _controller.fetchCategory();
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
