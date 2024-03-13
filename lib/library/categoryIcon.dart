import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData? filterIcon(String categoryName) {
  switch (categoryName) {
    case 'Kişisel Bakım':
      return FontAwesomeIcons.soap;
    case 'Eğitim ve Gelişim':
      return FontAwesomeIcons.book;
    case 'Temel Giderler':
      return FontAwesomeIcons.bowlFood;
    case 'Eğlence ve Aktiviteler':
      return FontAwesomeIcons.wineBottle;
    case 'Ulaşım':
      return FontAwesomeIcons.bus;
    case 'Giyim ve Ayakkabı':
      return FontAwesomeIcons.shirt;
    case 'Sağlık':
      return FontAwesomeIcons.houseMedical;
    default:
      return FontAwesomeIcons.kitMedical;
  }
}
