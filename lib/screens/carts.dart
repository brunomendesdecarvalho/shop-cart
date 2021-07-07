import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/screens/cart-details.dart';
import 'package:http/http.dart' as http;


Future<List<Cart>> fetchCarts(http.Client client) async {
  String uri = 'https://mockend.com/brunomendesdecarvalho/shop-cart/carts';
  final response = await client
      .get(Uri.parse(uri));

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

  Cart({
    required this.id,
    required this.owner,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as int,
      owner: json['owner'] as String,
    );
  }
}

class CartsList extends StatelessWidget {
  final List<Cart> carts;

  CartsList({Key? key, required this.carts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: carts.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
              child: InkWell(
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
                                    Text('${carts[index].owner}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.cyan,
                                        )
                                    ),
                                  ],
                                ),
                                subtitle: Text('Produtos aqui',
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartsDetailsPage(
                              cart: this.carts[index]
                          )
                      )
                  );
                },
              ),
            ),
          ],
        );
      },
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
              ? CartsList(carts: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}