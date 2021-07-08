import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/utils/format-real.dart';

import 'package:http/http.dart' as http;

import '../get/carts.dart';

Future<http.Response> deleteCart(int id) async {
  final http.Response response = await http.delete(
    Uri.parse('http://api-fluttter.herokuapp.com/api/v1/carrinho/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}

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
              Text('${cart.productsBought()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.cyan,
                  )
              ),
              Text('Valor total: R\$ ${realFormat.format(cart.total)}',
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
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('ATENÇÃO'),
            content: const Text('Tem certeza que deseja deletar este produto?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancelar'),
                child: const Text('Cancelar'),
              ),
              TextButton(
              onPressed: () {
                deleteCart(this.cart.id);
                Navigator.pop(context);
              },
              child: const Text('OK'),
              ),
            ],
          ),
      ),
        child: const Icon(Icons.remove_shopping_cart),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}