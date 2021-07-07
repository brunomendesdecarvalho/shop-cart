import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Coin>> fetchCoins(http.Client client) async {
  final response = await client
      .get(Uri.parse('http://172.31.176.1:8000/contato'));

  // Use the compute function to run parseCoins in a separate isolate.
  return compute(parseCoins, response.body);
}

// A function that converts a response body into a List<Coin>.
List<Coin> parseCoins(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Coin>((json) => Coin.fromJson(json)).toList();
}

class Coin {
  final String id;
  final String firstName;
  final String lastName;
  // final String address;
  // final String tradesCount24Hr;

  Coin({
    required this.id,
    required this.firstName,
    required this.lastName,
    // required this.priceUsd,
    // required this.tradesCount24Hr,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'] as String,
      firstName: json['firstname'] as String,
      lastName: json['lastname'] as String,
      // priceUsd: json['priceUsd'] as String,
      // tradesCount24Hr: json['tradesCount24Hr'] as String,
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Coins';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Coin>>(
        future: fetchCoins(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? CoinsList(Coins: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CoinsList extends StatelessWidget {
  final List<Coin> Coins;

  CoinsList({Key? key, required this.Coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: Coins.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
              child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Coins',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.cyan,
                                      )
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ],
        );
      },
    );
  }
}