import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/screens/get/products.dart';
import 'package:flutter_agenda/utils/format-real.dart';
import 'package:http/http.dart' as http;


Future<http.Response> deleteProduct(int id) async {
  final http.Response response = await http.delete(
    Uri.parse('http://api-fluttter.herokuapp.com/api/v1/produto/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}

class ProductDetails extends StatefulWidget {
  Product product;


  ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
              Text('${widget.product.name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.cyan,
                  )
              ),
              Text('Valor: R\$ ${realFormat.format(widget.product.value)}',
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
        title: Text('Detalhes do Produto')
      ),
      body: ProductDetails(product: product),
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
                  deleteProduct(this.product.id);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.highlight_remove_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}