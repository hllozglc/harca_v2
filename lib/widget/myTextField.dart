import 'package:flutter/material.dart';
import 'package:harcaa_v2/constants/style.dart';

class MytextField extends StatelessWidget {
  const MytextField({super.key, required this.label, this.controller, this.validator, this.keyboard, this.initial, this.submit});
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final String? initial;
  final void Function(String)? submit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: submit,
      initialValue: initial,
      keyboardType: keyboard,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 8), labelStyle: TextStyle(color: MyColor.textColor.withOpacity(0.8)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4)), label: Text(label), border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))),
    );
  }
}
