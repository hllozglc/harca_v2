import 'package:flutter/material.dart';
import '../constants/style.dart';

class MainMenuCard extends StatelessWidget {
  const MainMenuCard({super.key, required this.icon, required this.title, required this.text, required this.color, required this.onTap});
  final IconData icon;
  final String title;
  final String text;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: ListTile(
          title: Text(title, style: MyStyle.titleStyle()),
          leading: Icon(icon, size: 40),
          subtitle: Text(text, style: MyStyle.textStyle()),
        ),
      ),
    );
  }
}
