import 'package:flutter/material.dart';
import 'package:flutter_agenda/screens/carts.dart';
import 'package:flutter_agenda/screens/products.dart';

void main() => runApp(ShopHistory());

class ShopHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Carts';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.shopping_cart)),
                Tab(icon: Icon(Icons.list_alt)),
              ],
            ),
            title: Text('Shopping History'),
          ),
          body: TabBarView(
            children: [
              CartsPage(title: 'Carts',),
              ProductsPage(title: 'Products'),
            ],
          ),
        ),
      ),
    );
  }
}