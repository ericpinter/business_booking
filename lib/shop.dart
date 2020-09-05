import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tabs = ["Products", "Calendar"];
    var tabWidgets = [ProductWidget(), CalendarWidget()];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            isScrollable: false,
            tabs: [
              for (final label in tabs) Tab(text: label),
            ],
          ),
        ),
        body: TabBarView(children: [
          for (final widget in tabWidgets) Center(child: widget),
        ]),
      ),
    );
  }
}

class ProductWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductState();
}

class _ProductState extends State<ProductWidget> {
  List<Product> products = [];

  void promptAddProduct() {
    //TODO provide text boxes to create a new product, and save that product

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (final product in products)
              Card(
                child: Column(children: <Widget>[
                  Text(product.name),
                  Text("$product.price"),
                  Text("$product.timeToComplete"),
                ]),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: promptAddProduct,
          child: Icon(Icons.add),
        ));
  }
}

class Product {
  String name;
  double price;
  int timeToComplete;
}

class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarState();
}

class CalendarState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("hi");
  }
}
