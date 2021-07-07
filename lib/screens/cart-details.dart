import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'carts.dart';

class CartDetails extends StatelessWidget {
  Cart cart;


  CartDetails({Key? key, required this.cart}) : super(key: key);

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
              Text('Nome do Produto x ${cart.products[0]['quantidade']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.cyan,
                  )
              ),
              Text('Valor total: ${cart.total}',
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

class CartsDetailsPage extends StatelessWidget {
  final Cart cart;

  CartsDetailsPage({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: CartDetails(cart: cart),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(Icons.remove_shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}