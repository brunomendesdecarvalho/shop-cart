import 'package:flutter/material.dart';
import 'package:flutter_agenda/screens/get/carts.dart';
import 'package:flutter_agenda/screens/get/products.dart';


void main() => runApp(ShopHistory());

class ShopHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Shopping History';

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
            title: Text(appTitle),
          ),
          body: TabBarView(
            children: [
              CartsPage(),
              ProductsPage(),
            ],
          ),
        ),
      ),
    );
  }
}