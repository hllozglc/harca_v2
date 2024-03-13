import 'dart:convert';

import 'package:harcaa_v2/model/currency_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String urlUSD = "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_M6cySYPTGFDDYMjLUrlyOAirFNMD77MhanhKMR5x&currencies=TRY";
  final String urlEUR = "https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_M6cySYPTGFDDYMjLUrlyOAirFNMD77MhanhKMR5x&currencies=TRY&base_currency=EUR";
  Future<Currency> fetchCurrencyUSD() async {
    var response = await http.get(Uri.parse(urlUSD));
    var jsonBody = Currency.fromJson(jsonDecode(response.body));
    return jsonBody;
  }

  Future<Currency> fetchCurrencyEUR() async {
    var response = await http.get(Uri.parse(urlEUR));
    var jsonBody = Currency.fromJson(jsonDecode(response.body));
    return jsonBody;
  }
}
