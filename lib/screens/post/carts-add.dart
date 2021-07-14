import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:equatable/equatable.dart";


import 'package:flutter_agenda/utils/format-real.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String jsonCart = '';

Future<http.Response> createCart() {
  return http.post(
    Uri.parse('https://api-fluttter.herokuapp.com/api/v1/carrinho/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonCart
  );
}

String makeJson(List<Product> products) {
  String json = '{"produtos": [';
  for (var product in products) {
    if(product.quantity > 0) {
      json += product.toString() + ',';
    }
  }
  json = json.substring(0, json.length-1);
  json += ']}';

  return json;
}


Future<List<Product>> fetchProducts(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://api-fluttter.herokuapp.com/api/v1/produto/'));

  return compute(parseProducts, response.body);
}

List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class Product extends Equatable {
  final int id;
  final String name;
  final double value;
  late int quantity = 0;

  Product({
    required this.id,
    required this.name,
    required this.value,
  });

  @override
  String toString() {
    return '{"id": ${this.id}, "quantidade": ${this.quantity}}';
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        name: json['nome'] as String,
        value: double.parse(json['valor'])
    );
  }

  String productToJson(Product data) => json.encode(data.toJson());

  Map<String, dynamic> toJson() => {
    "nome": name,
    "valor": value,
  };

  @override
  List<Object?> get props => [id, name, value, quantity];
}

class ProductSelectionList extends StatefulWidget {
  final List<Product> products;
  List<Product> get productList => this.products;

  ProductSelectionList({Key? key, required this.products}) : super(key: key);

  @override
  _ProductSelectionListState createState() => _ProductSelectionListState();
}

class _ProductSelectionListState extends State<ProductSelectionList> {
  int quantity = 0;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
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
                                  Text('${widget.products[index].name}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.cyan,
                                      )
                                  ),
                                ],
                              ),
                              subtitle: Text('R\$ ${realFormat.format(widget.products[index].value)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.lightBlueAccent,
                                  )
                              ),
                            )
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              splashRadius: 10,
                              onPressed: () {
                                if (widget.products[index].quantity > 0) {
                                  setState(() {
                                    widget.products[index].quantity--;
                                    });
                                  }
                                },
                                icon: Icon(Icons.remove),
                                color: Colors.black12,
                                iconSize: 16,
                              ),
                              Text('${widget.products[index].quantity}'),
                              IconButton(
                              splashRadius: 10,
                              onPressed: () {setState((){widget.products[index].quantity++;});},
                              icon: Icon(Icons.add),
                              color: Colors.lightBlueAccent,
                              iconSize: 16,
                            ),
                            Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {jsonCart = makeJson(widget.products);},
                              child: const Text('Adicionar'),
                            ),
                          ]
                        )
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

class CartAddPage extends StatelessWidget {

  CartAddPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Carrinho'),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ProductSelectionList(products: snapshot.data!)
              : Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(jsonCart);
          createCart();
          Navigator.pop(context);
        },
        child: const Icon(Icons.add_shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}