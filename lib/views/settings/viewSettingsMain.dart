import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/main.dart';
import 'package:harcaa_v2/services/database_service.dart';
import 'package:harcaa_v2/widget/myAppbar.dart';
import 'package:harcaa_v2/widget/myTextField.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AppDataController _controller = Get.find<AppDataController>();

  @override
  Widget build(BuildContext context) {
    final DatabaseService _databaseService = DatabaseService();
    final AppDataController _controller = Get.find<AppDataController>();
    final TextEditingController _nameController = TextEditingController(text: _controller.name.value);
    final TextEditingController _mailController = TextEditingController(text: _controller.mail.value);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: myAppBar(title: 'Ayarlar', actions: [
          IconButton(
              onPressed: () async {
                if (_controller.name != _nameController.text || _controller.mail != _mailController.text) {
                  await _controller.updateUser(_nameController.text, _mailController.text);
                  await _controller.fetchUser();
                  FocusScope.of(context).unfocus();
                  Get.snackbar('Başarılı', 'Bilgileriniz Güncellendi');
                } else {
                  Get.snackbar('Hata', 'Bilgilerinizi kaydetmeden önce değişiklik yapınız');
                  FocusScope.of(context).unfocus();
                }
              },
              icon: const FaIcon(FontAwesomeIcons.check))
        ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150.h,
                padding: const EdgeInsets.symmetric(horizontal: 8),
               // color: Colors.red.withOpacity(0.1),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 55,
                          child: FaIcon(FontAwesomeIcons.user, size: 50),
                        )),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MytextField(label: 'Ad', controller: _nameController),
                          SizedBox(height: 10.h),
                          MytextField(label: 'E-Posta', controller: _mailController),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text('Kategoriler'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      tileColor: MyColor.bgColor,
                      onTap: () => Get.toNamed(routeCategoryList),
                    ),
                    SizedBox(height: 15.h),
                    ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text('Kartlarım'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      tileColor: MyColor.bgColor,
                      onTap: () => Get.toNamed(routeCardList),
                    ),
                    SizedBox(height: 15.h),
                    ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text('Analiz'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      tileColor: MyColor.bgColor,
                      onTap: () => Get.toNamed(routeCategoryChart),
                    ),
                    SizedBox(height: 15.h),
                    ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text('null'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      tileColor: MyColor.bgColor,
                      onTap: () => Get.toNamed(routeCategoryList),
                    ),
                    SizedBox(height: 15.h),
                    ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text('null'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      tileColor: MyColor.bgColor,
                      onTap: () => Get.toNamed(routeCategoryList),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
