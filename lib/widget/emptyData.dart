import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:harcaa_v2/constants/style.dart';


class EmptyData extends StatelessWidget {
  const EmptyData({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.circleExclamation,size: 50,color: MyColor.iconColor.withOpacity(0.3),),
            SizedBox(height: 20.h),
            Text(title,style: MyStyle.titleStyle().copyWith(color: MyColor.titleColor.withOpacity(0.3)),)
          ],
        ),
      )
    );
  }
}