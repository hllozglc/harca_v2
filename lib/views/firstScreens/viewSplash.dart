import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/main.dart';
import 'package:harcaa_v2/services/api_service.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppDataController _controller = Get.find<AppDataController>();
  final ApiService _apiService = ApiService();
  void fetchDatas() async {
    await _controller.fetchDatas();
    print('Databasede ki  ${_controller.expenses.length} item, geçici listeye atandı');
    await _controller.fetchCategory();
    print('Databasede ki kategoriler geldi ${_controller.cate.length} item, geçici listeye atandı');
    await _controller.initCategory();
    print('Databasede ki kategoriler geldi ${_controller.cate.length} item, geçici listeye atandı');
    await _controller.fetchUser();
    await _controller.fetchCard();
  }

  @override
  void initState() {
    fetchDatas();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Get.offAllNamed(routeMain);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'HARCA',
            style: GoogleFonts.michroma(
              fontSize: 60,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Lottie.asset('assets/lottie/loadingLottie.json'),
          ),
        ],
      )),
    );
  }
}
