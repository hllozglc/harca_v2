import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/controllers/AppDataController.dart';
import 'package:harcaa_v2/library/onboarding_items.dart';
import 'package:harcaa_v2/main.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:harcaa_v2/widget/myTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final AppDataController _controller = AppDataController();
  final OnboardingItems _onboardController = OnboardingItems();
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: isLastPage
            ? getStartedBtn()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () => _pageController.jumpToPage(_onboardController.items.length - 1), child: const Text("")),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _onboardController.items.length,
                    onDotClicked: (index) => _pageController.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                    effect: const WormEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                      activeDotColor: MyColor.buttonColor,
                    ),
                  ),
                  TextButton(onPressed: () => _pageController.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.easeIn), child: const Text("Next")),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: PageView.builder(
          onPageChanged: (value) => setState(() => isLastPage = _onboardController.items.length - 1 == value),
          controller: _pageController,
          itemCount: _onboardController.items.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(_onboardController.items[index].image!),
                SizedBox(height: 20.h),
                Text(
                  _onboardController.items[index].title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Text(
                  _onboardController.items[index].description ?? " ",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 17),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStartedBtn() {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColor.buttonColor,
      ),
      child: TextButton(
        onPressed: () {
          Get.bottomSheet(
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Theme.of(context).scaffoldBackgroundColor,
              height: 300.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MytextField(label: 'İsim', controller: _nameController),
                  SizedBox(height: 15.h),
                  MytextField(label: 'E-Posta', controller: _mailController),
                  ElevatedButton(
                    onPressed: () async {
                      final pref = await SharedPreferences.getInstance();
                      pref.setBool('onboarding', true);
                      if (!mounted) return;
                      Get.toNamed(routeMain);
                      await _controller.updateUser(_nameController.text, _mailController.text);
                    },
                    child: const Text('Başla'),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Text(
          'Devam',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
