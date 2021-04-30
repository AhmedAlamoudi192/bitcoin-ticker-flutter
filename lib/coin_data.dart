import 'package:http/http.dart' as http;
import 'dart:convert';

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

class CoinData {
  CoinData();

  Future getCoinData(String currency,String type) async {
    Uri coinApibtc = Uri.parse(
        "https://rest.coinapi.io/v1/exchangerate/$type/$currency?apikey=FBE66C1C-023C-40A4-927B-8854ABC98623");
    http.Response btcResponse = await http.get(coinApibtc);
    if (btcResponse.statusCode != 200) {
      print('somthing went wrong');
      print(currency);
      print(btcResponse.statusCode);
      return;
    }
    print('all good');
    return jsonDecode(btcResponse.body)['rate'];
  }
}
