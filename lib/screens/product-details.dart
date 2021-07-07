import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'products.dart';

class ProductDetails extends StatelessWidget {
  Product product;


  ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${product.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.cyan,
                  )
              ),
              Text('Valor: ${product.value}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.lightBlueAccent,
                  )
              ),
            ],
          ),
        ),
        // ),
      ],
    );
  }
}

class ProductsDetailsPage extends StatelessWidget {
  final Product product;

  ProductsDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: ProductDetails(product: product),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(Icons.highlight_remove_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}