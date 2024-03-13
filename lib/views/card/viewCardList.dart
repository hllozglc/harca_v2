import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/widget/myAppbar.dart';
import 'package:harcaa_v2/widget/myTextField.dart';

class CardList extends StatefulWidget {
  const CardList({super.key});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final AppDataController _controller = Get.find<AppDataController>();
  final TextEditingController _cardName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Kartlarım',
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Ekle'),
                    content: MytextField(label: 'Kart Adı', controller: _cardName),
                    actions: [
                      TextButton(
                        child: const Text("Ekle"),
                        onPressed: () async {
                          await _controller.addCard(_cardName.text);
                          Get.back();
                          await _controller.fetchCard();
                          setState(() {});
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const FaIcon(FontAwesomeIcons.plus),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _controller.cards.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(_controller.cards[index].name!),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Uyarı"),
                      content: Text("'${_controller.cards[index].name}' kategorisini silmek istediğinize emin misiniz?"),
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
                            await _controller.deleteCard(_controller.cards[index].id);
                            Get.back();
                            await _controller.fetchCard();
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
