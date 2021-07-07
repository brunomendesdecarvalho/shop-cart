import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/screens/product-details.dart';
import 'package:http/http.dart' as http;


Future<List<Product>> fetchProducts(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://mockend.com/brunomendesdecarvalho/shop-cart/products'));

  return compute(parseProducts, response.body);
}

List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class Product {
  final int id;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;

  ProductsList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
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
                                    Text('${products[index].name}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.cyan,
                                        )
                                    ),
                                  ],
                                ),
                                subtitle: Text('${products[index].description}',
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
                          builder: (context) => ProductsDetailsPage(
                              product: this.products[index]
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

class ProductsPage extends StatelessWidget {
  final String title;

  ProductsPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ProductsList(products: snapshot.data!)
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