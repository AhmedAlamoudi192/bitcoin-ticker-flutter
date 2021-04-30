import 'coin_data.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<String> price = ['?', '?', '?'];

  Widget iosPicker() {
    List<Widget> pickerItems = [
      for (String currency in currenciesList) Text(currency)
    ];

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (int value) {
        print(value);
      },
      children: pickerItems,
    );
  }

  Widget androidPicker() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [
      for (String currency in currenciesList)
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        )
    ];

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownMenuItems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            for (String type in cryptoList) {
              updatenumber(type);
            }
          },
        );
      },
    );
  }

  void updatenumber(String type) async {
    double number = await CoinData().getCoinData(selectedCurrency, type);
    setState(() {
      (type == "BTC")
          ? price[0] = number.toStringAsFixed(0)
          : (type == "ETH")
              ? price[1] = number.toStringAsFixed(0)
              : price[2] = number.toStringAsFixed(0);
    });
  }

  @override
  void initState() {
    super.initState();
    for (String type in cryptoList) {
      updatenumber(type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              createCard(price[0], selectedCurrency, cryptoList[0]),
              createCard(price[1], selectedCurrency, cryptoList[1]),
              createCard(price[2], selectedCurrency, cryptoList[2]),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}

Widget createCard(String price, String currency, String type) {
  return Padding(
    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
    child: Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $type = $price $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
