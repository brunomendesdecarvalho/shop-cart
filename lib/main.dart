import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Cart>> fetchCarts(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://mockend.com/brunomendesdecarvalho/shop-cart/carts'));

  // Use the compute function to run parseCarts in a separate isolate.
  return compute(parseCarts, response.body);
}

// A function that converts a response body into a List<Cart>.
List<Cart> parseCarts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
}

class Cart {
  final int id;
  final String owner;
  // final String lastName;
  // final String address;
  // final String tradesCount24Hr;

  Cart({
    required this.id,
    required this.owner,
    // required this.lastName,
    // required this.priceUsd,
    // required this.tradesCount24Hr,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as int,
      owner: json['owner'] as String,
      // lastName: json['lastname'] as String,
      // priceUsd: json['priceUsd'] as String,
      // tradesCount24Hr: json['tradesCount24Hr'] as String,
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Carts';

    return MaterialApp(
      title: appTitle,
      home: CartsPage(title: appTitle),
    );
  }
}

class CartsPage extends StatelessWidget {
  final String title;

  CartsPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Cart>>(
        future: fetchCarts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? CartsList(Carts: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CartsList extends StatelessWidget {
  final List<Cart> Carts;

  CartsList({Key? key, required this.Carts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Carts.length,
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
                                  Text('${Carts[index].owner}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.cyan,
                                      )
                                  ),
                                ],
                              ),
                              subtitle: Text('Teste',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.lightBlueAccent,
                                  )
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