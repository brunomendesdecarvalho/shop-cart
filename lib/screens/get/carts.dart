import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/screens/details/cart-details.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Cart>> fetchCarts(http.Client client) async {
  String uri = 'https://api-fluttter.herokuapp.com/api/v1/carrinho/';
  final response = await client
      .get(Uri.parse(uri));

  return compute(parseCarts, response.body);
}

// A function that converts a response body into a List<Cart>.
List<Cart> parseCarts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
}

class Cart {
  final int id;
  final double total;
  final List<dynamic> products;

  Cart({
    required this.id,
    required this.total,
    required this.products
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as int,
      total: json['total'] as double,
      products: json['produtos'] as List<dynamic>
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
                                    Text('Nome do Produto x ${carts[index].products[0]['quantidade']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.cyan,
                                        )
                                    ),
                                  ],
                                ),
                                subtitle: Text('Valor total: ${carts[index].total}',
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

  CartsPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Compras'),
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