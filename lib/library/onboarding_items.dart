import 'package:harcaa_v2/model/onboarding_model.dart';

class OnboardingItems {
  List<Onboard> items = [
    Onboard(
      title: 'Hoş Geldin',
      description: 'Onboarding ekranı, bir mobil uygulamanın kullanıcılarını karşılamak ve uygulama hakkında bilgi vermek için tasarlanmış ',
      image: 'assets/lottie/lottie1.json',
    ),
    Onboard(
      title: 'İsim ve Mail',
      description: 'Harcamaya başlamadan önce sizden birkaç bilgi istiyoruz',
      image: 'assets/lottie/lottie2.json',
    )
  ];
}
