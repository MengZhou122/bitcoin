import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const String apiKey = '011F9A03-3717-4833-BE2F-581319C4B818';
const String apiBKey = '9F5DBAB7-53CC-4842-9EAF-E1A11BA154E8';

class CoinData {
  Future<Map> getCoinData(String selectedCurrency) async {
    Map<String, String> map = Map();

    for (String crypto in cryptoList) {
      String url = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiBKey';
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var decodeData = await jsonDecode(response.body);
        double rate = await decodeData['rate'];
        map[crypto] = rate.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }

    return map;
  }
}
