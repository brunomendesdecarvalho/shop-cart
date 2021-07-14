import 'package:flutter/material.dart';
import 'package:flutter_agenda/screens/get/carts.dart';
import 'package:flutter_agenda/screens/get/products.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(ShopHistory());

class ShopHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Shopping History';

    return RefreshConfiguration(
      headerTriggerDistance: 80.0,
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed : true,
      child: MaterialApp(
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
      ),
    );
  }
}