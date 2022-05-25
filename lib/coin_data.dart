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

const apiKey = 'FE4E0FAF-3C7E-4706-A748-0D789A05CB3D';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {

  Future getCoinData(String selectedCurrency) async {
    Map <String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));
      // print(requestURL);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

        var latestPrice = decodedData['rate'];

        cryptoPrices[crypto] = latestPrice.toStringAsFixed(0);
      }
      else {
        print(response.statusCode);

        throw 'Problem with get request.';
      }
    }
    return cryptoPrices;
  }

}
