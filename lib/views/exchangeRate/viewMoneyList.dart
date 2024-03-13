import 'package:flutter/material.dart';
import 'package:harcaa_v2/constants/style.dart';
import 'package:harcaa_v2/services/api_service.dart';

class MoneyList extends StatefulWidget {
  const MoneyList({super.key});

  @override
  State<MoneyList> createState() => _MoneyListState();
}

class _MoneyListState extends State<MoneyList> {
  final ApiService _apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dolar'),
      ),
    );
  }
}
