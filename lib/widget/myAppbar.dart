import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/main.dart';

AppBar myAppBar({String? title,List<Widget>? actions}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    title: Text(
      title ?? 'Null',
      style: MyStyle.titleStyle().copyWith(color: Colors.white),
    ),
    backgroundColor: MyColor.primaryColor,
    centerTitle: true,
    actions: actions,
  );
}
