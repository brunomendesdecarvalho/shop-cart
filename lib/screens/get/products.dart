import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/screens/details/product-details.dart';
import 'package:flutter_agenda/screens/post/products-add.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_agenda/utils/format-real.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


Future<List<Product>> fetchProducts(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://api-fluttter.herokuapp.com/api/v1/produto/'));

  return compute(parseProducts, response.body);
}

List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class Product {
  final int id;
  final String name;
  final double value;

  Product({
    required this.id,
    required this.name,
    required this.value,
  });

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
}

class ProductsList extends StatefulWidget {
  final List<Product> products;

  ProductsList({Key? key, required this.products}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
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
                                    Text('${widget.products[index].name}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.cyan,
                                        )
                                    ),
                                  ],
                                ),
                                subtitle: Text('R\$ ${realFormat.format(widget.products[index].value)}',
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
                              product: this.widget.products[index]
                          )
                      )
                  );
                  setState(() {});
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

  ProductsPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProducts()),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}