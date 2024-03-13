import 'package:get/get.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';


class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AppDataController>(AppDataController());
  }
}
